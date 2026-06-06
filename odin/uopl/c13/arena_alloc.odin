package arena_alloc


import "core:fmt"
import "core:mem"



main :: proc() {
    number: f32 = 7
    _number: f64 = cast(f64)number
    number_f64_ptr := cast(^f64)&_number
    fmt.println(number_f64_ptr^)
    mem.set(cast(rawptr)number_f64_ptr, 0, size_of(number_f64_ptr^))
    fmt.println(number_f64_ptr^ + cast(f64)7)
}
