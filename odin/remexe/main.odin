package remexe

import "core:fmt"
import "core:os"
import "core:strings"
import "core:os/os2"

print_level :: proc(level: int) {
    for i in 0..<level {
        fmt.print(" ")
    }
}

process_dir :: proc(dir_name: string, level: int) {
    dir, d_err := os2.open(dir_name)
    defer os2.close(dir)
    if d_err != nil {
        fmt.eprintln("Can not open dir:", dir_name)
        os.exit(1)
    }
    print_level(level)
    fmt.println("Check dir:", dir_name)

    fi, fi_err := os2.read_dir(dir, -1, context.allocator)
    defer os2.file_info_slice_delete(fi, context.allocator)
    if fi_err != nil {
        fmt.eprintln("Can not read dir:", dir_name)
        os.exit(1)
    }

    for f in fi {
        if f.name[0] == '.' {
            continue
        }
	
        if f.type == .Directory {
            new_path := strings.concatenate([]string{dir_name, "/", f.name})
            process_dir(new_path, level + 1)
            delete(new_path)
            continue
        } else if (os2.Permission_Flag.Execute_User in f.mode) {
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
