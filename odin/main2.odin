package main2


import "foo"
import "core:fmt"
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
    


    fluffy1: Dog = {"Bobby", 11}

    fluffy2: Cat = cast(Cat)fluffy1


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

}
