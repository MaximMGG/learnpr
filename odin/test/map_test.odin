package map_test


import "core:fmt"

main :: proc() {


  a: map[i32]u32


  val: u32

  for i in 0..<300000 {
    val += 1
    a[i32(i)] = val
  }


  res := a[3333]
  fmt.println(res)

  delete(a)
}
