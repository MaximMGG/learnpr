package dyn_array


import "core:fmt"
import "base:runtime"
import "base:builtin"


main :: proc() {
    x: [dynamic]int
    append(&x, 123)
    append(&x, 4, 1, 74, 3)

    y: [dynamic]int
    append(&y, ..x[:]) //append a slice

    fmt.println(x)
    fmt.println(y)

    xx := make([dynamic]int, 0, 16)
    inject_at(&xx, 0, 10)
    inject_at(&xx, 3, 10)
    fmt.eprintln(xx[:], len(xx), cap(xx))
    assign_at(&xx, 3, 20)
    assign_at(&xx, 4, 20)
    fmt.eprintln(xx[:], len(xx), cap(xx))
    assign_at(&xx, 5, 40, 50, 60)
    fmt.eprintln(xx[:], len(xx), cap(xx))
    inject_at(&xx, 1, 144)
    fmt.eprintln(xx[:], len(xx), cap(xx))


}

