package perf_int_test

import "core:fmt"

main :: proc() {
    fmt.println("Begin")

    k:i32 = 1
    val: u64 = 3
    count := 1_000_000
    m: map[i32]u64

    for count != 0 {
	m[k] = val
	k += 1
	val += 123
	count -= 1
    }

    total_sum: u64
    for k, v in m {
	total_sum += v
    }
    fmt.println("Total sum: ", total_sum)
}
