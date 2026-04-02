package day4_2

import "core:fmt"
import "core:os"
import "core:strings"


check :: proc(greed: [][]u8, i, j: int, count: ^int) {
  if greed[i][j] == u8('@') {
    count^ += 1
  }
}

process_papers :: proc(greed: [][]u8) -> int {
  total: int

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
            total += 1
            fmt.printf("x")
            greed[i][j] = '.'
          } else {
            fmt.printf(".")
          }
          continue
        } else if j == cal_len - 1 {
          check(greed, i, j, &paper_count)
          if paper_count > 0 {
            total += 1
            fmt.printf("x")
            greed[i][j] = '.'
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
            total += 1
            fmt.printf("x")
            greed[i][j] = '.'
          } else {
            fmt.printf(".")
          }
          continue
        } else if j == cal_len - 1 {
          check(greed, i, j, &paper_count)
          if paper_count > 0 {
            total += 1
            fmt.printf("x")
            greed[i][j] = '.'
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
        total += 1
        fmt.printf("x")
        greed[i][j] = '.'
      } else {
        fmt.printf("@")
      }
    }
    fmt.printf("\n")
  }

  return total
}


main :: proc() {
  // input, input_ok := os.read_entire_file("./test_input.txt") 
  input, input_ok := os.read_entire_file("./input.txt") 
  if !input_ok {
    fmt.eprintln("Can't open file")
    return
  }
  defer delete(input)

  lines, _ := strings.split(transmute(string)input, "\n")
  defer delete(lines)

  storage := transmute([][]u8)lines

  total: int

  for {
    res := process_papers(storage)
    if res == 0 {
      break
    } else {
      total += res
      fmt.printf("Remove %d papers\n", res)
    }
  }

  fmt.printf("Total remove: %d\n", total)
}
