package exp1

import "core:fmt"


main :: proc() {
    x: [dynamic]i32 = make([dynamic]i32, 0, 12)
    defer delete(x)

    for i in 0..<12 {
        assign_at(&x, i, i32(i + 1))
    }
    fmt.println(x)
}
