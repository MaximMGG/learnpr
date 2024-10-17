package bit_set_odin


import "core:fmt"


Direction :: enum{North, East, South, West}
Direction_Set :: bit_set[Direction]

Char_Set :: bit_set['A'..='Z']
Char_Set2 :: bit_set['A'..='Z'; u64]
Number_Set :: bit_set[0..<10]

main :: proc() {
 #assert(size_of(Char_Set2) == size_of(u64))
}
