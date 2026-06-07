package hellope

import "core:fmt"
import "core:os"

BIG_NUMER :: int(4)
BIG_FLOAT : f32 : 3.4

Ood_struct :: struct {
    name: string
}


Basic_String :: struct {
    using ood: Ood_struct,
    a, b, c: i32,
}

basic_foo :: proc(n: int = 1, c: int = 8) -> bool {
    return n > c
}

main :: proc() {
    o := Basic_String{name = "Hello", a = 3, b = 1, c = 8}
    fmt.println("Hellope")
    b := i32(2)
    c: u32 = cast(u32)b
    fmt.println(c)
    fmt.println(&c)

    buf: [256]u8

    f, f_err := os.open("ols.json")
    if f_err != nil {
	fmt.eprintln("Error while open file: ", "ols.json")
    }

    bytes_read, read_err := os.read(f, buf[:])
    if read_err != nil {
	fmt.eprintln("Error while read file:", read_err)
    }

    fmt.printfln("Read %d bytes, and have content\n%s", bytes_read, transmute(string)buf[:bytes_read])
        
}
