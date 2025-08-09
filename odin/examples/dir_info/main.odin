package dir_info

import "core:fmt"
import "core:os"
import "core:path/filepath"

main :: proc() {
    cwd := os.get_current_directory()

    f, err := os.open(cwd)

    if err != os.ERROR_NONE {
        fmt.eprintln("Could not open directory for reading", err)
        os.exit(1)
    }

    fis: []os.File_Info

    defer os.file_info_slice_delete(fis)
    fis, err = os.read_dir(f, -1)

    if err != os.ERROR_NONE {
        fmt.eprintln("Could not read directory", err)
        os.exit(1)
    }

    fmt.printfln("Current working directory %v contains:", cwd)

    for fi in fis {
        _, name := filepath.split(fi.fullpath)
        if fi.is_dir {
            fmt.printfln("%v (directory)", name)
        } else {
            fmt.printfln("%v (%v bytes)", name, fi.size)
        }
    }



    test()
}

Dog :: struct {
    name: string,
    age: i32
}

test :: proc() {
    d: Dog = {name = "Huan", age = 12}
    fmt.println(d)

    f: ^Dog = &d;

    fmt.println(f)

}
