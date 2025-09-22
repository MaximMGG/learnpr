package string_test

import "core:fmt"
import "core:mem"
import "core:strings"

main :: proc() {
    c := cstring("Hello world!")
    buf: [24]byte
    fmt.println(c, "c len:", len(c))

    s := string(c)

    fmt.println(s, "s len:", len(s))

    mem.copy(&buf, raw_data(s), len(s))

    fmt.println(string(buf[:len(s)]))

    c2: cstring = strings.clone_to_cstring(s)
    defer delete(c2)

    fmt.println(c2)

    my_string := A_CONSTANT + " How are you?"
    fmt.println(my_string)

    a: [24]int = {0..<24 = 4}
    fmt.println(a)

    index := strings.index_byte(s, 'w')
    fmt.printfln("Index of w in string: %s is %d", s, index)

    world := s[index:]
    fmt.println(world)
    
}

A_CONSTANT :: "Hellope!"
