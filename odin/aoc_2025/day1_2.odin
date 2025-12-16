package day1_2

import "core:fmt"
import os "core:os/os2"
import "core:strconv"
import "core:strings"


main :: proc() {
	buf, buf_ok := os.read_entire_file("day1_input.txt", context.allocator)
	if buf_ok != nil {
		fmt.eprintln("Can't read intire file")
		return
	}
	defer delete(buf)
	lines := strings.split(string(buf), "\n")
	delete(lines)

	pass: int = 0
	point: int = 50

	for l in lines {
		if len(l) <= 1 {
			continue
		}
		val, val_ok := strconv.parse_int(l[1:len(l)], 10)
		if !val_ok {
			fmt.eprintln("Can't parse int:", l)
			return
		}
			if l[0] == 'R' {
					point += val
					for point > 99 {
							pass += 1
							point -= 100
					}
			}
			if l[0] == 'L' {
					point -= val
					for point < 0 {
							pass += 1
							point += 100
					}
			}
			if point == 0 {
					pass += 1
			}
	}
	fmt.println("Final pass is: ", pass)
}
