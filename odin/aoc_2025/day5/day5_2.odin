package day5_2

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

Range :: struct {
  first: int,
  last: int
}

check_range :: proc(ranges: ^[dynamic]Range, id: Range) {
  change_first: bool
  change_last: bool
  id := id
  for r in ranges {
    if id.first >= r.first && id.first <= r.last {
      id.first = r.last + 1
      change_first = true
      check_range(ranges, id)
    }
  }
  if change_first {
    for r in ranges {
      if id.last >= r.first && id.last <= r.last {
        id.last = r.first - 1
        change_last = true
      }
    }
  } else {
    for r in ranges {
      if id.last >= r.first && id.last <= r.last {
        id.last = r.first - 1
        change_last = true
        check_range(ranges, id)
      }
    }
  }
  append(ranges, id)
}

calc_all_ranges :: proc(ranges: [dynamic]Range) -> int {

  return 0
}

main :: proc() {
  input, input_ok := os.read_entire_file("./test_input.txt")
  // input, input_ok := os.read_entire_file("./input.txt")
  if !input_ok {
    fmt.eprintln("Can't open file")
    return
  }
  defer delete(input)

  total_id: [dynamic]Range
  defer delete(total_id)

  separate_index := strings.index(transmute(string)input, "\n\n")
  fmt.printf("Index of \\n\\n: %d\n", separate_index)
  ranges, _ := strings.split(transmute(string)input[0:separate_index], "\n")
  defer delete(ranges)
  ids, _ := strings.split(transmute(string)input[separate_index + 2:], "\n")
  defer delete(ids)

  for r in ranges {
    tmp_range_string := strings.split(r, "-")
    defer delete(tmp_range_string)
    tmp_range: Range
    tmp_range.first, _ = strconv.parse_int(tmp_range_string[0], 10)
    tmp_range.last, _ = strconv.parse_int(tmp_range_string[1], 10)
    check_range(&total_id, tmp_range)
  }
  for r in ranges {
    fmt.println(r)
  }

}
