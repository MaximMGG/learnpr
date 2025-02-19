package structs 


import "core:fmt"

Vector3 :: struct {
    x, y, z: f32,
    g: int "information"

}

Foo :: struct {
    x, y, z: int,

    var_1: struct {
        x, y, z:int,
    },
    var_2: struct {
        x, y, z:int
    },

    _: struct {
        x, y, z: f64
    },

}

Value :: union {
    bool,
    i32,
    f32,
    string,
}


Value2 :: union #no_nil {
    int,
    f32,
    string
}


main :: proc() {

    v: Vector3 = {x=7.1, y=3.7, z=1.1, g=1}

    v2 := Vector3{1.1, 2.2, 3.3, 0}
    fmt.println(v)
    fmt.println(v2)

    f: Foo = {}

    fmt.println(f)

    f.var_1.z = 9999

    fmt.println(f)


    val: Value
    val = "Hello"

    s1, ok := val.(i32)
    if ok {
        fmt.println("String")
    } else {
        fmt.println("Not string")
    }
    fmt.println(s1)


    switch t in val {
        case string:
            #assert(type_of(t) == string)
            fmt.println("Val is string")
        case f32, i32:
            #assert(type_of(t) == Value)
            fmt.println("Val is f32 or i32")
        case bool:
            #assert(type_of(t) == bool)
            fmt.println("Val is bool")
        case:
    }
    o: Value2

    _, ok_o := o.(int)

    assert(ok_o)

    shared_nil_example()

}

Error :: union #shared_nil {
    File_Error,
    Memory_Error,
}
File_Error :: enum {
    None = 0,
    File_Not_Foune,
    Cannot_Open_file,
}

Memory_Error :: enum {
    None = 0,
    Allocation_faild,
    Resize_failed,
}

shared_nil_example :: proc() {
    an_error: Error
    an_error = File_Error.None

    assert(an_error == nil)
}



