package string_test

import "core:fmt"
import "core:mem"
import "core:os"
import "core:strings"
import vmem "core:mem/virtual"
//import "core:strconv"

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

    b := strings.builder_make()
    defer strings.builder_destroy(&b)
    strings.write_string(&b, "Super string")
    strings.write_string(&b, " ")
    strings.write_string(&b, "And what is this")
    strings.write_string(&b, " ")
    strings.write_string(&b, "End string")

    strings.write_string(&b, " ")

    res := strings.to_string(b)

    fmt.println(res)

    arena: vmem.Arena
    alloc_error := vmem.arena_init_growing(&arena)
    if alloc_error != nil {
        fmt.eprintln("Cant make arena:", alloc_error)
        os.exit(1)
    }
    allocator := vmem.arena_allocator(&arena)
    defer vmem.arena_destroy(&arena)

    s2 := strings.clone(res, allocator)
    fmt.printf("%s arean memery %p", s2, raw_data(s2))
}

A_CONSTANT :: "Hellope!"
