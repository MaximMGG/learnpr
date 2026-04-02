package main


import "core:strings"
import "core:fmt"
import "core:os"
import "core:io"
import "core:bufio"

delimeter: byte = ' '

print_field :: proc(reader: ^bufio.Reader, field_number: int) {
  s: string
  err: io.Error = nil
  for {
    s, err = bufio.reader_read_string(reader, '\n')
    defer delete(s)
    if err != nil {
      break
    }
    beg_index: int = 0
    index: int
    for i in 0..<field_number {
      beg_index = index
      index = strings.index_byte(s, delimeter)
    }
    fmt.println(s[beg_index+1: index])
  }
}

main :: proc() {
  args := os.args
  if len(args) <= 2 {
    fmt.eprintln("Cut [flag] [file_name]")
    return
  }

  f, f_ok := os.open(args[2], os.O_RDONLY)
  if f_ok != nil {
    fmt.eprintln("Can't file:", args[2])
    return
  }
  defer os.close(f)
  f_stream := os.stream_from_handle(f)
  f_reader := io.to_reader(f_stream)
  reader: bufio.Reader
  bufio.reader_init(&reader, f_reader)
  defer bufio.reader_destroy(&reader)

  switch args[1] {
  case "-f2": 
    print_field(&reader, 2)
  }
}
