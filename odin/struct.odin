package struct_odin

import "core:fmt"


Vector2 :: struct {
    x: f32,
    y: f32,
}

Vector3 :: struct {
    x, y, z: f32
}


main :: proc() {
    v := Vector2{1, 2}
    p := &v
    p.x = 13342
    fmt.println(v)

    x: Vector3
    x = Vector3{}
    x = Vector3{1, 2, 2}

    z := Vector3{z=1, y=3}
    assert(z.z == 1)
    assert(z.y == 3)
    assert(z.x == 0)
}
