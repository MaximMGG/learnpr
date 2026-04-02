package basics

import "core:fmt"

loops :: proc(n: int) -> int {
    fmt.println(n)

    for i in 0..<5 {
        fmt.println(i)
    }

    fmt.println()

    for i := 0; i < 5; i += 1 {
        fmt.println(i)

    }

    i := 0

    for i < 5 {
        fmt.println(i)
        i += 1
    }


    res := 0

    for i in 0..<n {
        res += i
    }

    return res
}
