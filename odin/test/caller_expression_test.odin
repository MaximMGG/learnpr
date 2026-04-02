package caller_expression_test


import "core:fmt"

one :: proc() {
    fmt.println("One")
}

two :: proc() {
    fmt.println("Two")
}

call :: proc() {
    one()
    two()
}

super_proc :: proc(a: int, b: int) {
    fmt.println("Super proc", a, b)
}

main :: proc() {
    call(super_proc(1, 22))
}
