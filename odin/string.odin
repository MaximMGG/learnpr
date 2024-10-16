package main2

import "core:fmt"
import "core:strings"

L :: 200
N :: 300
M :: 400



Foo :: struct {
    a: [L]u8 `fmt:"s"`, // whole buffer is a string
    b: [N]u8 `fmt:"s,0"`, // 0 terminated string
    c: [M]u8 `fmt:"q,n"`, // string with length determinated by n, and use %q
                          // rather than %s
    n: int `fmt:"-"`, // ignore this from formatting
}


main :: proc() {
    x := "ABC"
    y := string(x)
    for codepoint, index in x {
        fmt.println(index, codepoint)
    }

    fmt.println(typeid_of(type_of(x)))
    fmt.println(typeid_of(type_of(y)))
    for index in 0..<len(x) {
        fmt.println(index, x[index])
    }

    str: string = "Hellope"
    cstr: cstring = "Hellope"

    cstr2 := string(cstr)
    nstr := len(str)
    ncstr := len(cstr)

    xstr: string = "Bye"
    fmt.println(typeid_of(type_of(raw_data(str))))

    ustr: []u8 = {'a', 'b', 'c'}
    fmt.println(ustr)

    stru := string(ustr)
    fmt.println(stru)
    transstr := transmute(string)ustr
    fmt.println(transstr)



}
