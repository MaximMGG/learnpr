package typeid_odin

import "core:fmt"
import "base:runtime"

main :: proc() {
    a := typeid_of(bool)
    fmt.println(a)
    i: int = 123
    b := typeid_of(type_of(i))
    fmt.println(b)

    u := u8(123)
    id := typeid_of(type_of(u))
    info: ^runtime.Type_Info
    info = type_info_of(id)
    fmt.println(info)
    fmt.println("--")
    fmt.println(info.id, info.size, info.align, info.flags, info.variant)

}
