package track_leaks


import "core:fmt"
import "core:mem"


main :: proc() {
    when ODIN_DEBUG {
        track: mem.Tracking_Allocator
        mem.tracking_allocator_init(&track, context.allocator)
        context.allocator = mem.tracking_allocator(&track)


        defer {
            if len(track.allocation_map) > 0 {
                for _, entry in track.allocation_map {
                    fmt.eprintf("%v leaked %v bytes\n", entry.location, entry.size)
                }
            }
            mem.tracking_allocator_destroy(&track)
        }
    }

    
    //one()
    arr := two()
    defer {
        for i in arr {
            free(i)
        }
    }
}

one :: proc() {

    i := make([]int, 4096)
    defer delete(i)
    
}
allocate_7 :: proc(loc := #caller_location) -> ^int {
    number := new(int, loc = loc)
    number^ = 7
    return number
}

two :: proc() -> (res: [3]^int) {
    res[0] = allocate_7()
    res[1] = allocate_7()
    res[2] = allocate_7()
    return
}
