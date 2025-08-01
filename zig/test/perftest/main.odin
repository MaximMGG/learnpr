package main

import "core:fmt"



SIZE :: 10000000

main :: proc() {

    arr := make([]int, SIZE * 2)
    defer delete(arr)

    for i in 0..<SIZE {
        arr[i] = i
        arr[i + SIZE] = i
    }

    for i in 0..<SIZE {
        arr[i] = arr[i] + arr[i + SIZE]
    }

    fmt.println(arr[SIZE - 1])
}
