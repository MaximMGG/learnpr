package pointers_odin

import "core:fmt"
import "core:mem"

main :: proc() {
    x: int = 1
    p: ^int
    p = &x
    fmt.println(p)
    fmt.printf("%p -> %d\n", p, p^)
    fmt.println("======================")
    arr: [dynamic]int = make([dynamic]int, 0, 3)
    arr_slice := arr[:]
    append(&arr, 11, 22, 33)

    fmt.println(arr)
    fmt.println(&arr_slice)
    fmt.println(&arr[0])


    rp: rawptr = &arr[0]
    fmt.println((rp))
    fmt.println((^int)(rp)^)
    rp = mem.ptr_offset((^int)(rp), 2)
    fmt.println((^int)(rp))
    fmt.println((^int)(rp)^)
    rp = mem.ptr_offset((^int)(rp), -1)
    fmt.println((^int)(rp))
    fmt.println((^int)(rp)^)


    begine_p: ^int = &arr[0]
    end_p: ^int = &arr[2]

    res := mem.ptr_sub(end_p, begine_p)

    fmt.println(res)

}

