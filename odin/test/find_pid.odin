package find_pid

import "core:os"
import "core:fmt"

main :: proc() {
  procs, procs_err := os.open("/proc", {.Read})
  defer os.close(procs)
  if procs_err != nil {
    fmt.eprintln("Can't open /proc dir")
    os.exit(1)
  }

  proc_cont, proc_cont_err := os.read_all_directory(procs, context.allocator)
  defer os.file_info_slice_delete(proc_cont, context.allocator)
  pid_name_buf: [256]u8
  for pid_fi in proc_cont {
    if pid_fi.name[0] >= '0' && pid_fi.name[0] <= '9' {
      pid_path := fmt.bprintf(pid_name_buf[:], "/proc/%s/comm", pid_fi.name)
      pid_name, pid_name_ok := os.read_entire_file(pid_path, context.allocator)
      if pid_name_ok != nil {
        fmt.eprintln("Can't read", pid_path, "file")
      }
      defer delete(pid_name)
      fmt.printf("pid: %s, proc name: %s", pid_fi.name, pid_name)
    }
  }
}
