package dyn_array_remove_test


import "core:fmt"

da_remove :: proc(arr: ^[dynamic]$T, val: T) {
  for  i in 0..<len(arr^) {
    if arr[i] == val {
      ordered_remove(arr, i)
    } 
  }
}


main :: proc() {
  arr: [dynamic]int
  defer delete(arr)
  append(&arr, 1)
  append(&arr, 2)
  append(&arr, 3)
  append(&arr, 4)
  append(&arr, 5)
  da_remove(&arr, 3)

  fmt.println(arr)
}
