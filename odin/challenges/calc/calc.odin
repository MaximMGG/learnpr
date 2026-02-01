package calc

import "core:fmt"
import "core:os"
import "core:slice"
import "core:strconv"

Token_Type :: enum {
  NUM, ADD, SUB, MUL, DIV, BRACKET_OPEN, BRACKET_CLOSE, BLANK,
}

Token :: struct {
  type: Token_Type,
  val: f64
}

getNextToken :: proc(input: ^[dynamic]Token, i: int) -> (Token, bool) {
  i := i
  i += 1
  for input[i].type == .BLANK {
    i += 1
    if i == len(input) {
      return Token{}, false
    }
  }

  return input[i], true
}

getPrevToken :: proc(input: ^[dynamic]Token, i: int) -> (Token, bool) {
  i := i
  i -= i
  for input[i].type == .BLANK {
    i -= 1
    if i <= 0 {
      return Token{}, false
    }
  }
  return input[i], true
}

calcPriority :: proc(input: ^[dynamic]Token, start: int, end: int) {
  start := start
  end := end
  for i := start; i < end; i += 1  {
    if input[i].type == .MUL || input[i].type == .DIV {
      if i == start || i == end - 1{
        fmt.eprintln("Brocket expression")
        os.exit(1)
      }
      a: Token = input[i - 1]
      b: Token = input[i + 1]
      a.val *= b.val
      ordered_remove(input, i + 1)
      ordered_remove(input, i)
      end -= 2
    }
  }
}


//2*3+1-1-8
//0 2   6 8 10

//3+1-1

calcBrackets :: proc(input: ^[dynamic]Token, start: int, end: int) {
  start := start
  end := end
  find_bracket: int
  bracket_count: int
  for i := start; i < end; i += 1 {
    if input[i].type == .BRACKET_OPEN {
      if find_bracket != 0 {
        bracket_count += 1
      } else {
        find_bracket = i
        bracket_count = 1
      }
      continue
    }
    if input[i].type == .BRACKET_CLOSE {
      if bracket_count != 1 {
        bracket_count -= 1
        continue
      } else {

      }
    }
  }
}

calcExpression :: proc(input: []Token, start: int, end: int) -> f64 {

  return 0
}

parseInput :: proc(input: []u8) -> [dynamic]Token {
  res: [dynamic]Token
  num_buf: [64]u8
  num_i: int

  for i in input {
    if i == ' ' {continue}
    for i >= '0' && i <= '9' {
      num_buf[num_i] = i
      num_i += 1
    }
    if num_i != 0 {
      val, _ := strconv.parse_f64(transmute(string)num_buf[0:num_i])
      append(&res, Token{type = .NUM, val = val})

      slice.zero(num_buf[:])
      num_i = 0
      continue
    }
    switch (i) {
    case '+':
      append(&res, Token{type = .ADD, val = 0})
    case '-':
      append(&res, Token{type = .SUB, val = 0})
    case '*':
      append(&res, Token{type = .MUL, val = 0})
    case '/':
      append(&res, Token{type = .DIV, val = 0})
    case '(':
      append(&res, Token{type = .BRACKET_OPEN, val = 0})
    case ')':
      append(&res, Token{type = .BRACKET_CLOSE, val = 0})
    }
  }

  return res
}


main :: proc() {
  args := os.args

  if len(args) != 2 {
    fmt.eprintln("Usage calc [expression]")
  }
  input := parseInput(transmute([]u8)args[1])
  defer delete(input)
  res := calcExpression(input[:], 0, len(input))
  fmt.printf("Result os expressin %v : %d\n", args[1], res)
}

