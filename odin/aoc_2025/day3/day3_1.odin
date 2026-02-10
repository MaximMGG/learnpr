package day3_1

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

biggest_index :: proc(line: string) -> int {
  b: byte = '0'
  prev: byte = '0'
  i: int
  k: int
  for j in 0..<len(line) {
    if line[j] > b {
      b = line[j]
      k = i
      i = j
    }
  } 
  if i == len(line) - 1 {
    return k
  }

  return i
}


main :: proc() {
  // input, input_ok := os.read_entire_file("./test_input.txt")
  input, input_ok := os.read_entire_file("./input.txt")

  if !input_ok {
    fmt.eprintln("Can't read file")
    return
  }
  defer delete(input)
  total_sum: u64


  battaries :=  strings.split(transmute(string)input, "\n")
  defer delete(battaries)

  for battary in battaries {
    if len(battary) < 2 {
      continue
    }
    first := biggest_index(battary)
    b: byte = '0'
    second: int = 0
    for i := first + 1; i < len(battary); i += 1 {
      if battary[i] > b {
        second = i
        b = battary[i]
      }
    }
    num_buf: [2]byte
    num_buf[0] = battary[first]
    num_buf[1] = battary[second]

    res_num, _ := strconv.parse_int(transmute(string)num_buf[:], 10)

    fmt.printf("Beggest in battary %s is %d\n", battary, res_num)
    total_sum += u64(res_num)
  }

  fmt.printf("Total sum: %d\n", total_sum)
}
