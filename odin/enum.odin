package enum_odin


import "core:fmt"

Direction :: enum {North, East, West, South}
Foo :: enum {
    A,
    B = 4,
    C = 7,
    D = 1337,
}

Direction_vector :: [Direction][2]int{
    .North = {0, -1},
    .East = {+1, 0},
    .West = {0, +1},
    .South = {-1, 0},
}

main :: proc() {

    assert(Direction_vector[.North] == {0, -1})
    assert(Direction_vector[.East] == {+1, 0})
    assert(Direction_vector[.West] == {0, +1})
    assert(Direction_vector[.South] == {-1, 0})

    x := int(Foo.C)
    fmt.println(x)

    y: Foo
    y = .D
    switch y {
    case .A:
        fmt.println("foo")
    case .B:
        fmt.println("buz")
    case .C:
        fmt.println("aaa")
    case .D:
        fmt.println("DDD")
    }
    if int(Direction.North) == 0 {
        fmt.println("North")
    } 
    if int(Direction.East) == 1 {
        fmt.println("East")
    }
    if int(Direction.West) == 2 {
        fmt.println("West")
    } 
    if int(Direction.South) == 3 {
        fmt.println("South")
    }

    using Foo

    z := D
    fmt.println(z)

    for direction, index in Direction {
        fmt.println(index, direction)
    }

    #partial switch z {
    case .D:
        fmt.println("Yes")
    }


    enum_arr: [enum {Z, X, V}]int
    enum_arr = #partial {
        .Z = 44,
    }

    fmt.println(enum_arr)

}


