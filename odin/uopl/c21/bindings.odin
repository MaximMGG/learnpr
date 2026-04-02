package bindings

import "core:fmt"
import "base:runtime"

import "my_lib"


custom_context: runtime.Context


my_callback :: proc "c" (ts: my_lib.TestStruct) {
    context = custom_context

    fmt.println("In the callback")
    fmt.println()
}

main :: proc() {
    custom_context = context

    my_lib.set_callback(my_callback)
    ts := my_lib.TestStruct{
	num = 7,
	flt_num = 23.12
    }

    my_lib.do_stuff(ts)
}
