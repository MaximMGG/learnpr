package test_test

import "core:testing"
import "core:reflect"
import "base:runtime"

foo :: proc(a: int, b: int) -> int {
    return a + b
}

foo2 :: proc() -> ^int {
    a := new(int)

    return a
}

@(test) 
test_foo :: proc(t: ^testing.T) {
    testing.expect_value(t, 44, foo(40, 4))
    a := foo2()

    ti := runtime.type_info_base(type_info_of(type_of(a)))
    if ty, ok := ti.variant.(runtime.Type_Info_Pointer); ok {
        testing.expect(t, true)
    } else {
        testing.expect(t, false, "a should be pointer")
    }
    free(a)
}
