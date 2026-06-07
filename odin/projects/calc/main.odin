package calc

import "core:os"
import "core:io"
import "core:fmt"
import "core:strconv"
import "core:slice"


Calc_Error :: enum {
    None,
    Tokenize_Error,
    Tokenize_Validator_Error
}


Token_Type :: enum {
    MUL, ADD, SUB, DIV, O_BRACKET, C_BRACKET, SQUARE, NUM
}

Calc_Token :: struct {
    type: Token_Type,
    val: f64
}

tokenizer_validate_check_next :: #force_inline proc(cur: Token_Type, next: Token_Type, o_brecket: ^int, c_brecket: ^int) -> (string, Calc_Error){
    switch cur {
    case .MUL, .SUB, .DIV, .ADD:
        switch next {
        case .MUL, .SUB, .DIV, .ADD:
            return "MUL, SUB, DIV, ADD can't be upplyed to each other!", .Tokenize_Validator_Error
        case .O_BRACKET:
            o_brecket^ += 1
            return "", .None
        case .C_BRACKET:
            c_brecket^ += 1
            if c_brecket^ > o_brecket^ {
                return "Closed breckets more then open!", .Tokenize_Validator_Error
            }
        case .NUM:
            return "", .None
        case .SQUARE:
        }
    case .O_BRACKET: {
        switch next {
        case .MUL, .SUB, .DIV, .ADD:
        case .O_BRACKET:
        case .C_BRACKET:
        case .NUM:
        case .SQUARE:
        }
    }
    case .C_BRACKET: {
        switch next {
        case .MUL, .SUB, .DIV, .ADD:
        case .O_BRACKET:
        case .C_BRACKET:
        case .NUM:
        case .SQUARE:
        }
    }
    case .NUM: {
        switch next {
        case .MUL, .SUB, .DIV, .ADD:
        case .O_BRACKET:
        case .C_BRACKET:
        case .NUM:
        case .SQUARE:
        }
    }
    case .SQUARE:
    }
    return "", .None
}

tokenzer_validate :: proc(tokens: [dynamic]Calc_Token) -> bool {
    open_bracket: int
    close_bracket: int

    cur: int
    prev: int
    next: int = 1

    for next < len(tokens) {

    }


    return true
}

tokenize :: proc(user_input: []u8) -> ([dynamic]Calc_Token, Calc_Error) {
    tokens: [dynamic]Calc_Token

    number_buf: [64]u8
    number_buf_i: int
    find_number: bool
    maybe_negatime: bool

    for v in user_input {

        if (v >= '0') && (v <= '9') {
            if find_number {
                number_buf[number_buf_i] = v
                number_buf_i += 1
            } else {
                find_number = true
                if maybe_negatime {
                    maybe_negatime = false
                    number_buf[number_buf_i] = '-'
                    number_buf_i += 1
                }
                number_buf[number_buf_i] = v
                number_buf_i += 1
            }
            continue
        }

        if v == '.' {
            if find_number {
                number_buf[number_buf_i] = v
                number_buf_i += 1
            } else {
                find_number = true
                if maybe_negatime {
                    maybe_negatime = false
                    number_buf[number_buf_i] = '-'
                    number_buf_i += 1
                }
                number_buf[number_buf_i] = '0'
                number_buf[number_buf_i + 1] = '.'
                number_buf_i += 2
            }
            continue
        }

        if find_number {
            find_number = false
            val, val_ok := strconv.parse_f64(transmute(string)number_buf[:number_buf_i])
            if val_ok {
                append(&tokens, Calc_Token{type = .NUM, val = val})
                slice.zero(number_buf[:])
                number_buf_i = 0
            } else {
                delete(tokens)
                return {}, .Tokenize_Error
            }
        }

        switch v {
        case '+':
            append(&tokens, Calc_Token{type = .ADD})
        case '-':
            maybe_negatime = true
        case '/':
            append(&tokens, Calc_Token{type = .DIV})
        case '*':
            append(&tokens, Calc_Token{type = .MUL})
        case '(':
            append(&tokens, Calc_Token{type = .O_BRACKET})
        case ')':
            append(&tokens, Calc_Token{type = .C_BRACKET})
        case ' ':
            if maybe_negatime {
                maybe_negatime = false
                append(&tokens, Calc_Token{type = .SUB})
            }

        }
    }

    return tokens, .None
}



calc_runtime :: proc() {
    reader := os.to_reader(os.stdin)
    for {
        fmt.println("Enter expression down bellow.")
        buf: [256]u8
        read_bytes, read_err := io.read(reader, buf[:])
        if read_err != .None {
            fmt.eprintln("Read error, something got complitely wrong...")
            os.exit(1)
        }
        user_input := buf[:read_bytes]
        tokens, tokenize_err := tokenize(user_input)
        if tokenize_err != .None {
            fmt.eprintln("Error while tokenize user input...")
            os.exit(1)
        }
    }
}


main :: proc() {

    fmt.print("=> ")




}
