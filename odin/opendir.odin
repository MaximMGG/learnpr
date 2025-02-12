package dir_open

import "core:fmt"
import "core:os"

main :: proc() {
    dir, err := os.open("./")
    if err != nil {
        fmt.println("Opening dir on path:", "./", " is error:", err)
        return
    }
    defer os.close(dir)

    entry, entry_err := os.read_dir(dir, 100)
    if entry_err != nil {
        fmt.println("Cant read dir")
        os.close(dir)
        return
    }

    for e in entry {
        fmt.println(e.name)
        fmt.println(e.mode)

        if os.is_dir(e.fullpath) {
            os.remove_directory(e.fullpath)
            fmt.println("Removing dir:", e.fullpath)
        }

    }


}
