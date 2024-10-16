package slices

import "core:fmt"
import "core:slice"


main :: proc() {
    fibo := [6]int{0, 1, 1, 2, 3, 5}
    s: []int = fibo[1:4]
    fmt.println(s)
    fmt.println(len(s))

    r := []int{2, 3, 8, 1, 76, 3, 4}

    slice.sort(r)
    fmt.println(r)
    slice.reverse_sort(r)
    fmt.println(r)
}
