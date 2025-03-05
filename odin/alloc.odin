package alloc_odin

import "core:fmt"
import "core:mem"

main :: proc() {
    ptr := new(int) or_else nil
    defer free(ptr)
    ptr^ = 123
    x: i32 = cast(i32)ptr^
    fmt.println(x)
    fmt.println("================> one")
    one()
    fmt.println("================> two")
    two()
    fmt.println("================> tree")
    tree()
    //free(ptr)
}

one :: proc() {
    x: int = 123
    ptr: ^int
    ptr = new_clone(x)
    defer free(ptr)
    assert(ptr^ == x)
}

two :: proc() {
    slice := make([]int, 65)
    defer delete(slice)

    dynamic_array_zero_length := make([dynamic]int)
    defer delete(dynamic_array_zero_length)
    dynamic_array_with_length := make([dynamic]int, 32)
    defer delete(dynamic_array_with_length)
    dynamic_array_with_length_and_capacity := make([dynamic]int, 16, 64)
    defer delete(dynamic_array_with_length_and_capacity)

    made_map := make(map[string]int)
    defer delete(made_map)

    made_map_with_reservation := make(map[string]int, 64)
    delete(made_map_with_reservation)
}


tree :: proc() {
    arr := make([dynamic]int, 4, 10)
    delete(arr)
}
