package array_add_test

import "core:fmt"

add_to_arr :: proc(arr: ^[dynamic]i32, num: i32) {
    append(arr, num)
}

main :: proc() {
    arr: [dynamic]i32
    defer delete(arr)

    for i in 0..<1_000_000 {
      add_to_arr(&arr, i32(i))
    }

    sum: u64
    for i in 0..<len(arr) {
      sum += u64(arr[i])
    }

    fmt.println("Sum is:", sum)
}
