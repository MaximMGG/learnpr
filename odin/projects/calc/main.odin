package calc

import "core:fmt"
import "core:io"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"


Calc_Error :: enum {
	None,
	No_Calc,
	Tokenize_Error,
	Calc_Expression_In_Range_Error,
	Calc_Expression_Error,
	Calc_Prcessing_Error,
}


Token_Type :: enum {
	MUL,
	ADD,
	SUB,
	DIV,
	O_BRACKET,
	C_BRACKET,
	SQUARE,
	NUM,
	NONE,
}

Calc_Token :: struct {
	type: Token_Type,
	val:  f64,
}


calc_expression :: proc(tokens: ^[dynamic]Calc_Token, pos: int) -> Calc_Error {
	first := &tokens[pos - 1]
	second := &tokens[pos + 1]

	#partial switch tokens[pos].type {
	case .MUL:
		first.val *= second.val
	case .SUB:
		first.val -= second.val
	case .ADD:
		first.val += second.val
	case .DIV:
		first.val /= second.val
	}

	ordered_remove(tokens, pos + 1)
	ordered_remove(tokens, pos)

	return .None
}


calc_expression_in_range :: proc(tokens: ^[dynamic]Calc_Token, from: int, to: int) -> Calc_Error {
	if to - from <= 1 {
		return .No_Calc
	}

	to := to
	i: int = from

	for i < to {
		if tokens[i].type == .MUL || tokens[i].type == .DIV {
			calc_expression(tokens, i)
			to -= 2
			i = from
			continue
		}
		i += 1
	}

	i = from
	for i < to {
		if tokens[i].type == .ADD || tokens[i].type == .SUB {
			calc_expression(tokens, i)
			to -= 2
			i = from
			continue
		}
		i += 1
	}

	return .None
}
//(2 + 3 - (4 * 1 + (1 + 1)))

//(3 + 3) + (1 + 8 - (3 + 3))
check_breckets :: proc(tokens: ^[dynamic]Calc_Token) -> (bool, Calc_Error) {
	open_i: int
	close_i: int

	for i in 0 ..< len(tokens) {
		if tokens[i].type == .O_BRACKET {
			open_i = i
		}
		if tokens[i].type == .C_BRACKET {
			close_i = i
			status := calc_expression_in_range(tokens, open_i + 1, close_i - 1)
			if status == .None {
				ordered_remove(tokens, open_i + 2)
				ordered_remove(tokens, open_i)
			}
			return true, .None
		}
	}

	return false, .None
}


process_calculation :: proc(tokens: ^[dynamic]Calc_Token) -> (f64, Calc_Error) {

	for {
		if ok, err := check_breckets(tokens); ok {
			continue
		} else {
			break
		}
	}

	calc_expression_in_range(tokens, 0, len(tokens))
	if len(tokens) != 1 {
		return f64(0), .Calc_Prcessing_Error
	}

	return tokens[0].val, .None

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
					fmt.eprintfln(
						"%s can't parse that number",
						transmute(string)number_buf[:number_buf_i],
					)
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
				if ((user_input[i + 1] >= '0') && (user_input[i + 1] <= '9')) ||
				   user_input[i + 1] == '.' {
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
		fmt.print("Enter expression down bellow.\n=>")
		buf: [256]u8
		read_bytes, read_err := io.read(reader, buf[:])
		if read_err != .None {
			fmt.eprintln("Read error, something got complitely wrong...")
			os.exit(1)
		}
		if transmute(string)buf[:read_bytes] == "exit\n" {
			fmt.println("Goodby")
			break
		}
		user_input := buf[:read_bytes]
		tokens, tokenize_err := tokenize(user_input)
		if tokenize_err != .None {
			fmt.eprintln("Error while tokenize user input...")
			os.exit(1)
		}
		val, val_ok := process_calculation(&tokens)
		if val_ok != .None {
			fmt.eprintln("Error while processing calculation...")
			delete(tokens)
			os.exit(1)
		}
		fmt.printfln("Anwer is: %.2f", val)
		delete(tokens)
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

	calc_runtime()
}
