package bit_field_odin

import "core:fmt"

Foo :: bit_field u16 {
    x: i32      | 3,
    y: u16      | 2 + 3,
    z: MY_Enum  | foo.SOME_CONSTANT,
    w: bool     | 2 when foo.SOME_CONSTANT > 10 else 1
}

MY_Enum :: enum {
    SOME_CONSTANT = 11
}

foo :: MY_Enum

main :: proc() {
    v := Foo{}
    v.x = 3
    fmt.println(v.x)
    fmt.println(v)

}
