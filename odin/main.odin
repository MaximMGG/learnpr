package main

import "core:fmt"
import "core:os"
import "core:c"


Foo :: union{int, bool}


main :: proc() {

    file, _:= os.open("main.zig", os.O_RDONLY)


    b := make_slice([]u8, 512)
    defer delete(b)

    bytes, _ := os.read(file, b)

    fmt.print("Read", bytes, "bytes")
    fmt.printf("%s\n", b)

    os.close(file)


    arr := [3]u8{2, 43, 11}

    for c, i in arr {
        fmt.println(i, "-", rune(c))
    }

    str: string = "some text"

    for c in str {
        assert(type_of(c) == rune)
        fmt.println(c)
    }


    for &i in arr {
        i = u8(123)
    }

    for i in arr {
        fmt.println(i)
    }

    arr2 := [dynamic]u32{3, 45, 5}
    defer delete(arr2)

    mm := map[string]int{"A" = 1, "C" = 2, "B" = 4}
    defer delete(mm)

    for k, &v in mm {
        if k == "C" {
            v = 3333
        }
    }

    for k, v in mm {
        fmt.println("Key -", k, "value -", v)
    }

    #reverse for i in arr2 {
        fmt.println(i)
    }

    if x := foo(); x == 77 {
        fmt.println("Yes")
    }


    switch arch := ODIN_ARCH; arch {
        case .i386, .wasm32, .arm32:
            fmt.println("32 bit")
        case .amd64, .wasm64p32, .arm64, .riscv64:
            fmt.println("64 bit")
        case .Unknown:
            fmt.println("Unknown architecture")
    }

    fmt.println(ODIN_ARCH)


    c: u8 = 'C'

    switch c {
    case 'A'..='Z', 'a'..='z', '0'..='9':
        fmt.println("c is slphanumberic")
    }

    f: Foo = true

    switch _ in f {
    case int: fmt.println("int")
    case bool: fmt.println("bool")
    }

    fmt.println(fibonacci(9))

    fmt.println("Sum:", sum(12, 434, 93, 1239, 0))
}

foo ::proc() -> int {
    return 77
}

fibonacci :: proc(n: int) -> int {
    switch {
    case n < 1:
        return 0
    case n == 1:
        return 1
    }
    return fibonacci(n - 1) + fibonacci(n - 2)
}

sum :: proc(nums: ..int) -> (res: int) {
    for n in nums {
        res += n
    }
    return
}
