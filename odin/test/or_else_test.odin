package or_else_test

import "core:fmt"


ret_int :: proc(n: int) -> (int, bool) {
  if n > 0 {
    return 2, true
  } else {
    return 1, false
  }
}

main :: proc() {
  a := ret_int(-1) or_else 777
  fmt.println(a)
}
