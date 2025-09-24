package plymofr

import "base:intrinsics"
import "core:fmt"
import "core:math/rand"


my_clamp :: proc(val: $T, min: T, max: T) -> T where
intrinsics.type_is_numeric(T) {
    if val < min {
	return min
    }

    if val >= max {
	return max
    }

    return val
}

make_random_sized_slice :: proc($T: typeid) -> []T {
    random_size := rand.int_max(1024)
    return make([]T, random_size)
}


main :: proc() {
    number: int = 7

    fmt.println(my_clamp(number, 2, 7))

    s := make_random_sized_slice(f32)

    fmt.println(len(s))

    delete(s)
    
}
