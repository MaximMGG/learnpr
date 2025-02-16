package remexe

import "core:fmt"
import "core:os"

EXECUTABLE :: 33261


read_dir :: proc(fi: os.File_Info) {
    if fi.name == ".." {
        return
    } else if fi.name == "." {
        return
    }
    //fmt.println("File:", fi.name, "mode:", fi.mode, fi.mode == 33261 ? "execution" : "")



    if fi.is_dir == true {
        fmt.println("Reading dirrectory...", fi.fullpath)

        dir, err := os.open(fi.fullpath)
        defer os.close(dir)
        if err != nil {
            fmt.fprintf(os.stderr, "Error while open dir %s\n", fi.fullpath)
            return
        }

        entry, entry_err := os.read_dir(dir, 100)
        defer os.file_info_slice_delete(entry)
        //defer delete(entry)
        if entry_err != nil {
            fmt.fprintf(os.stderr, "Error while open dir %s\n", fi.fullpath)
            os.close(dir)
            return
        }
        for e in entry {
            if e.is_dir == true {
                read_dir(e)
            }
            if e.mode == EXECUTABLE {
                fmt.println("Removing executable:", e.fullpath)
                os.remove(e.fullpath)
            }
        }
    } else {
        if (fi.mode == EXECUTABLE) {
            fmt.println("Removing executable:", fi.fullpath)
            os.remove(fi.fullpath)
        }
    }
}



main :: proc() {
    f, ferr := os.open("./")
    defer os.close(f)
    if ferr != nil {
        fmt.fprintf(os.stderr, "Error open current dir")
        return
    }

    entry, entry_err := os.read_dir(f, 100)
    defer os.file_info_slice_delete(entry)
    if entry_err != nil {
        fmt.fprintf(os.stderr, "Error open read current dir")
        os.close(f)
        return
    }

    for e in entry {
        read_dir(e)
    }
}
