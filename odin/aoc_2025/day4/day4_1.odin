package day4_1

import "core:fmt"
import "core:os"
import "core:strings"


check :: proc(greed: []string, i,j: int, count: ^int) {
  if greed[i][j] == u8('@') {
    count^ += 1
  }
}


main :: proc() {
  // input, input_ok := os.read_entire_file("./test_input.txt")
  input, input_ok := os.read_entire_file("./input.txt")
  if !input_ok {
    fmt.eprintln("Can't open fil")
    return
  }
  defer delete(input)
  count: u64

  greed, _ := strings.split(transmute(string)input, "\n")
  defer delete(greed)

  paper := u8('@')
  raw_len := len(greed) - 1
  cal_len := len(greed[0])

  for i in 0..<raw_len {
    if len(greed[i]) <= 1 {
      break
    }
    for j in 0..<cal_len {
      paper_count: int
      if greed[i][j] != paper {
        fmt.printf(".")
        continue
      }
      if i == 0 {
        if j == 0 {
          check(greed, i, j, &paper_count)
          if paper_count > 0 {
            count += u64(1)
            fmt.printf("x")
          } else {
            fmt.printf(".")
          }
          continue
        } else if j == cal_len - 1 {
          check(greed, i, j, &paper_count)
          if paper_count > 0 {
            count += u64(1)
            fmt.printf("x")
          } else {
            fmt.printf(".")
          }
          continue
        } else {
          check(greed, i, j - 1, &paper_count)
          check(greed, i, j + 1, &paper_count)
          check(greed, i + 1, j - 1, &paper_count)
          check(greed, i + 1, j, &paper_count)
          check(greed, i + 1, j + 1, &paper_count)
        }
      } else if i == raw_len - 1 {
        if j == 0 {
          check(greed, i, j, &paper_count)
          if paper_count > 0 {
            count += u64(1)
            fmt.printf("x")
          } else {
            fmt.printf(".")
          }
          continue
        } else if j == cal_len - 1 {
          check(greed, i, j, &paper_count)
          if paper_count > 0 {
            count += u64(1)
            fmt.printf("x")
          } else {
            fmt.printf(".")
          }
          continue
        } else {
          check(greed, i, j - 1, &paper_count)
          check(greed, i, j + 1, &paper_count)
          check(greed, i - 1, j - 1, &paper_count)
          check(greed, i - 1, j, &paper_count)
          check(greed, i - 1, j + 1, &paper_count)
        }
      } else {
        if j == 0 {
          check(greed, i - 1, j, &paper_count)
          check(greed, i - 1, j + 1, &paper_count)
          check(greed, i, j + 1, &paper_count)
          check(greed, i + 1, j, &paper_count)
          check(greed, i + 1, j + 1, &paper_count)
        } else if j == cal_len - 1 {
          check(greed, i - 1, j, &paper_count)
          check(greed, i - 1, j - 1, &paper_count)
          check(greed, i, j - 1, &paper_count)
          check(greed, i + 1, j, &paper_count)
          check(greed, i + 1, j - 1, &paper_count)
        } else {
          check(greed, i - 1, j - 1, &paper_count)
          check(greed, i - 1, j, &paper_count)
          check(greed, i - 1, j + 1, &paper_count)
          check(greed, i, j - 1, &paper_count)
          check(greed, i, j + 1, &paper_count)
          check(greed, i + 1, j - 1, &paper_count)
          check(greed, i + 1, j, &paper_count)
          check(greed, i + 1, j + 1, &paper_count)
        }
      }
      if paper_count < 4 {
        count += u64(1)
        fmt.printf("x")
      } else {
        fmt.printf("@")
      }
    }
    fmt.printf("\n")
  }
  fmt.printf("Total count: %d\n", count)
}
