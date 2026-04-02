package c17

import "core:fmt"
import test "test"


main :: proc() {
    test.test_proc()
    test.print_name("soidfjoi")
    s := "Hello world!"

    fmt.println(test.test_str_proc(s))
    test.print_name("P")

}
