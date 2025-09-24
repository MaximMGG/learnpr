package arena_alloc


import "core:fmt"



main :: proc() {
    number: f32 = 7
    number_f64_ptr := cast(^f64)&number

    fmt.println(number_f64_ptr^)

    
}
