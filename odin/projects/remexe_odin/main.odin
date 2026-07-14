package remexe_odin

import "core:fmt"
import "core:strings"
import "core:bufio"
import "core:io"
import "core:os"

stdout_wr: io.Writer
buf_wr: bufio.Writer

extensions := []string{".sh"}
prog_names := []string{"remexeo"}


check_exceptions :: proc(exe_name: string) -> bool {
  for ending in extensions {
    if strings.ends_with(exe_name, ending) {
      return true
    }
  }

  for prog in prog_names {
    if prog == exe_name {
      return true
    }
  }

  return false
}


add_deep :: proc(deep: int) {
  for _ in 0..<deep {
    bufio.writer_write_string(&buf_wr, "  ")
  }
}

process_dir :: proc(path: string, deep: int) {
  f, f_err := os.open(path)
  if f_err != nil {
    fmt.eprintln("Can't open dir:", path)
    return
  }
  add_deep(deep)
  bufio.writer_write_string(&buf_wr, "Check dir: ")
  bufio.writer_write_string(&buf_wr, path)
  bufio.writer_write_string(&buf_wr, "...\n")

  defer os.close(f)
  f_info, f_info_err:= os.read_directory(f, -1, context.allocator)
  defer os.file_info_slice_delete(f_info, context.allocator)
  if f_info_err != nil {
    fmt.eprintln("Can't read directory:", path)
    return
  }

  for info in f_info {
    if info.name[0] == '.' {continue}
    if info.type == .Directory {
      new_path := strings.concatenate({path, "/", info.name})
      defer delete(new_path)
      process_dir(new_path, deep + 1)
      continue
    } else {
      if os.Permission_Flag.Execute_User in info.mode {
        if check_exceptions(info.name) {
          continue
        } else {
          add_deep(deep)
          bufio.writer_write_string(&buf_wr, "\x1b[1;31m")
          bufio.writer_write_string(&buf_wr, "Remove executable: ")
          bufio.writer_write_string(&buf_wr, info.name)
          bufio.writer_write_byte(&buf_wr, '\n')
          bufio.writer_write_string(&buf_wr, "\x1b[0m")
          os.remove(info.fullpath)
        }
      }
    }
  }
}

main :: proc() {
  stdout_wr = io.to_writer(os.to_writer(os.stdout))
  bufio.writer_init(&buf_wr, stdout_wr)
  defer bufio.writer_destroy(&buf_wr)
  process_dir(".", 0)
  bufio.writer_flush(&buf_wr)
}

