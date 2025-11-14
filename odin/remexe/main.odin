package main

import "core:os"
import "core:fmt"
import "core:strings"

print_level :: proc(level: int) {
    for i in 0..<level {
        fmt.printf("  ")
    }
}


process_dir :: proc(dir_path: string, level: int) {
    print_level(level)
    fmt.println("Check dir:", dir_path)
    dir, d_err := os.open(dir_path)
    defer os.close(dir)
    if d_err != nil {
        fmt.eprintln("Can't open dir:", dir_path)
        return
    }

    fi, fi_err := os.read_dir(dir, -1)
    defer os.file_info_slice_delete(fi)
    if fi_err != nil {
        fmt.eprintln("Can't read dir")
        return
    }
    for f in fi {
        if f.name[0] == '.' {
            continue;
        }
        if f.is_dir {
            new_dir_path, ndp_err := strings.concatenate([]string{dir_path, "/", f.name})
            if ndp_err != nil {
                fmt.eprintln("concat string error:", ndp_err)
                return
            }
            process_dir(new_dir_path, level + 1)
            continue
        } else {
            if (f.mode & os.S_IXUSR) > 1 {
                print_level(level)
                fmt.println("Remove file:", f.name)
                os.remove(f.fullpath)
            }
        }
    }

}



main :: proc() {
    process_dir(".", 0)

}
