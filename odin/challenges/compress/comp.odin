package comp

import pq "core:container/priority_queue"
import "core:fmt"
import "core:io"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"

Node :: struct {
	letter:  u8,
	weight:  u64,
	is_leaf: bool,
	left:    ^Node,
	right:   ^Node,
}


build_header :: proc(queue: ^pq.Priority_Queue(^Node)) -> []u8 {
	sb: strings.Builder
	sb = strings.builder_init(&sb)^
	defer strings.builder_destroy(&sb)

	for freq in queue.queue {
		strings.write_byte(&sb, freq.letter)
		strings.write_byte(&sb, ',')
		strings.write_u64(&sb, freq.weight)
		strings.write_byte(&sb, ',')
	}
	strings.write_byte(&sb, 254)

	return transmute([]u8)strings.clone(strings.to_string(sb))
}

build_huffman_tree :: proc(queue: ^pq.Priority_Queue(^Node)) -> ^Node {
	for pq.len(queue^) > 1 {
		a := pq.pop(queue)
		b := pq.pop(queue)
		new_node := new(Node)
		new_node.is_leaf = false
		new_node.left = a.weight > b.weight ? b : a
		new_node.right = a.weight > b.weight ? a : b
		new_node.weight = a.weight + b.weight
		pq.push(queue, new_node)
	}
	return pq.pop(queue)
}

_helper :: proc(base: ^Node, path: []u8, path_len: uint, lookup: ^map[u8][]u8) {
	new_path := path
	path_len := path_len
	if base.is_leaf {
		lookup[base.letter] = slice.clone(path[:path_len])
		return
	} else {
		new_path[path_len] = 0
		_helper(base.left, new_path, path_len + 1, lookup)
		new_path[path_len] = 1
		_helper(base.right, new_path, path_len + 1, lookup)
	}
}

build_lookup_table :: proc(base: ^Node) -> map[u8][]u8 {
	res: map[u8][]u8
	path: [1024]u8
	_helper(base, path[:], 0, &res)
	return res
}

destroy_lookup_table :: proc(lookup: ^map[u8][]u8) {
	for k, v in lookup {
		delete(v)
	}
	delete(lookup^)
}

encrypt_huffman_tree :: proc(base: ^Node, text: []u8, lookup: map[u8][]u8) -> []u8 {
	sb_base: strings.Builder
	sb := strings.builder_init(&sb_base)
	defer strings.builder_destroy(sb)

	b: u8
	offset: uint = 0

	for letter in text {
		if letter in lookup {
			path := lookup[letter]
			for bit in path {
				b |= bit
				if offset == 7 {
					strings.write_byte(sb, b)
					b = 0
					offset = 0
				} else {
					b <<= 1
					offset += 1
				}
			}
		} else {
			fmt.eprintf("Letter: %c doesn' t contains in lookup table", letter)
			panic("I'm done")
		}
	}

	if offset != 0 && offset < 7 {
		strings.write_byte(sb, b)
	}
	res := slice.clone(sb.buf[:strings.builder_len(sb^)])
	return res
}

wolk_huffman_tree :: proc(base: ^Node, layer: int) {
	if base.is_leaf {
		fmt.printf("Char: %c, frequency: %d ==> LAYER: %d\n", base.letter, base.weight, layer)
	} else {
		fmt.println("WEIGHT:", base.weight, "Going left side ==> LAYER:", layer)
		wolk_huffman_tree(base.left, layer + 1)

		fmt.println("WEIGHT:", base.weight, "Going right side ==> LAYER:", layer)
		wolk_huffman_tree(base.right, layer + 1)
	}
}

write_encrypt_file :: proc(header: []u8, encrypt_buf: []u8, file_name: string) {
	encrypt_name := strings.concatenate(
		[]string{file_name[:strings.index(file_name, ".")], ".", "hf"},
	)
	defer delete(encrypt_name)

	encrypt_file, encrypt_file_ok := os.open(
		encrypt_name,
		os.O_CREATE | os.O_RDWR,
		os.S_IRUSR | os.S_IWUSR | os.S_IRGRP | os.S_IWGRP,
	)
	if encrypt_file_ok != nil {
		fmt.eprintln("Cant create file:", encrypt_name)
	}
	defer os.close(encrypt_file)
	encrypt_write_bytes, _ := os.write(encrypt_file, header)

	_, _ = os.write(encrypt_file, encrypt_buf)
}

destroy_huffman_tree :: proc(base: ^Node) {
	if base != nil {
		if base.is_leaf {
			free(base)
		} else {
			destroy_huffman_tree(base.left)
			destroy_huffman_tree(base.right)
			free(base)
		}
	}
}

less :: proc(a, b: ^Node) -> bool {
	if a.weight < b.weight {
		return true
	}
	if a.weight > b.weight {
		return false
	}
	if a.is_leaf && b.is_leaf {
		if a.letter < b.letter {
			return true
		} else {
			return false
		}
	}
	return false
}

swap :: proc(f: []^Node, i, j: int) {
	tmp: ^Node = f[i]
	f[i] = f[j]
	f[j] = tmp
}

build_table :: proc(buf: []u8) -> map[u8]int {
	res: map[u8]int

	for b in buf {
		if b in res {
			res[b] += 1
		} else {
			res[b] = 1
		}
	}
	return res
}

encrypt_header :: proc(header: []u8, key: u8) {
	key := key
	for &c in header {
		c ~= key
		key += 1
	}
}

read_header :: proc(buf: []u8) -> (map[u8]u64, int) {
	i: int
	letter: u8
	freq_num: [dynamic]u8
	header_map: map[u8]u64
	defer delete(freq_num)
	for {
		if buf[i] == 254 {
			break
		}
		letter = buf[i]
		i += 1
		if buf[i] == ',' {
			i += 1
		}
		for buf[i] != ',' {
			append(&freq_num, buf[i])
			i += 1
		}
		i += 1
		num, num_ok := strconv.parse_u64(transmute(string)freq_num[:len(freq_num)])
		if num_ok {
			header_map[letter] = num
		}
		clear(&freq_num)
	}

	i += 1
	return header_map, i
}

decrypt :: proc(base: ^Node, text: []u8) -> []u8 {
	res: [dynamic]u8
	defer delete(res)
	offset: u32 = 7
	cur_node := base
	for b in text {
		inner: for {
			if ((b >> offset) & 0x1) == 1 {
				if cur_node.right.is_leaf {
					append(&res, cur_node.right.letter)
					cur_node = base
				} else {
					cur_node = cur_node.right
				}
			} else {
				if cur_node.left.is_leaf {
					append(&res, cur_node.left.letter)
					cur_node = base
				} else {
					cur_node = cur_node.left
				}
			}
			if offset == 0 {
				offset = 7
				break inner
			}
			offset -= 1
		}
	}


	return slice.clone(res[0:len(res)])
}


main :: proc() {
	when ODIN_DEBUG {
		track: mem.Tracking_Allocator
		mem.tracking_allocator_init(&track, context.allocator)
		context.allocator = mem.tracking_allocator(&track)
	}
	defer {
		when ODIN_DEBUG {
			for _, leak in track.allocation_map {
				fmt.printf("%v leaked %m\n", leak.location, leak.size)
			}
			mem.tracking_allocator_destroy(&track)
		}
	}

	if os.args[1] == "-e" && len(os.args) == 3 {
		decrypt_file, decrypt_file_ok := os.open(os.args[2])
		if decrypt_file_ok != nil {
			fmt.println("Cant open file for decrypt:", os.args[2])
			return
		}
		defer os.close(decrypt_file)
		decrypt_file_stat, decrypt_file_stat_ok := os.fstat(decrypt_file)
		if decrypt_file_stat_ok != nil {
			fmt.eprintln("Cant open file stat:", os.args[2])
			return
		}
		defer os.file_info_delete(decrypt_file_stat)
		decrypt_buf := make([]u8, decrypt_file_stat.size)
		defer delete(decrypt_buf)
		decrypt_read, decrypt_read_ok := os.read(decrypt_file, decrypt_buf)
		if decrypt_read_ok != nil {
			fmt.eprintln("Cant read file:", os.args[2])
			return
		}

		header_map, buf_index := read_header(decrypt_buf)
		defer delete(header_map)

		// for k, v in header_map {
		// 	fmt.printf("Char: %c, frequency: %d\n", k, v)
		// }

		decrypt_pq: pq.Priority_Queue(^Node)
		pq.init(&decrypt_pq, less, swap)
		defer pq.destroy(&decrypt_pq)

		for k, v in header_map {
			tmp := new(Node)
			tmp.weight = u64(v)
			tmp.letter = k
			tmp.left = nil
			tmp.right = nil
			tmp.is_leaf = true
			pq.push(&decrypt_pq, tmp)
		}

		base := build_huffman_tree(&decrypt_pq)
		defer destroy_huffman_tree(base)
		result := decrypt(base, decrypt_buf[buf_index + 1:])
		defer delete(result)

		fmt.println("Result len:", len(result))
		//fmt.println(transmute(string)result)

    new_file, new_file_ok := os.open("result.txt", os.O_CREATE | os.O_RDWR, os.S_IRUSR | os.S_IWUSR | os.S_IRGRP | os.S_IWGRP)
    if new_file_ok != nil {
      fmt.eprintln("Can't create file after decrypting")
      return
    }
    defer os.close(new_file)
    os.write(new_file, result)

		return
	}


	queue: pq.Priority_Queue(^Node)

	pq.init(&queue, less, swap)
	defer pq.destroy(&queue)


	if len(os.args) < 2 {
		fmt.eprintf("Usage comp [file_name]\n")
		return
	}

	f, f_ok := os.open(os.args[1])
	if f_ok != nil {
		fmt.eprintln("Cant open file:", os.args[1])
		return
	}

	defer os.close(f)
	stat, stat_ok := os.fstat(f)
	if stat_ok != nil {
		fmt.eprintln("os.fstat error")
		return
	}
	defer os.file_info_delete(stat)

	buf: []u8 = make([]u8, stat.size)
	defer delete(buf)

	reader := io.to_reader(os.stream_from_handle(f))

	read_bytes, read_err := io.read(reader, buf)
	if read_err != nil {
		fmt.eprintln("read error")
		return
	}
	table := build_table(buf)
	defer delete(table)

	for k, v in table {
		tmp := new(Node)
		tmp.weight = u64(v)
		tmp.letter = k
		tmp.left = nil
		tmp.right = nil
		tmp.is_leaf = true
		pq.push(&queue, tmp)
	}

	header := build_header(&queue)
	defer delete(header)
	fmt.println(transmute(string)header)


	base := build_huffman_tree(&queue)
	//wolk_huffman_tree(base, 0)

	lookup := build_lookup_table(base)
	defer destroy_lookup_table(&lookup)

	encrypt_buf := encrypt_huffman_tree(base, buf, lookup)
	defer delete(encrypt_buf)

	write_encrypt_file(header, encrypt_buf, os.args[1])

	// for k, v in lookup {
	//   fmt.printf("Char: %c, path: %v\n", k, v)
	//   delete(v)
	// }

	destroy_huffman_tree(base)

	// for pq.len(queue) > 0 {
	//   tmp := pq.pop(&queue)
	//   fmt.println(tmp)
	// }


}
