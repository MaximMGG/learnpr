package fmt_test

import "core:fmt"

main :: proc() {
    args := make([]any, 5)
    defer delete(args)

    a := "HEllo"
    args[0] = 124
    args[1] = 123.8
    args[2] = a
    args[3] = 9999
    args[4] = 8

    fmt_str := "INSERT INTO names (id, id2, s, id3, id4) VALUES (%d %f '%s' %d %d)" 

    buf := fmt.aprintf(fmt_str, ..args)
    defer delete(buf)
    
    fmt.println(args)

    fmt.println(buf)
    
}
