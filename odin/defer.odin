package main

import "core:fmt"
import "core:os"


main :: proc() {
    x := 123
    defer fmt.println(x) 
    {
        defer x = 4
        x = 2
    }
    fmt.println(x)

    x = 234

    y := 1

    defer if y == 3 {
        fmt.println("y == 3")
    }

    f, err := os.open("test.c")
    if err != os.ERROR_NONE {
    }
    defer {
        os.close(f)
    }


}
