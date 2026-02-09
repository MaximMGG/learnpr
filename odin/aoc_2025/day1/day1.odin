package day1

import "core:fmt"
import os "core:os/os2"
import "core:strings"
import "core:strconv"

main :: proc() {
		buf, read_err := os.read_entire_file("day1_input.txt", context.allocator)
		defer delete(buf)
	
		lines := strings.split(string(buf), "\n")
		defer delete(lines)

		point: int = 50
		pass: int = 0
		
		for l in lines {
				fmt.printf("Shift is: %s, val before shift: %d", l, point)
				if len(l) <= 1 {fmt.println();continue}
				val, val_ok := strconv.parse_int(l[1:len(l)], 10)
				if !val_ok {
						fmt.eprintln("Can't parse int")
						return
				}
				if val > 99 {
						val %= 100
				}
				if l[0] == 'R' {
						if point + val > 99 {
								point = point + val - 100
						} else {
								point += val
						}
				} else if l[0]  == 'L' {
						if val > point {
								point = point - val + 100
						} else {
								point -= val
						}
				}
				fmt.printf(" :: Val after shift: %d\n", point)
				if point == 0 {
						pass += 1
				}
		}
		fmt.printf("Finale code is: %d\n", point)
		fmt.println("Password is: ", pass)
		
}
