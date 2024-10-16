package small_array


import "core:fmt"
import sa "core:container/small_array"

main :: proc() {
    x: sa.Small_Array(8, int)
    fmt.println(sa.len(x), sa.cap(x))
    sa.append(&x, 1, 2, 3)
    fmt.println(sa.len(x), sa.cap(x))
    fmt.println(x)
    fmt.println(sa.slice(&x))
}
