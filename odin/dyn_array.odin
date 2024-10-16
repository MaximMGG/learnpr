package dyn_array


import "core:fmt"
import "core:slice"


main :: proc() {
    x: [dynamic]int
    defer delete(x)
    append(&x, 123)
    append(&x, 4, 1, 74, 3)

    y: [dynamic]int
    defer delete(y)
    append(&y, ..x[:]) //append a slice

    fmt.println(x)
    fmt.println(y)

    xx := make([dynamic]int, 0, 16)
    defer delete(xx)
    inject_at(&xx, 0, 10)
    inject_at(&xx, 3, 10)
    fmt.eprintln(xx[:], len(xx), cap(xx))
    assign_at(&xx, 3, 20)
    assign_at(&xx, 4, 20)
    fmt.eprintln(xx[:], len(xx), cap(xx))
    assign_at(&xx, 5, 40, 50, 60)
    fmt.eprintln(xx[:], len(xx), cap(xx))
    inject_at(&xx, 1, 144)
    fmt.eprintln(xx[:], len(xx), cap(xx))
    fmt.println("one")
    one()
    fmt.println("two")
    two()
    fmt.println("tree")
    tree()
    fmt.println("four")
    four()
    fmt.println("five")
    five()
}

one :: proc() {
    x: [dynamic]int
    defer delete(x)
    append(&x, 1, 2, 3, 4, 5)
    y := pop(&x)
    fmt.println(y)
    fmt.println(x)
    ordered_remove(&x, 0)
    unordered_remove(&x, 0)
    fmt.println(x)
}

two :: proc() {
    x: [dynamic]int
    defer delete(x)
    append(&x, 1, 2, 5, 3, 1, 0)
    slice.sort(x[:])
    fmt.println(x)
}

tree :: proc() {
    a := make([]int, 6)
    defer delete(a)
    fmt.println(len(a))
    b := make([dynamic]int, 6)
    defer delete(b)
    fmt.println(len(b), cap(b))
    c := make([dynamic]int, 0, 6)
    defer delete(c)
    fmt.println(len(c), cap(c))
    d := []int{1, 2, 3}
    fmt.println(d)

    e := make([]int, 6, context.allocator)
    defer delete(e)
    f := make([dynamic]int, 0, 6, context.allocator)
    defer delete(f)

}

four :: proc() {
    x: [dynamic]int
    defer delete(x)
    append(&x, 1, 2, 3, 4, 5)
    fmt.println(len(x))
    clear(&x)
    fmt.println(len(x))

}

five :: proc() {
    x: [dynamic]int
    defer delete(x)
    fmt.println(len(x), cap(x))
    append(&x, 1, 2, 3)
    fmt.println(len(x), cap(x))
    resize(&x, 5)
    fmt.println(len(x), cap(x))
    fmt.println(x[:])
    fmt.println(len(x), cap(x))
    reserve(&x, 32)
    fmt.println(len(x), cap(x))
    shrink(&x)
    fmt.println(len(x), cap(x))
}
