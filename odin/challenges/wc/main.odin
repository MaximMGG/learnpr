package main

import "core:fmt"
import "core:os"
import "core:bufio"
import "core:io"
import "core:mem"

main :: proc() {

  when ODIN_DEBUG {
    track: mem.Tracking_Allocator
    mem.tracking_allocator_init(&track, context.allocator)
    context.allocator = mem.tracking_allocator(&track)
    defer mem.tracking_allocator_destroy(&track)
  }

  if len(os.args) < 3 {
    fmt.eprintln("Usage flag file_name")
    return
  }

  f, f_ok := os.open(os.args[2])
  if f_ok != nil {
    fmt.println("Can't open file:", os.args[2])
    return
  }
  defer os.close(f)
  stream := os.stream_from_handle(f)
  reader, reader_ok := io.to_reader(stream)
  if !reader_ok {
    fmt.eprintln("Can't create reader")
  }
  buf_reader: bufio.Reader
  bufio.reader_init(&buf_reader, reader)
  // defer bufio.reader_destroy(&buf_reader)

  if os.args[1] == "-c" {
    stat, stat_err := os.fstat(f)
    if stat_err != nil {
      fmt.println("os.fstat error")
      return
    }
    defer os.file_info_delete(stat)
    fmt.println("\r", stat.size, os.args[2]) 
  } else if os.args[1] == "-l" {
    err: io.Error
    str: string
    count: u32
    for {
      str, err = bufio.reader_read_string(&buf_reader, '\n')
      defer delete(str)
      if err == io.Error.EOF {
        break
      }
      count += 1
    }

    fmt.println(count, os.args[2])
  }

  bufio.reader_destroy(&buf_reader)

  when ODIN_DEBUG {
    for _, leak in track.allocation_map {
      fmt.printf("%v leaked %m\n", leak.location, leak.size)
    }
  }
}
