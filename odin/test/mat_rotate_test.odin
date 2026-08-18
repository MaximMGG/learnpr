package mat_rotate


import "core:fmt"
import "core:math/linalg"


main :: proc() {

  m: linalg.Matrix4f32 = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32}

  m *= linalg.matrix4_rotate_f32(f32(linalg.to_radians(45.0)), linalg.Vector3f32{1.0, 0.5, 0.8});

  fmt.println(m)
}
