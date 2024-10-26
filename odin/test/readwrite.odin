package read

import "core:fmt"
import "core:strings"
import "core:os"
import "core:bufio"


read_file :: proc(file: string) {

    read, ok := os.read_entire_file(file, context.allocator)
    if !ok {
        fmt.printf("Cant read file %s\n", "../bound_check.c")
        return
    }

    defer delete(read, context.allocator)

    it := string(read)
    for line in strings.split_lines_iterator(&it) {
        fmt.printf("%s\n", line)
    }
}

read_file2 :: proc(path: string) {
    f, ferr := os.open(path)
    if ferr != 0 {
        return
    }

    defer os.close(f)

    r: bufio.Reader
    buf: [1024]byte
    bufio.reader_init_with_buf(&r, os.stream_from_handle(f), buf[:])
    defer bufio.reader_destroy(&r)

    for {
        line, err := bufio.reader_read_string(&r, '\n', context.allocator)
        if err != nil {
            break
        }
        defer delete(line, context.allocator)
        line = strings.trim_right(line, "\r")

        fmt.printf("%s", line)
    }




}


main :: proc() {
    fmt.printf("First method\n")
    path: string = "../bound_check.c"
    read_file(path)
    fmt.printf("Second method\n")
    read_file2(path)
}

