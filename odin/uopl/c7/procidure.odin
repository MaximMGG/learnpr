package procidure

import "core:fmt"
import "core:bytes"


write_message :: proc(message: string, label: string = "Info") {
    if label != "" {
	fmt.print(label)
	fmt.print(": ")
    }

    fmt.println(message)
}

my_proc :: proc(a: int, b := 1, c := "Hello") {
    fmt.println(a, b, c)
}

clone :: proc(s: []byte, allocator := context.allocator, loc := #caller_location) -> []byte {
    c := make([]byte, len(s), allocator, loc)
    copy(c, s)
    return c[:len(s)]
}

main :: proc() {
    write_message("Message")
    my_proc(7, c = "IJIJIJ")

    b := [5]byte{1, 2, 3, 4, 5}
    new_b := clone(b[:])
    fmt.println(new_b)
    delete(new_b)

    bb := bytes.clone(b[:])
    fmt.println(bb)
    delete(bb)
}
