package advanced_type


import "core:fmt"

My_int :: int
My_int2 :: distinct int
Foo :: struct {}

main :: proc() {
 #assert(My_int == int)
 #assert(My_int2 != int)
 #assert(Foo != struct{})
}
