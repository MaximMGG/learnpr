package comp

import "core:fmt"
import "core:os"
import "core:io"
import "core:mem"
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

  for pq.len(queue) > 0 {
    tmp := pq.pop(&queue)
    fmt.println(tmp)
  }


  when ODIN_DEBUG {
    for k, v in table {
      fmt.printf("%c(%d) appeard %d types\n", k, k, v)
    }
  }
}
