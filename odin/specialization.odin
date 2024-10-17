package specialization

import "core:fmt"
import "core:mem"
import "base:intrinsics"


make_slice :: proc($T: typeid/[]$E, len: int) -> T {
    return make(T, len)
}

Table_Slot :: struct($Key, $Value: typeid) {
    occupied:   bool,
    hash:       u32,
    key:        Key,
    value:      Value
}

Table :: struct($Key, $Value: typeid) {
    count:      int,
    allocator:  mem.Allocator,
    slots:      []Table_Slot(Key, Value)
}

allocate :: proc(table: ^$T/Table, capacite: int) {

}

find :: proc(talbe: ^Table($Key, $Value), key: Key) -> (Value, bool) {

}

cross_2d :: proc(a, b: $T/[2]$E) -> E 
    where intrinsics.type_is_numeric(E) {
        return a.x * b.y - a.y * b.x
}

cross_3d :: proc(a, b: $T/[3]$E) -> T 
        where intrinsics.type_is_numeric(E) {
        x := a.y*b.z - a.z*b.y
        y := a.z*b.x - a.x*b.z
        z := a.x*b.y - a.y*b.x
        return T{x, y, z}
}


main :: proc() {
    a := [2]int{1, 2}
    b := [2]int{5, -3}
    fmt.println(cross_2d(a, b))

    x := [3]f32{1, 4, 9}
    y := [3]f32{-5, 0, 3}
    fmt.println(cross_3d(x, y))
}



