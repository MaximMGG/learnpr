package day3_2


import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"

get_biggest :: proc(line: string, first: int, last: int) -> int {
  big: byte = '0'
  big_i := 0

  for i := first; i < len(line) - last; i += 1 {
    if line[i] > big {
      big = line[i]
      big_i = i
    }
  }
  return big_i
}


main :: proc() {
  // input, input_ok := os.read_entire_file("./test_input.txt")
  input, input_ok := os.read_entire_file("./input.txt")
  if !input_ok {
    fmt.eprintln("Can't open file")
    return
  }
  defer delete(input)

  battaries := strings.split(transmute(string)input, "\n")
  defer delete(battaries)

  total_sum: u64
  tmp_bat: [12]byte
  tmp_i: int

  for battary in battaries {
    if len(battary) < 1 {
      continue
    }
    index: int = 0 
    for i in 0..<12 {
      index = get_biggest(battary, index, 11 - i)
      tmp_bat[tmp_i] = battary[index]
      tmp_i += 1
      index += 1
    }
    tmp_num, _ := strconv.parse_int(transmute(string)tmp_bat[:], 10)
    fmt.printf("In battray %s -> %d\n", battary, tmp_num)
    total_sum += u64(tmp_num)
    slice.zero(tmp_bat[:])
    tmp_i = 0
    index = 0
  }

  fmt.printf("Total sum: %d\n", total_sum)
}






