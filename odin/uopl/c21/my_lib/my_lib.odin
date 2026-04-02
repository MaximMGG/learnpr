package my_lib

import "core:fmt"
import "core:c"

when ODIN_OS == .Linux {
    foreign import my_lib {
	"my_lib.a",
    }
} else {}


Callback :: proc "c"(TestStruct)

@(default_calling_convention="c")
foreign my_lib {
    set_callback :: proc(c: Callback) ---
    do_stuff :: proc(ts: TestStruct) ---
}


TestStruct :: struct {
    num: c.int,
    flt_num: c.float,
}
