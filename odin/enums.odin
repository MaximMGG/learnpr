package enums

import "core:fmt"

Foo :: enum u8 {A, B, C}

Directions :: enum{North, East, West, South}
Direction_Array :: [Directions][2]int {
    .North = {0, -1},
    .East = {1, 0},
    .South = {0 , 1},
    .West = {-1, 0},
}

main :: proc() {
    using Foo
    a := A

    fmt.println(a)
    fmt.println(size_of(a))

    switch a {
        case .A :
            fmt.println("AAA")
        case .B:
            fmt.println("BBB")
        case .C:
            fmt.println("CCC")
    }

    for direction, index in Directions {
        fmt.println(index, "-", direction)
    }

    assert(Direction_Array[.North] == {0, -1})
    fmt.println(Direction_Array[.North])
    fmt.println(Direction_Array[.East])
    fmt.println(Direction_Array[.West])
    fmt.println(Direction_Array[.South])

    for d in Direction_Array {
        fmt.println(d)
    }

    f: [2]int = Direction_Array[.East]
    fmt.println("f: [2]int =", f)

    arr: [enum {E, R, T}]i32
    arr = #partial {
        .R = 333,
        .T = 1394982,
    }

    fmt.println(arr)

    arr2 : [enum {TT, RR, YY}]i32 = #partial {.RR = 99, .YY = 123}
    fmt.println(arr2)
    fmt.println(arr2[.RR])
    arr2[.RR] = 777
    fmt.println(arr2)


}


