package mat_tests


import "core:fmt"
import la "core:math/linalg"


mat_perspective :: proc() {
  a := la.Matrix4f32{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}
  a *= la.matrix4_perspective_f32(f32(la.to_radians(70.0)), 1280.0 / 720.0, 0.1, 100.0)

  fmt.println(a)
}


mat_combo :: proc() {
  a := la.Matrix4f32{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}
  a *= la.matrix4_scale(la.Vector3f32{7, 1, 8})
  a *= la.matrix4_rotate_f32(f32(la.to_radians(77.0)), la.Vector3f32{1.1, 0.2, 3.3})
  a *= la.matrix4_translate_f32(la.Vector3f32{6, 6, 6})

  fmt.println(a)
}


mat_scale :: proc() {

  a := la.MATRIX4F32_IDENTITY
  a *= la.matrix4_scale(la.Vector3f32{4, 7, 2})

  fmt.println(a)
}


mat_translate :: proc() {
  a := la.MATRIX4F32_IDENTITY
  a *= la.matrix4_translate_f32(la.Vector3f32{10, 20, 30})

  fmt.println(a)

}


mat_mul :: proc() {

  a := la.Matrix4f32{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}
  b := la.Matrix4f32{17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32}

  c := a * b

  c *= la.matrix4_rotate_f32(f32(la.to_radians(45.0)), la.Vector3f32{1.0, 0.5, 0.8})

  fmt.println(c)


}



main :: proc() {
  //mat_mul()
  // mat_translate()
  //mat_scale()
  // mat_combo()
  mat_perspective()

}
