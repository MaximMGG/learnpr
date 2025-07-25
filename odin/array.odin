package array


import "core:fmt"

main :: proc() {
    arr := make([]int, 10000000)
    defer delete(arr)

    for i in 0..<len(arr) {
 #no_bounds_check {
        arr[i] = i + 1
 }
    }

    fmt.println(arr[9999999])
}
