package main

import "core:fmt"

main :: proc() {
    acum: int = 0

    for i in 0..<100000 {
        acum += int(i)
    }

    fmt.println(acum)
}

