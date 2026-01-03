package math_test

import "core:fmt"
import "core:math/linalg"

Vector4 :: [4]f32
Matrix4 :: [4]Vector4

main :: proc() {
  a := matrix[4, 4]int{1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4} 
  b := linalg.transpose(a)
  fmt.println(a)
  fmt.println(b)

}
