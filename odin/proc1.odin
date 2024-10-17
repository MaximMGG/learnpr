package proc2

import "core:fmt"


one :: proc() -> int {
    return 3
}

two :: proc "c" (n: i32, data: rawptr) -> ---
tree :: proc "contextless" (s: []int) -> ---


test :: struct {
    //this is a functiona
    a: proc() -> int,
    x: int
}

Callback :: proc() ->int

main :: proc() {
    t := test{a=one, x=333}
    fmt.println(t.a())

    a: Callback
    assert(a == nil)

    a = proc() -> int {return 0}
    fmt.println(a()) // 0
    a = proc() -> int {return 100}
    fmt.println(a()) // 100

}
