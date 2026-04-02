package day5_1

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

Range :: struct {
  first: int,
  last: int
}


check_id :: proc(range: [dynamic]Range, id: int) -> bool {
  for r in range {
    if id >= r.first && id <= r.last {
      return true
    }
  }
  return false
}


main :: proc() {
  // input, input_ok := os.read_entire_file("./test_input.txt")
  input, input_ok := os.read_entire_file("./input.txt")
  if !input_ok {
    fmt.eprintln("Can't open file")
    return
  }
  defer delete(input)

  total_id: int

  separate_index := strings.index(transmute(string)input, "\n\n")
  fmt.printf("Index of \\n\\n: %d\n", separate_index)
  ranges, _ := strings.split(transmute(string)input[0:separate_index], "\n")
  defer delete(ranges)
  ids, _ := strings.split(transmute(string)input[separate_index + 2:], "\n")
  defer delete(ids)
  range: [dynamic]Range
  defer delete(range)

  for r in ranges {
    tmp_range_string := strings.split(r, "-")
    defer delete(tmp_range_string)
    tmp_range: Range
    tmp_range.first, _ = strconv.parse_int(tmp_range_string[0], 10)
    tmp_range.last, _ = strconv.parse_int(tmp_range_string[1], 10)
    append(&range, tmp_range)
  }

  for id in ids {
    tmp_id, _ := strconv.parse_int(id, 10)
    if check_id(range, tmp_id) {
      fmt.printf("%d in range\n", tmp_id)
      total_id += 1
    }
  }
  fmt.printf("Total frash id: %d\n", total_id)
}
