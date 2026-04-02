package day2_1

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

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
    for i := first; i <= last; i += 1 {
      id_buf := fmt.aprintf("%d", i)
      defer delete(id_buf)
      fmt.println(id_buf)
      id_first := id_buf[0:len(id_buf) / 2]
      id_second := id_buf[len(id_buf) / 2:]
      if id_first == id_second {
        fmt.printf("Invalid ID: %d\n", i)
        invalid_sum += u64(i)
      }
    }
  }
  fmt.printf("Total invalid sum: %d\n", invalid_sum)
}
