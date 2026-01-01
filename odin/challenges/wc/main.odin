package main

import "core:fmt"
import "core:os"
import "core:bufio"
import "core:io"
import "core:mem"
import "core:strings"
import "core:unicode"
import "core:c/libc"


word_check :: proc(s: string) -> bool {
  buf: []u8 = transmute([]u8)s
  has_alpha: bool = false
  for b in buf {
    if unicode.is_alpha(rune(b)) {
      has_alpha = true
      break
    }
  }
  return has_alpha
}

main :: proc() {

  wcount: u32
  ccount: u32
  lcount: u32

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
  stat, stat_ok := os.fstat(f)
  if stat_ok != nil {
    fmt.eprintln("io.fstat error")
    return
  }
  buf: []u8 = make([]u8, stat.size)
  os.file_info_delete(stat)
  read_bytes, read_err := io.read(reader, buf)
  if read_err != nil {
    fmt.eprintln("Read error")
    return
  }
  if read_bytes != len(buf) {
    fmt.eprintln("Read bytes not equalse buf len")
    return
  }

  find_word: bool = false
  i: int
  for i < len(buf) {
    if libc.isspace(i32(buf[i])) != 0 {
      i += 1
      ccount += 1
      continue
    }

    wcount += 1

    for i < len(buf) && libc.isspace(i32(buf[i])) == 0 {
      ccount += 1
      i += 1
      if buf[i] == '\n' {
        lcount += 1
      }
    }
  }

  delete(buf)

  if os.args[1] == "-c" {
    fmt.printf("%d %s\n", ccount, os.args[2])
  } else if os.args[1] == "-l" {
    fmt.printf("%d %s\n", lcount, os.args[2])
  } else if os.args[1] == "-w" {
    fmt.printf("%d %s\n", wcount, os.args[2])
  }


  when ODIN_DEBUG {
    for _, leak in track.allocation_map {
      fmt.printf("%v leaked %m\n", leak.location, leak.size)
    }
  }
}
