package day2_2


import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

invalid_case :: proc(num: []u8) -> bool {
  for i in 0..<len(num) - 1 {
    if num[i] == num[i + 1] {
      continue
    } else {
      return false
    }
  }
  return true
}


main :: proc() {
  // buf, buf_ok := os.read_entire_file("./test_input.txt")
  buf, buf_ok := os.read_entire_file("./input.txt")
  if !buf_ok {
    fmt.eprintln("Can't open file")
    return
  }

  defer delete(buf)

  ids := strings.split(transmute(string)buf, ",")
  defer delete(ids)

  invalid_sum: u64

  for pair in ids {
    tmp_pair := strings.split(pair, "-")
    defer delete(tmp_pair)
    first, _ := strconv.parse_int(tmp_pair[0], 10)
    last, _ := strconv.parse_int(tmp_pair[1], 10)
    m_loop: for i := first; i <= last; i += 1 {
      if i < 11 {
        continue
      }
      id_buf := fmt.aprintf("%d", i)
      defer delete(id_buf)
      step_len: int = 2

      if invalid_case(transmute([]u8)id_buf) {
        fmt.printf("Invalid id: %d\n", i)
        invalid_sum += u64(i)
        continue
      }

      for step_len <= len(id_buf) / 2 {
        step_beg := 0
        step_end := step_len
        if len(id_buf) % step_len == 0 {
          for {
            f := id_buf[step_beg:step_end]
            s := id_buf[step_end:step_end + step_len]
            if f == s {
              if step_end + step_len == len(id_buf) {
                fmt.printf("Invalid id: %d\n", i)
                invalid_sum += u64(i)
                continue m_loop
              } else {
                step_beg = step_end
                step_end += step_len
              }
            } else {
              step_len += 1
              break
            }
          }
        } else {
          step_len += 1
          continue
        }
      }
    }
  }
  fmt.printf("Total invalid sum: %d\n", invalid_sum)
}
