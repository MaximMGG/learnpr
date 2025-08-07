package basics

import "core:fmt"

variables :: proc() {

    number: int
    fmt.println(number)
    number = 7
    fmt.println(number)
    fmt.println(typeid_of(type_of(number)))

    number2 := 123
    fmt.println(number2)
    fmt.println(typeid_of(type_of(number2)))

    f := 123.3
    fmt.printf("%.2f\n", f)
    fmt.println(typeid_of(type_of(f)))

    f2 := f32(123.4)

    fmt.printf("%.1f\n", f2)
    fmt.println(typeid_of(type_of(f2)))

}
