package perf_test


import "core:fmt"
import "core:strings"
import "core:slice"

increaseKey :: proc(key: []u8) -> bool {
  if key[3] == '9' {
    return false
  }
  i := len(key) - 1

  for {
    if key[i] == '9' {
      key[i] = '0'
      i -= 1
    } else {
      key[i] += 1
      break
    }
  }
  return true
}


main :: proc() {
  m: map[string]u32

  key := strings.clone_from_cstring("Key000000")
  val: u32

  for increaseKey(transmute([]u8)key) {
    m[strings.clone(key)] = val
    val += 1
  }

  fmt.println("Work is done, len:", len(m))

  for k, v in &m {
    delete(k)
  }

  delete(m)
}
