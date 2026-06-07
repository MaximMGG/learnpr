package calc

import "core:os"
import "core:io"
import "core:fmt"
import "core:strconv"
import "core:slice"
import "core:strings"
import "core:mem"


Calc_Error :: enum {
    None,
    Tokenize_Error,
    Tokenize_Validator_Error
}


Token_Type :: enum {
    MUL, ADD, SUB, DIV, O_BRACKET, C_BRACKET, SQUARE, NUM, NONE
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
        case .NONE:
        }
    case .O_BRACKET: {
        switch next {
        case .MUL, .SUB, .DIV, .ADD:
        case .O_BRACKET:
        case .C_BRACKET:
        case .NUM:
        case .SQUARE:
        case .NONE:
        }
    }
    case .C_BRACKET: {
        switch next {
        case .MUL, .SUB, .DIV, .ADD:
        case .O_BRACKET:
        case .C_BRACKET:
        case .NUM:
        case .SQUARE:
        case .NONE:
        }
    }
    case .NUM: {
        switch next {
        case .MUL, .SUB, .DIV, .ADD:
        case .O_BRACKET:
        case .C_BRACKET:
        case .NUM:
        case .SQUARE:
        case .NONE:
        }
    }
    case .SQUARE:
    case .NONE:
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

check_negative_value :: proc(c: u8) -> bool {

    return false
}

tokenize :: proc(user_input: []u8) -> ([dynamic]Calc_Token, Calc_Error) {
    tokens: [dynamic]Calc_Token
    user_input_prep := strings.trim(transmute(string)user_input, " \r\n")

    number_buf: [64]u8
    number_buf_i: int
    find_number: bool
    maybe_negative: bool

    brecket: int

    next: Calc_Token
    cur: Calc_Token
    i: int

    for i < len(user_input) {
        if (user_input[i] >= '0' && user_input[i] <= '9') || user_input[i] == '.' {
            if user_input[i] == '.' {
                if number_buf_i >= 1 && number_buf[0] != '-' {
                    number_buf[number_buf_i] = '.'
                    number_buf_i += 1
                    i += 1
                    continue
                } else {
                    fmt.eprintln("Wrong . use, can't parse number")
                    delete(tokens)
                    return {}, .Tokenize_Error
                }
            } else {
                if !find_number {
                    find_number = true
                    number_buf[number_buf_i] = user_input[i]
                    number_buf_i += 1
                    i += 1
                    continue
                } else {
                    number_buf[number_buf_i] = user_input[i]
                    number_buf_i += 1
                    i += 1
                    continue
                }
            }
        } else {
            if find_number == true {
                val, val_ok := strconv.parse_f64(transmute(string)number_buf[:number_buf_i])
                if val_ok {
                    append(&tokens, Calc_Token{type = .NUM, val = val})
                    slice.zero(number_buf[:])
                    number_buf_i = 0
                    find_number = false
                } else {
                    fmt.eprintfln("%s can't parse that number", transmute(string)number_buf[:number_buf_i])
                    delete(tokens)
                    return {}, .Tokenize_Error
                }
            }
        }

        switch user_input[i] {
        case '+':
            append(&tokens, Calc_Token{type = .ADD})
        case '-':
            if i + 1 < len(user_input) {
                if ((user_input[i + 1] >= '0') && (user_input[i + 1] <= '9')) || user_input[i + 1] == '.' {
                    find_number = true
                    number_buf[0] = '-'
                    number_buf_i += 1
                } else if user_input[i + 1] == ' ' {
                    append(&tokens, Calc_Token{type = .SUB})
                }
            } else {
                fmt.eprintfln("%s\nWrong expression in %d postion", user_input, i)
                delete(tokens)
                return {}, .Tokenize_Error
            }
        case '*':
            append(&tokens, Calc_Token{type = .MUL})
        case '/':
            append(&tokens, Calc_Token{type = .DIV})
        case '(':
            append(&tokens, Calc_Token{type = .O_BRACKET})
            brecket += 1
        case ')':
            if brecket >= 1 {
                brecket -= 1
            } else {
                fmt.eprintln("Brocket breckets pattern, closed breckets more than opened")
                delete(tokens)
                return {}, .Tokenize_Error
            }
            append(&tokens, Calc_Token{type = .C_BRACKET})
        }
        i += 1
    }
    if brecket != 0 {
        fmt.eprintln("Brocket breckets pattern, opened breckets more than closed")
        delete(tokens)
        return {}, .Tokenize_Error
    }
    if find_number {
        val, val_ok := strconv.parse_f64(transmute(string)number_buf[:number_buf_i])
        if val_ok {
            append(&tokens, Calc_Token{type = .NUM, val = val})
        } else {
            fmt.eprintfln("%s can't parse that number", transmute(string)number_buf[:number_buf_i])
            delete(tokens)
            return {}, .Tokenize_Error
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

    when ODIN_DEBUG {
        tracking: mem.Tracking_Allocator
        defer mem.tracking_allocator_destroy(&tracking)
        mem.tracking_allocator_init(&tracking, context.allocator)
        tr_allocator := mem.tracking_allocator(&tracking)
        context.allocator = tr_allocator

        defer {
            for _, v in tracking.allocation_map {
                fmt.printfln("Leakd %d bytes, from: %s", v.size, v.location)
            }
        }
    }


    input := "(3 + 4) * 1 - -8"
    tokens, ok := tokenize(transmute([]u8)input)
    defer delete(tokens)
    fmt.println(tokens)

    fmt.print("=> ")

}
