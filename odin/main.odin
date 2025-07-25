package main

import "core:fmt"

main :: proc() {
    fmt.println("Hello world")
    a: i32 = 0
    for i in 0 ..< 10 {
        a += i32(i)
    }

    fmt.printf("%d\n", a)
}

