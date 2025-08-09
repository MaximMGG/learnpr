package dyn_arr

import "core:fmt"
import "core:mem"


main :: proc() {

    dyn := make([dynamic]int, 5, 5)

    defer delete(dyn)

    append(&dyn, 1)
    append(&dyn, 2)
    last_element := pop(&dyn)

    fmt.println(last_element)

    first_element := pop_front(&dyn)
    fmt.println(first_element)

    arr: [3]int = {1, 2, 3}
    append(&dyn, ..arr[:])
    remove_range(&dyn, len(dyn) - len(arr), len(dyn))

    fmt.println(dyn)
    mem.zero_slice(dyn[:])

    for _, i in dyn {
        dyn[i] = i + 1
    }

    ordered_remove(&dyn, 0)
    unordered_remove(&dyn, 0)

    dyn_copy := make([dynamic]int, len(dyn), cap(dyn))
    defer delete(dyn_copy)
    copy(dyn_copy[:], dyn[:])

    fmt.println("Elements:", dyn)
    fmt.println("Length:", len(dyn))
    fmt.println("Capacity:", cap(dyn))

}
