package map_odin

import "core:fmt"

Test :: struct {
    x: int,
    y: int
}


main :: proc() {
    m := make(map[string]int)
    defer delete(m)
    fmt.println(len(m), cap(m))

    m["Bob"] = 2
    m["Nil"] = 3
    m["Nata"] = 777
    fmt.println(m)
    fmt.println(m["Bob"])

    delete_key(&m, "Nil")
    fmt.println(m)

    elem, ok := m["Bob"]
    fmt.println(elem, ok)

    mm := map[string]int{
        "Bob" = 33,
        "None" = 1,
    }
    fmt.println(len(mm), cap(mm))
    fmt.println(mm)

    test := map[string]Test{
        "One" = {1, 2},
        "Two" = {333, 131313},
    }
    fmt.println(len(test), cap(test))
    fmt.println(test)
}
