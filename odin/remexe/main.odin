package remexe

import "core:fmt"
import "core:os"
import "core:strings"

print_level :: proc(level: int) {
    for i in 0..<level {
        fmt.print(" ")
    }
}

process_dir :: proc(dir_name: string, level: int) {
    dir, d_err := os.open(dir_name)
    defer os.close(dir)
    if d_err != nil {
        fmt.eprintln("Can not open dir:", dir_name)
        os.exit(1)
    }
    print_level(level)
    fmt.println("Check dir:", dir_name)

    fi, fi_err := os.read_dir(dir, -1)
    defer os.file_info_slice_delete(fi)
    if fi_err != nil {
        fmt.eprintln("Can not read dir:", dir_name)
        os.exit(1)
    }

    for f in fi {
        if f.name[0] == '.' {
            continue
        }
        if f.mode == os.File_Mode_Dir {
            new_path := strings.concatenate([]string{dir_name, "/", f.name})
            process_dir(new_path, level + 1)
            continue
        } else if (f.mode & os.S_IXUSR) > 1 {
            print_level(level)
            fmt.println("Remove file:", f.fullpath)
            os.remove(f.fullpath)
            continue
        }
    }
}

main :: proc() {
    process_dir(".", 0)
}
