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

    fmt.println(args)
    
}
