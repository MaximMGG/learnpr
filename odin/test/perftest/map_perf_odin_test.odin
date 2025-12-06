package main



import "core:fmt"
import "core:strings"


increment_key :: proc(key: []u8) -> bool {
  i := len(key) - 1
  for {
    if key[i] < '9' {
      key[i] += 1
      break
    } else {
      key[i] = '0'
      i -= 1
      continue
    }
  }
  if key[3] == '1' {
    return false
  }
  return true

}

main :: proc() {

  key: [9]u8 = {'K', 'e', 'y', '0','0','0','0','0','0'}
  val: i32 = 1
  m: map[string]i32

  for increment_key(key[:]) {
    m[strings.clone_from_bytes(key[:])] = val
    val += 1
  }

  for k, v in m {
    fmt.println("Key -> ", k, ", Val -> ", v)
    delete(k)
  }
  fmt.println("Total elemens: ", len(m))
}
