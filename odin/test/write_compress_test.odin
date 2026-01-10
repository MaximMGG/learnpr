package write_compress_test


import "core:fmt"
import "core:os"
import "core:strings"


read :: proc() {
  file, ok := os.open("test_file.txt", os.O_RDONLY)
  defer os.close(file)
  if ok != nil {
    fmt.eprintln("os.open error:", ok)
    return
  }

  buf: [128]u8

  read_bytes, read_ok := os.read(file, buf[:])
  if read_ok != nil {
    fmt.eprintln("os.read error:", read_ok)
    return
  }

  offset: u32 = 7
  for b in buf[0:read_bytes] {
    offset = 7
    inner: for {
      if ((b >> offset) & 0x1) == 1 {
        fmt.print("1")
      } else {
        fmt.print("0")
      }
      if offset == 0 {
        break inner
      } else {
        offset -= 1
      }
    }
  }
  fmt.println()
}

main :: proc() {
  lookup := [][]u8{[]u8{1, 1, 0, 1, 1}, []u8{1, 0, 0, 1}, []u8{1, 0, 0, 1, 1}}

  for pattern in lookup {
    for i in pattern {
      fmt.print(i, " ")
    }
  }
  fmt.println()


  file, ok := os.open("test_file.txt", os.O_CREATE | os.O_RDWR, os.S_IRUSR | os.S_IWUSR | os.S_IRGRP | os.S_IWGRP)
  if ok != nil {
    fmt.eprintln("os.open error:", ok)
    return
  }

  sb: strings.Builder
  strings.builder_init(&sb)
  defer strings.builder_destroy(&sb)

  b: u8
  offset: u32
  for path in lookup {
    for bit in path {
      b |= bit
      if offset == 7 {
        fmt.printf("%b", b)
        strings.write_byte(&sb, b)
        b = 0
        offset = 0
      } else {
        b <<= 1
        offset += 1
      }
    }
  }
  if offset != 0 {
    fmt.printf("%b\n", b)
    strings.write_byte(&sb, b)
  }

  os.write(file, sb.buf[:strings.builder_len(sb)])
  os.close(file)

  read()
}
