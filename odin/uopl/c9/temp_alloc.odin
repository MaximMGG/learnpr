package temp_alloc

import "core:fmt"
import "core:math/rand"
import "core:slice"


main :: proc() {
    arr := make([dynamic]int, context.temp_allocator)

    for i in 0..<1000 {
	append(&arr, rand.int_max(1000))
    }

    slice.sort(arr[:])
    fmt.println(arr[999])

    free_all(context.temp_allocator)
}
