package statement 

import "core:fmt"


Foo :: enum {
    ONE, TWO, TREE
}


Foo2 :: union {
    int, bool, f64, i64, i128
}


main :: proc() {
    
    i := 1

    switch i {
        case 0:
        case 1:
            fmt.println(i)
            fallthrough
        case 3..<5:
            fmt.println(i, "in 3..<5")
        case :
            fmt.println("HZ")
    }

    f := Foo.TREE

    #partial switch f {
        case .ONE: fmt.println("ONE")
    }

    f2: Foo2 = i64(999)

    //f2 = 34.8
    fmt.println(f2)
    fmt.println(size_of(f2))

    #partial switch _ in f2 {
        case int: fmt.println("int")
        case bool: fmt.println("bool")
        case f64: fmt.println("f64")
    }


}
