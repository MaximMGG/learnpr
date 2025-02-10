package statement 

import "core:fmt"
import "core:os"


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

    fmt.println("size of int -> ", size_of(int))
    fmt.println("size of u32 -> ", size_of(u32))


    //one()
    fmt.println("Procedure fibonacci")
    fmt.println(fibonace(77777))
}


one :: proc() {
    f, err := os.open("main.odin", os.O_RDONLY);

    if err != os.ERROR_NONE {
        fmt.println("file not exists")
    }
    defer os.close(f)

    byte: [512]u8
    bytes, err2 := os.read(f, byte[:])
    a: string = string(byte[:])
    
    fmt.println(a)
    fmt.println("Bytes read from file :", bytes)
    fmt.println("Error is :", err2)

    os.close(f)
}


fibonace :: proc(i: u32) -> u32 {
    if (i == 0) {return 0}
    if (i == 1) {return 1}

    return i + fibonace(i - 1)
}


