package union_odin
import "core:fmt"

Value :: union {
    bool, i32, f32, string
}

Value2 :: union #no_nil {bool, string}

Error :: union #shared_nil {
    File_Error,
    Memory_Error,
}

File_Error :: enum {
    None = 0,
    File_Not_Found,
    Cannot_Open_File,
}

Memory_Error :: enum {
    None = 0,
    Allocation_Faild,
    Resize_Failed,
}

shared_nil_example :: proc() {
    an_error: Error
    an_error = File_Error.None

    assert(an_error == nil)
}


main :: proc() {
    v: Value
    v = "Hello"


    s1 := v.(string)
    s2, ok := v.(string)

    fmt.println(s2, ok)

    value: Value = i32(22323)

    switch x in value {
    case string:
        #assert(type_of(x) == string)
    case bool:
        #assert(type_of(x) == bool)
    case i32, f32:
        #assert(type_of(x) == Value)
    case:
    }

    y: Value2
    _, yes := y.(bool)
    assert(yes)

    shared_nil_example()
}
