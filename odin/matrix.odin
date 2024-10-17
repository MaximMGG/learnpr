package matrix_odin

import "core:fmt"
import "core:math/linalg"

main :: proc() {
    m: matrix[2, 3]f32

    m = matrix[2, 3]f32 {
        1, 9, -13,
        20, 11, 99
    }
    fmt.println(m)

    b := matrix[2, 3]f32 {
        9, 2, 8,
        23, 11, 7
    }
    fmt.println(b)
    fmt.println(b - m)

    c := matrix[2, 2]f32{}
    f := f32(3)
    c = f
    fmt.println("c", c)
    fmt.println("c == f", c == f)
    fmt.println("------------->")
    matrix_mult()
    fmt.println("------------->")
    matrix_mult_arr()
    fmt.println("------------->")
    comp_wise_operation()
    fmt.println("-------------> submatrix_casting")
    submatrix_casting()
    fmt.println("-------------> castring_non_square_matrix")
    castring_non_square_matrix()
}

matrix_mult :: proc() {
    a := matrix[2, 3]f32 {
        2, 3, 1,
        4, 5, 0
    }
    b := matrix[3, 2]f32 {
        1, 2,
        3, 4,
        5, 6
    }

    fmt.println("a", a)
    fmt.println("b", b)
    c := a * b
    #assert(type_of(c) == matrix[2, 2]f32)
    fmt.println("c = a * b", c)
}

matrix_mult_arr :: proc() {
    m := matrix[4, 4]f32 {
        1, 2, 3, 4,
        5, 5, 4, 2,
        0, 1, 3, 0,
        0, 1, 4, 1
    }

    v := [4]f32{1, 5, 4, 3}

    fmt.println("m * v", m * v)
    fmt.println("v * m", v * m)

    s := matrix[2, 4]f32 {
        2, 4, 3, 1,
        7, 8, 6, 5
    }

    w := [2]f32{1, 2}
    r: [4]f32 = w * s
    fmt.println("r", r)
}

comp_wise_operation :: proc() { 
    a := matrix[2, 2]i32 {
        1, 2,
        3, 4
    }
    b := matrix[2, 2]i32 {
        -5,  1,
         9, -7
    }

    fmt.println("a = ", a)
    fmt.println("b = ", b)

    c0 := a + b
    c1 := a - b
    c2 := a & b
    c3 := a | b
    c4 := a ~ b
    c5 := a &~ b

    c6 := linalg.hadamard_product(a, b)

    fmt.println("a + b", c0)
    fmt.println("a - b", c1)
    fmt.println("a ^ b", c2)
    fmt.println("a | b", c3)
    fmt.println("a ~ b", c4)
    fmt.println("a &~ b", c5)
    fmt.println("hadamard_product(a, b)", c6)

}

submatrix_casting :: proc() {
    mat2 :: distinct matrix[2, 2]f32
    mat4 :: distinct matrix[4, 4]f32

    m2 := mat2{
        1, 3,
        2, 4,
    }
    m4 := mat4(m2)
    assert(m4[2, 2] == 1)
    assert(m4[3, 3] == 1)
    fmt.printf("m2 %#v\n", m2)
    fmt.println("m4", m4)
    fmt.println("mat2(m4)", mat2(m4))
    assert(mat2(m4) == m2)

    b4 := mat4{
        1, 2, 0, 0,
        3, 4, 0, 0,
        5, 0, 6, 0,
        0, 7, 0, 8
    }
    fmt.println("b4", linalg.matrix_flatten(b4))


}

castring_non_square_matrix :: proc() {
    mat2x4 :: distinct matrix[2, 4]f32
    mat4x2 :: distinct matrix[4, 2]f32

    x := mat2x4{
        1, 3, 5, 7,
        2, 4, 6, 8
    }
    y := mat4x2(x)
    fmt.println("x", x)
    fmt.println("y", y)
}
