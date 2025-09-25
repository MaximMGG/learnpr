package test

import "core:fmt"

print_name :: proc(s: string) {
    if s == "P" {
	print_name_helper(s)
    } else {
	fmt.println(s)
	test_proc()
    }

    //three_print()

}

@(private="file")
print_name_helper :: proc(s: string) {
    fmt.println(s)
}
