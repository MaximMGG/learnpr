package comp

import "core:fmt"
import "core:os"
import "core:io"
import "core:mem"


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

    when ODIN_DEBUG {
      for k, v in table {
        fmt.printf("%c(%d) appeard %d types\n", k, k, v)
      }
    }
}
