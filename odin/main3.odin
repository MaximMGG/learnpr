package main3


import "core:fmt"

My_Int :: int
My_dInt :: distinct int

Vector3 :: [3]f32


main :: proc() {

    a := Vector3{1, 4, 9}
    b := Vector3{2, 4, 8}

    c := a + b
    fmt.println(c)

    d := swizzle(a, 2, 1, 1)
    fmt.println(d)
    x := cross(a, b)
    y := cross_short(a, b)
    fmt.println(x)
    fmt.println(y)
    fmt.println(blah(x))
    fmt.println(blah(y))
}


cross :: proc(a, b: Vector3) -> Vector3 {
    i := swizzle(a, 1, 2, 0) * swizzle(b, 2, 0, 1)
    j := swizzle(a, 2, 0, 1) * swizzle(b, 1, 2, 0)
    return i - j
}

cross_short :: proc(a, b: Vector3) -> Vector3 {
    i := a.yzx * b.zxy
    j := a.zxy * b.yzx
    return i - j
}

blah :: proc(a: Vector3) -> f32 {
    return a.x + a.y + a.z
}
