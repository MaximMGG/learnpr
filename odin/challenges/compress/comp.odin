package comp

import "core:fmt"
import "core:os"
import "core:io"
import "core:mem"
import "core:strings"
import pq "core:container/priority_queue"

Frequency :: struct {
  letter: u8,
  frequency: u64,
}

Node :: struct {
  freq: Frequency,
  left: ^Node,
  right: ^Node,
  weight: u64,
  is_leaf: bool
}


build_header :: proc(queue: ^pq.Priority_Queue(Frequency)) -> []u8 {
  sb: strings.Builder
  sb = strings.builder_init(&sb)^
  defer strings.builder_destroy(&sb)

  for freq in queue.queue {
    strings.write_byte(&sb, freq.letter)
    strings.write_byte(&sb, ',')
    strings.write_u64(&sb, freq.frequency)
    strings.write_byte(&sb, ',')
  }
  strings.write_byte(&sb, ';')

  return transmute([]u8)strings.clone(strings.to_string(sb))
}

build_huffman_tree :: proc(queue: ^pq.Priority_Queue(Frequency)) -> ^Node {
  a: Frequency = pq.pop(queue)
  b: Frequency = pq.pop(queue)

  a_node: ^Node = new(Node)
  a_node.freq = a
  a_node.is_leaf = true
  a_node.weight = a.frequency

  b_node: ^Node = new(Node)
  b_node.freq = b
  b_node.is_leaf = true
  b_node.weight = b.frequency

  base: ^Node = new(Node)
  base.is_leaf = false
  base.weight = a_node.weight + b_node.weight
  base.left = a.frequency > b.frequency ? b_node : a_node
  base.right = a.frequency > b.frequency ? a_node : b_node

  for pq.len(queue^) > 0 {
    tmp_freq := pq.pop(queue)
    if tmp_freq.frequency < base.weight {
      a_node := new(Node)
      a_node.freq = tmp_freq
      a_node.is_leaf = true
      a_node.left = nil
      a_node.right = nil
      a_node.weight = tmp_freq.frequency
      b_node = base

      base = new(Node)
      base.weight = a_node.weight + b_node.weight
      base.left = a_node
      base.right = b_node
      base.is_leaf = false
      continue
    } else if tmp_freq.frequency > base.weight {
      b_node := new(Node)
      b_node.freq = tmp_freq
      b_node.is_leaf = true
      b_node.left = nil
      b_node.right = nil
      b_node.weight = tmp_freq.frequency
      a_node = base

      base = new(Node)
      base.weight = a_node.weight + b_node.weight
      base.left = a_node
      base.right = b_node
      base.is_leaf = false
    } 
  }
  return base
}

wolk_huffman_tree :: proc(base: ^Node) {
  fmt.println("Base weight:", base.weight)
  if base.is_leaf {
    fmt.printf("Char: %c, frequency: %d\n", base.freq.letter, base.freq.frequency)
  } else {
    wolk_huffman_tree(base.left)
    wolk_huffman_tree(base.right)
  }
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

less :: proc(a, b: Frequency) -> bool {
  if a.frequency < b.frequency {
    return true
  }
  return false
} 

swap :: proc(f: []Frequency, i, j: int) {
  tmp: Frequency =  f[i]
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

  queue: pq.Priority_Queue(Frequency)

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
    tmp := Frequency{letter = k, frequency = u64(v)}
    pq.push(&queue, tmp)
  }

  header := build_header(&queue)
  fmt.printf("%s\n", transmute(string)header)
  encrypt_header(header, 12)
  fmt.printf("\n\n")
  fmt.printf("%s\n", transmute(string)header)
  encrypt_header(header, 12)
  fmt.printf("\n\n")
  fmt.printf("%s\n", transmute(string)header)

  fmt.println("Header len:", len(header))

  _len := u32(len(header))
  p: ^u8 = transmute(^i8)&_len

  // base := build_huffman_tree(&queue)
  // wolk_huffman_tree(base)
  // destroy_huffman_tree(base)

  // for pq.len(queue) > 0 {
  //   tmp := pq.pop(&queue)
  //   fmt.println(tmp)
  // }



  // when ODIN_DEBUG {
  //   for k, v in table {
  //     fmt.printf("%c(%d) appeard %d types\n", k, k, v)
  //   }
  // }
}
