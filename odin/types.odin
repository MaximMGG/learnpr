package main

import "core:fmt"

One :: struct {
    x: int,
    y: int,
    z: f32,
}

Two :: struct {
    x: int,
    y: int,
}

I :: 42
F :: 1.36
S :: "Hellope"
B :: true


main :: proc() {
    i: int = 123
    f: f64 = f64(i)
    u: u32 = u32(f)

    i2 := 123
    f2 := cast(f64)i2
    u2 := cast(u32)f2

    fl := f32(123)
    uu := transmute(u32)fl //--->

    o: One = {1, 3, 3.2}
    two := (^Two)(&o)
    
    fmt.printf("%d %d\n", two.x, two.y)

    o2: ^One = cast(^One)two
    fmt.printf("One -> %d %d %.1f\n", o2.x, o2.y, o2.z)

    fu := (^u32)(&fl)^

    x: f32 = 12.3
    y: int = auto_cast x

}
