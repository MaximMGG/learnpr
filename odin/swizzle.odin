package swizzle

import "core:fmt"
Vector3 :: distinct [3]f32

main :: proc() {
    // a := [3]f32{10, 20, 30}
    // b := swizzle(a, 2, 1, 0)
    // assert(b == [3]f32{30, 20, 10})
    //
    // c := swizzle(a, 0, 0)
    // assert(c == [2]f32{10, 10})
    // assert(c == 10)
    a := Vector3{1, 2, 3}
    b := Vector3{5, 6, 7}
    c := (a * b) / 2 + 1
    d := c.x + c.y + c.z
    fmt.printf("%.1f\n", d)

    x := cross(a, b)
    fmt.println(x)
    fmt.println(blah(x))


}

cross :: proc(a, b: Vector3) -> Vector3 {
    i := swizzle(a, 1, 2, 0) * swizzle(b, 2, 0, 1)
    j := swizzle(a, 2, 0, 1) * swizzle(b, 1, 2, 0)
    return i - j
}

cross_shorter :: proc(a, b: Vector3) -> Vector3 {
    i := a.yzx * b.zxy
    j := a.zxy * b.yzx
    return i - j
}

blah :: proc(a: Vector3) -> f32 {
    return a.x + a.y + a.z
}




