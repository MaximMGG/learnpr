package super_foo


import "core:fmt"


foo_int :: proc(x: int) {
    fmt.println("This is int:", x)
}

foo_f32 :: proc(x: f32) {
    fmt.println("This is float:", x)
}

foo_u64 :: proc(x: u64) {
    fmt.println("This is u64:", x)
}

foo_cstring :: proc(x: cstring) {
    fmt.println("This is cstring", x)
}

foo_i32 :: proc(x: i32) {
    fmt.println("This is i32", x)
}


foo :: proc{foo_int, foo_f32, foo_u64, foo_cstring, foo_i32}
