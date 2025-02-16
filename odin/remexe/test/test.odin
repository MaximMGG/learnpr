package test

import "core:fmt"


main :: proc() {

    a: u32 = 1 << 16
    b: u32 = 1 << 17
    c: u32 = 1 << 18
    d: u32 = 1 << 19
    e: u32 = 1 << 20

    fmt.println(a)
    fmt.println(b)
    fmt.println(c)
    fmt.println(d)
    fmt.println(e)

}
