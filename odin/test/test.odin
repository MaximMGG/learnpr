package test

import "core:fmt"
import "core:os"
import "core:mem"
import "core:strings"

main :: proc() {
    f, f_err := os.open("./word.txt", os.O_RDONLY)
    if f_err != nil {
        fmt.eprintln("Catn open word.txt")
        return
    }

    defer os.close(f)
    buf: [512]u8

    os.read(f, buf[:])

    p: ^u8 = &buf[0]

    fmt.println(cstring(p))

}

get_key_val :: proc(buf: []u8, len: int, pos: int) -> (k, v: string) {
    tmp_b: [512]u8
    tmp_i := 0
    for i := pos; i < len; i += 1 {
        if buf[i] == ' ' && tmp_i == 0 {
            continue
        }

        if buf[i] == '-' && tmp_i == 0 {
            continue
        }

        if buf[i] == ' ' && tmp_i != 0 && k == "" {
            k = strings.string_from_ptr(cast(^u8)&tmp_b[0], tmp_i)
            tmp_i = 0
            continue
        }

        if buf[i] == ' ' && tmp_i != 0 && v == "" {

        }
        tmp_b[tmp_i] = buf[i]

    }

    return k, v
}
