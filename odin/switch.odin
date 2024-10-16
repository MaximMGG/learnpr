package main


import "core:fmt"


Foo :: enum {
    A, B, C, D,
}

Foou :: union {int, bool}


main :: proc () { 
    switch arch := ODIN_ARCH; arch {
        case .i386, .wasm32, .arm32:
            fmt.println("32 bit")
        case .amd64, .wasm64p32, .arm64, .riscv64:
            fmt.println("64 bit")
        case .Unknown:
            fmt.println("Unknown architecture")
    }

    str := "Hello213,.kjf8!"
    for c in str {
        switch c {
        case 'A'..='Z', 'a'..='z', '0'..='9':
            fmt.println("c is alphanumberic")
        }
    }

    x := 23 

    switch x {
    case 0..<10:
        fmt.println("units")
    case 10..<13:
        fmt.println("pre-teens")
    case 13..<20:
        fmt.println("teens")
    case 20..<30:
        fmt.println("twenties")
    }


    f := Foo.C

    switch f {
    case .A: fmt.println("A")
    case .B: fmt.println("B")
    case .C: {
        fmt.println("C") 
        fallthrough
    }
    case .D: fmt.println("D - fallthrough")
    case: fmt.println("?")
    }


    #partial switch f {
    case .A: fmt.println("A")
    case .D: fmt.println("D")
    }

    b: Foou = 123

    switch _ in b {
    case int: fmt.println("int")
    case bool: fmt.println("bool")
    case:
    }

    #partial switch _ in b {
    case bool: fmt.println("bool")
    }

    switch _ in b {
    case int: {
        fmt.println("int - fallthrough")
    }
    case bool: {
        fmt.println("bool - fallthrough")

    }

    }



}

