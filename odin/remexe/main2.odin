package remexe2


import "core:fmt"
import "core:os"
import "core:c"

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
    
}
