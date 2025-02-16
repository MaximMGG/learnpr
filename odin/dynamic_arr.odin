package dynamic_arr

import "core:fmt"
import "core:slice"


main :: proc() {
    x: [dynamic]int
    defer delete_dynamic_array(x)
    append(&x, 123)
    append(&x, 4, 1, 74, 3)

    y: [dynamic]int
    defer delete_dynamic_array(y)

    append(&y, ..x[:])

    fmt.println(len(x), cap(x))
    fmt.println(y)

    z := make([dynamic]int, 0, 16)
    defer delete(z)
    inject_at(&z, 0, 10)
    inject_at(&z, 3, 10)
    fmt.eprintln(z[:], len(z), cap(z))
    assign_at(&z, 3, 20)
    assign_at(&z, 4, 30)
    fmt.eprintln(z[:], len(z), cap(z))
    assign_at(&z, 5, 40, 50, 60)
    assign_at(&z, 10, 1)
    assign_at(&z, 15, 1)
    inject_at(&z, 16, 99)
    reserve_dynamic_array(&z, 32)
    fmt.eprintln(z[:], len(z), cap(z))

    //unordered_remove(&z, 10)
    ordered_remove(&z, 10)
    fmt.eprintln(z[:], len(z), cap(z))
    append(&z, 777)
    fmt.eprintln(z[:], len(z), cap(z))
    val := pop(&z)
    fmt.eprintln(z[:], len(z), cap(z))

    fmt.eprintln("Val:", val)
    fmt.println("===============One============")
    one()

}

one :: proc() {

    s: [dynamic]int
    defer delete(s)
    append(&s, 1, 7, 9, 7, 3, 7)
    slice.sort(s[:])
    fmt.println(s)


    a := make([]int, 6) // len(a) == 6
    defer delete(a) 
    b := make([dynamic]int, 6) // len(b) == 6, cap(b) == 6
    defer delete(b)
    c := make([dynamic]int, 0, 6) //len(c) == 0, cap(c) == 6
    defer delete(c)
    d := []int{1, 2, 3} // not allocated

    e := make([]int, 6, context.allocator)
    f := make([dynamic]int, 0, 6, context.allocator)
    defer delete(e)
    defer delete(f)


}
