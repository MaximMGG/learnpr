package test

import "core:fmt"
import "core:os"
import "core:mem"
import "core:strings"
import "core:c"

main :: proc() {
    f, f_err := os.open("./word.txt", os.O_RDONLY)
    if f_err != nil {
        fmt.eprintln("Catn open word.txt")
        return
    }

    defer os.close(f)
    buf: [512]u8

    read_bytes, _ := os.read(f, buf[:])
    fmt.println("Read bytes:", read_bytes)


    pos: int = 0

    for pos <= read_bytes {
        s := get_line(buf[:], &pos, read_bytes)
        fmt.printf("%s\n", cstring(raw_data(s)))
    }
}


get_line :: proc(buf: []u8, pos: ^int, buf_size: int) -> string{
    tmp_b: [512]u8
    tmp_i := 0

    if pos^ >= buf_size {
        pos^ += 1
        return ""
    }

    for i := pos^; i < buf_size; i += 1 {
        if (buf[i] == '\n') {
            pos^ = i + 1
            break
        }
        tmp_b[tmp_i] = buf[i]
        tmp_i += 1
    }

    a: string = strings.string_from_ptr(&tmp_b[0], tmp_i)

    return a
}

