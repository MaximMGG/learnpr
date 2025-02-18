package pointers

import "core:fmt"
import "core:mem"

Foo :: struct {
    i: i32,
    j: i32,
}


main :: proc() {
    i: ^int
    n := 33
    i = &n
    fmt.println(i, ":", i^)
    i^ = 999
    fmt.println(i, ":", i^)

    str: cstring = "My cat is awesome"

    c: ^u8 = cast(^u8)str

    fmt.println(cast(rune)c^)
    c = mem.ptr_offset(c, 1)
    fmt.println(cast(rune)c^)
    c = mem.ptr_offset(c, -1)
    fmt.println(cast(rune)c^)

    c = cast(^u8)str

    fmt.println("+++++")

    for i := 0; i < len(str); i += 1 {
        p := mem.ptr_offset(c, i)
        fmt.println(cast(rune)p^)
    }

    c = mem.ptr_offset(c, 6)
    
    p := mem.ptr_sub(c, mem.ptr_offset(c, -2))


    fmt.println(p)

    fmt.println(cast(uintptr)c - cast(uintptr)mem.ptr_offset(c ,-2))

    st: Foo = {33, 66}

    pi: ^i32 = cast(^i32)&st

    fmt.println(pi^)

    //pi = mem.ptr_offset(pi, 1)
    pi = pi + cast(^i32)cast(uintptr)1
    fmt.println(pi^)

}
