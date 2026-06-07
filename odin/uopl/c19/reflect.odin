package reflect_test

import "core:fmt"
import "core:reflect"


Cat_Color :: enum {
    None,
    Tabby,
    Orange,
    Calico,
}

Null :: struct {

}

Integer :: struct {

}

Float :: struct {

}

Boolean :: struct {

}


Value :: union {
    Null,
    Integer,
    Float,
    Boolean
}


main :: proc() {
    color_name := "Orange"
    if color, ok := reflect.enum_from_name(Cat_Color, color_name); ok {
        fmt.println(color)
    }

    o := Value(Null{})

    if v, ok := o.(Integer); ok {
        fmt.println("All is ok")
    }

    k := reflect.as_bytes(&o)

    fmt.println(k)
    switch t in o {
    case Null:
        fmt.println("It is null")
    case Integer:
        fmt.println("It is int")
    case Float:
        fmt.println("It is float")
    case Boolean:
        fmt.println("It is bool")
    }

}
