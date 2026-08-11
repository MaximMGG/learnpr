package remexe_2

import "core:fmt"
import "core:os"
import "core:io"
import "core:bufio"
import "core:strings"
import "core:mem"
import "core:sys/posix"
import "core:c/libc"

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

  dir := posix.opendir(cstring(raw_data(dir_name)))
  defer posix.closedir(dir)
  if dir == nil {
    fmt.eprintln("Can't open dir", dir_name)
    os.exit(1)
  }

  d: ^posix.dirent = posix.readdir(dir)
  for d != nil {
    if d.d_name[0] == '.' {
      d = posix.readdir(dir)
      continue
    }
    if d.d_type == .DIR {
      for_new_path := strings.clone_from_bytes(d.d_name[:libc.strlen(cstring(&d.d_name[0]))])
      defer delete(for_new_path)
      new_path := strings.concatenate({dir_name, "/", for_new_path})
      process_dir(new_path, level + 1)
      d = posix.readdir(dir)
      continue
    }
    if d.d_type == .REG {
      for_stat := strings.clone_from_bytes(d.d_name[:])
      full_path_for_stat := strings.concatenate({dir_name, "/", for_stat})
      defer delete(full_path_for_stat)
      defer delete(for_stat)
      fi, fi_err := os.stat(full_path_for_stat, context.allocator)
      defer os.file_info_delete(fi, context.allocator)
      if fi_err != nil {
        fmt.eprintln("os.stat error")
        os.exit(1)
      }
      if .Execute_User in fi.mode {
        if !check_exetencion(fi.name) {
          print_level(level)
          print_delete_exe(fi.fullpath)
          os.remove(fi.fullpath)
        }
      }
    }
    d = posix.readdir(dir)
  }
}

main :: proc() {

  arena: mem.Dynamic_Arena
  mem.dynamic_arena_init(&arena)
  defer mem.dynamic_arena_destroy(&arena)
  context.allocator = mem.dynamic_arena_allocator(&arena)

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
