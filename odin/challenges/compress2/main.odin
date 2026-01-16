package main



import "core:testing"
import "core:fmt"
import "core:os"
import "core:slice"
import pq "core:container/priority_queue"

Node :: struct {
  letter: byte,
  freq: u32,
  is_leaf: bool,
  left: ^Node,
  right: ^Node,
}

less :: proc(a: ^Node, b: ^Node) -> bool {
  if a.freq < b.freq {
    return true
  } else if a.freq > b.freq {
    return false
  } else {
    if a.letter < b.letter {
      return true
    } else if a.letter > b.letter {
      return false
    }
  }
  return false
}

swap :: proc(arr: []^Node, i, j: int) {
  slice.swap(arr, i, j)
}

build_freq :: proc(text: []byte) -> map[byte]u32 {
  freq: map[byte]u32

  for c in text {
    if c in freq {
      freq[c] += 1
    } else {
      freq[c] = 1
    }
  }

  return freq
}

build_queue :: proc(freq: ^map[byte]u32, q: ^pq.Priority_Queue(^Node)) {
  for k, v in freq {
    n := new(Node)
    n.letter = k
    n.freq = v
    n.is_leaf = true
    n.left = nil
    n.right = nil
    pq.push(q, n)
  }
}

build_huffman_tree :: proc(q: ^pq.Priority_Queue(^Node)) -> ^Node {
  index: int = 0
  for pq.len(q^) != 1 {
    a := pq.pop(q)
    b := pq.pop(q)
    new_node := new(Node)
    new_node.letter = byte(index)
    index += 1
    new_node.is_leaf = false
    new_node.freq = a.freq + b.freq
    new_node.left = a
    new_node.right = b
    pq.push(q, new_node)
  }

  return pq.pop(q)
}

wolk_huffman_tree :: proc(base: ^Node, layer: int) {
  if base.is_leaf {
    fmt.printfln("Char: %c, freq: %d, LAYER: %d", base.letter, base.freq, layer)
  } else {
    if base.left != nil {
      fmt.printfln("LAYER: %d, freq: %d going LEFT", layer, base.freq)
      wolk_huffman_tree(base.left, layer + 1)
    } 
    if base.right != nil {
      fmt.printfln("LAYER: %d, freq: %d going RIGHT", layer, base.freq)
      wolk_huffman_tree(base.right, layer + 1)
    }
  }
}

build_lookup_helper :: proc(base: ^Node, path: ^[]u8, path_len: u32, lookup: ^map[byte][]u8) {
  if base.is_leaf {
    lookup[base.letter] = slice.clone(path[:path_len])
  } else {
    if base.left != nil {
      path[path_len] = 0
      build_lookup_helper(base.left, path, path_len + 1, lookup)
    }
    if base.right != nil {
      path[path_len] = 1
      build_lookup_helper(base.right, path, path_len + 1, lookup)
    }
  }
}

build_lookup :: proc(base: ^Node) -> map[byte][]u8 {
  lookup: map[byte][]u8
  path := make([]u8, 128)
  defer delete(path)
  build_lookup_helper(base, &path, 0, &lookup)
  return lookup
}
destroy_huffman_tree :: proc(base: ^Node) {
  if base.left != nil {
    destroy_huffman_tree(base.left)
  }
  if base.right != nil {
    destroy_huffman_tree(base.right)
  }
  free(base)
}

destroy_lookup :: proc(lookup: map[byte][]u8) {
  for _, v in lookup {
    delete(v)
  }
}

process_encrypt :: proc(file: string) {
  f, f_ok := os.open(file, os.O_RDONLY)
  if f_ok != nil {
    fmt.eprintln("Can't open file:", file)
    return
  }
  stat, stat_ok := os.fstat(f)
  if stat_ok != nil {
    fmt.eprintln("File stat error:", stat_ok)
    return
  }
  buf := make([]byte, stat.size)
  defer delete(buf)
  read_bytes, read_err := os.read(f, buf)
  if read_err != nil {
    fmt.eprintln("os.read err:", read_err)
    delete(buf)
  }

  freq := build_freq(buf)
  defer delete(freq)

  if ODIN_DEBUG {
    for k, v in freq {
      fmt.printf("Char: %c, freq: %d\n", k, v)
    }
  }

  q: pq.Priority_Queue(^Node)
  pq.init(&q, less, swap)
  defer pq.destroy(&q)
  build_queue(&freq, &q)
  base := build_huffman_tree(&q)
  defer destroy_huffman_tree(base)
  destroy_huffman_tree(base)
  if ODIN_DEBUG {
    wolk_huffman_tree(base, 0)
  }
  lookup := build_lookup(base)
  defer destroy_lookup(lookup)
  if ODIN_DEBUG {
    for k, v in lookup {
      fmt.printfln("Char: %c, path %v", k, v)
    }
  }
}

process_decrypt :: proc(file: string) {

}

main :: proc() {
  args := os.args
  fmt.println(len(args))
  if len(args) == 2 {
    process_encrypt(args[1])
  } else if len(args) == 3 {
    if args[1] == "-e" {

    } else {
      fmt.eprintln("Usage comp -e [file_name]")
      return
    }
  } else {
    fmt.eprintln("Usag -e? [file_name]")
    return
  }
}


@(test)
build_freq_test :: proc(t: ^testing.T) {
  file := "test_ref.txt"
  f, f_ok := os.open(file, os.O_RDONLY)
  if f_ok != nil {
    fmt.eprintln("Can't open file:", file)
    return
  }
  defer os.close(f)
  stat, stat_ok := os.fstat(f)
  if stat_ok != nil {
    fmt.eprintln("File stat error:", stat_ok)
    return
  }
  buf := make([]byte, stat.size)
  defer delete(buf)
  read_bytes, read_err := os.read(f, buf)
  if read_err != nil {
    fmt.eprintln("os.read err:", read_err)
    delete(buf)
  }

  freq := build_freq(buf)
  defer delete(freq)

  if ODIN_DEBUG {
    for k, v in freq {
      fmt.printf("Char: %c, freq: %d\n", k, v)
    }
  }

  q: pq.Priority_Queue(^Node)
  pq.init(&q, less, swap)
  defer pq.destroy(&q)
  build_queue(&freq, &q)
  base := build_huffman_tree(&q)
  defer destroy_huffman_tree(base)
  destroy_huffman_tree(base)
  if ODIN_DEBUG {
    wolk_huffman_tree(base, 0)
  }
  lookup := build_lookup(base)
  defer destroy_lookup(lookup)
  if ODIN_DEBUG {
    for k, v in lookup {
      fmt.printfln("Char: %c, path %v", k, v)
    }
  }
}
