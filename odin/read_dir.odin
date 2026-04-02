package read_dir

import "core:fmt"
import "core:io"
import "core:os"



main :: proc() {
    dir, ok := os.open(".", os.O_RDWR)

    if ok == nil {
	fmt.fprintln(os.stderr, "Cant open dir .")
	return
    }

    fi, _ := os.read_dir(dir, 10)
    defer delete(fi)

    for f in fi {
	fmt.println(f.name)
    }

    os.close(dir)
}
