package mat_rotate


import "core:fmt"
import "core:math/linalg"


main :: proc() {

  m := linalg.MATRIX4F32_IDENTITY;

  m *= linalg.matrix4_rotate_f32(f32(linalg.to_radians(45.0)), linalg.Vector3f32{1.0, 0.5, 0.8});
  m *= linalg.matrix4_translate(linalg.Vector3f32{10, 20, 30})

  fmt.println(m)
}
