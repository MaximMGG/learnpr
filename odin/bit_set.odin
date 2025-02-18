package bit_set_odin

import "core:fmt"

Direction :: enum{North, West, South, East}

Direction_set :: bit_set[Direction]

Char_set :: bit_set['A'..='Z']
Char_set_size :: bit_set['A'..='Z'; u64]
Number_set :: bit_set[0..<10]

main :: proc() {
    cs := Char_set{'A', 'B'}
    fmt.println(cs)
    fmt.println("Char_set_size:", size_of(Char_set_size), ", u64 size:",
        size_of(u64))
    ns := Number_set{7, 1, 8, 2}
    fmt.println(ns)
    fmt.println("ns size:", size_of(ns))

    ds := Direction_set{.North, .West}
    fmt.println(ds)

    for n in ns {
        fmt.println("size of n:", size_of(n), n)
    }

}
