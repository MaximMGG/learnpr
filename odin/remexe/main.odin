package remexe

import "core:fmt"
import "core:os"
import "core:io"
import "core:bufio"
import "core:strings"

writer: bufio.Writer

print_level :: proc(level: int) {
    for i in 0..<level {
        bufio.writer_write_string(&writer, " ")
    }
}

check_exetencion :: proc(file_name: string) -> bool {
  if strings.ends_with(file_name, ".sh") {
    return true
  }
  if strings.ends_with(file_name, ".so") {
    return true
  }
  return false
}

print_enter_dir :: #force_inline proc(dir_name: string) {
  bufio.writer_write_string(&writer, "Entering dir '")
  bufio.writer_write_string(&writer, dir_name)
  bufio.writer_write_byte(&writer, byte('\''))
  bufio.writer_write_byte(&writer, byte('\n'))
}

print_delete_exe :: #force_inline proc(exe_name: string) {
  bufio.writer_write_string(&writer, "\x1b[1;31mDelete Executable: ")
  bufio.writer_write_string(&writer, exe_name)
  bufio.writer_write_string(&writer, "\x1b[0m\n")
}

process_dir :: proc(dir_name: string, level: int) {
  print_level(level)
  print_enter_dir(dir_name)

  cur_dir, cur_dir_err := os.open(dir_name, {.Inheritable, .Read})
  defer os.close(cur_dir)
  if cur_dir_err != nil {
    fmt.eprintln("Can't open dir:", dir_name)
    os.exit(1)
  }

  fi, fi_err := os.read_dir(cur_dir, -1, context.allocator)
  if fi_err != nil {
    fmt.eprintln("os.read_dir error")
    os.exit(1)
  }

  for f in fi {
    if f.type == .Directory {
      process_dir(f.fullpath, level + 1)
      continue
    }
    if f.type == .Regular {
      if .Execute_User in f.mode {
        if !check_exetencion(f.name) {
          print_level(level)
          print_delete_exe(f.fullpath)
          os.remove(f.fullpath)
        }
      }
    }

  }
}

main :: proc() {
  stream := os.to_stream(os.stdout)
  io_writer, writer_ok := io.to_writer(stream)
  if !writer_ok {
    fmt.eprintln("Can't create writer")
    return
  }
  bufio.writer_init(&writer, io_writer)
  process_dir(".", 0)
  bufio.writer_flush(&writer)
  bufio.writer_destroy(&writer)
}
