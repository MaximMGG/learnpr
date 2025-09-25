package test

import "core:fmt"

test_proc :: proc() {
    fmt.println("From test proc 1")
}


test_str_proc :: proc(s: string) -> int{
    return len(s)
}
