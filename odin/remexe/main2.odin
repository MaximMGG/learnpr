package remexe2


import "core:fmt"
import "core:os"
import "core:c"
import "core:io"
import "core:bufio"

foreign import libc {
    "system:c",
}

DT_DIR :: 4


DIR :: rawptr
dirent :: struct{
    d_ino: i64,
    d_off: i64,
    d_reclen: u16,
    d_type: u8,
    d_name: [256]u8
}

@(default_calling_convention="c")
foreign libc {
    opendir :: proc(name: cstring) -> DIR ---
    closedir :: proc(dir: DIR) -> i32 ---
    readdir :: proc(dirp: DIR) -> ^dirent
}

print_level :: proc(level: int) {
    for i in 0..<level {
        fmt.print("  ")	
    }
}

rem_exe :: proc(dir_name: string, level: int) {
    print_level(level)
    fmt.println("Scanning dir:", dir_name)

    dir := opendir(cstring(raw_data(dir_name)))
    n
    dirrent := readdir(dir)

    for dirrent != nil {
	if dirrent.d_name[0] == '.' {
	    continue
	}
	
    }
}

main :: proc() {
  stdout_stream := os.stream_from_handle(os.stdout)
  stdout_writer := io.to_writer(stdout_stream)
  writer: bufio.Writer
  bufio.writer_init(&writer, stdout_writer)
  defer bufio.writer_destroy(&writer)
  rem_exe(writer, ".", 0)
}
