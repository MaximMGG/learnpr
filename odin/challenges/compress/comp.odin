package comp

import "core:fmt"
import "core:os"
import "core:io"
import "core:mem"

main :: proc() {
    when ODIN_DEBUG {
	track := mem.Tracking_Allocator
	mem.tracking_allocator_init(&track, context.allocator)
	context.allocator = mem.tracking_allocator(&track)
    }
    defer {
	when ODIN_DEBUG {
	    for _, leak in track {
		fmt.printf("%v leaked %m\n", leak.location, leak.size)
	    }
	    mem.tracking_allocator_destroy(&track)
	}
    }
    
    if len(os.args) < 2 {
	fmt.eprintf("Usage comp file_name")
	return
    }

    f, f_ok := os.open(os.args[1])
    if f_ok != nil {
	fmt.eprintln("Cant open file:", os.args[1])
	return
    }
    stat, stat_ok := os.fstat(f)
    if stat_ok != nil {
	fmt.eprintln("os.fstat error")
	return
    }
    buf: []u8 = make([]u8, stat.size)
    defer delete(buf)

}
