package smallarray

import "core:fmt"
import sa "core:container/small_array"

main :: proc() {
    arr: sa.Small_Array(1024, int)
    fmt.printfln("len: %v", sa.len(arr))

    sa.append(&arr, 5)
    fmt.printfln("len: %v", sa.len(arr))

    sa.append(&arr, 7)
    fmt.printfln("len: %v", sa.len(arr))

    sa.unordered_remove(&arr, 0)
    fmt.printfln("arr[0]: %v", sa.get(arr, 0))
    fmt.printfln("len: %v", sa.len(arr))
    fmt.println("arr.len:", arr.len)
    fmt.println(arr.data)
}
