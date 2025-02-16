package main2


import "foo"
import "core:fmt"
import "core:strings"
import "base:builtin"
import "base:runtime"



Dog :: struct {
    name: cstring,
    age: i32
}

Cat :: struct {
    name: cstring,
    age: i32
}

main :: proc() {

    when builtin.ODIN_ENDIAN == .Little {
        fmt.println("Little endian")
    } else {
        fmt.println("Big endian")
    }
    fmt.println(builtin.ODIN_VENDOR, builtin.ODIN_VERSION)
    ti := type_info_of(Dog)
    fmt.println(ti)
    
    arr: [10]u32 = {0..=9 = 9}

    fmt.println(arr)

    fluffy1: Dog = {"Bobby", 11}

    fluffy2: Cat = cast(Cat)fluffy1

    f: ^Dog = &Dog{"Any", 3}
    fmt.println("Dog name:", f.name, "age:", f.age)

    fmt.println("Cat name:", fluffy2.name, "cats age:", fluffy2.age)

    a: int = 123
    aa: int = ---
    b: f32 = 333.8
    c: u64 = 999
    d := cstring("Hello")
    //g: string = "World"
    

    cc := transmute(i32)b
    cb := i32(b)
    cp := (^i32)(&b)^

    cd: i32 = auto_cast b


    foo.foo(a)
    foo.foo(aa)
    foo.foo(b)
    foo.foo(c)
    foo.foo(d)
    foo.foo(cc)
    foo.foo(cb)
    foo.foo(cp)
    foo.foo(cd)
    //foo.foo(g)

    //fmt.println(size_of(quaternion256))

    fmt.println("==========Strings============")
    strings_proc()
    fmt.println("==========Strings2============")
    string_proc2()
}

L :: 100
N :: 200
M :: 211


Foo :: struct {
    a: [L]u8 `fmt:"s"`,
    b: [N]u8 `fmt:"s, 0"`,
    c: [M]u8 `fmt:"q, n"`,
    n: int `fmt:"-"`,
}


strings_proc :: proc() {
    x := "ABCstring"
    y := cstring("ABCcstring")
    fmt.println(x)
    cc: cstring = cast(cstring)raw_data(x)

    for char, i in x {
        fmt.println(i, ":", char)
    }

    for index in 0..<len(x) {
        fmt.println(index, ":", rune(x[index]))
    }

    p := x[0]

    fmt.println(p)
    fmt.println()

    mp: [^]u8 = cast([^]u8)y
    mpp: [^]u8 = raw_data(x)

    c: ^u8 = &mp[0]
    fmt.println(c^)
    fmt.println(cast(cstring)mp)
    fmt.println(cast(cstring)mpp)
    fmt.println(cc)
}


string_proc2 :: proc() {
    x:cstring = "Hellope world!"
    y: []u8 = transmute([]u8)string(x)
    buf: [100]u8

    for c, i in y {
        fmt.printf("%c\n", c)
        buf[i] = y[i]
    }

    fmt.printf("%s\n", buf)

    s: string = string_from_ptr(cast(rawptr)x, 14)
    fmt.println(s)
    delete(s)
    s2: string = strings.string_from_ptr(cast(^u8)x, 14)
    fmt.println("Second string", s2)
}


string_from_ptr :: proc(p: rawptr, length: int) -> string {
    cp: [^]u8 = cast([^]u8)p
    sl: []u8 = make_slice([]u8, length)
    for i := 0; i < length; i += 1 {
        sl[i] = cp[i]
    }

    newstr: string = string(sl)
    return newstr
}

