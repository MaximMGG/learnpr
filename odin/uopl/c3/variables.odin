package variables

import "core:fmt"

main :: proc() {
    number: int = ---
    fmt.println(number)

    number2 := 2
    fmt.println(number2)

    number3: int = 123
    fmt.println(number3)

    dec_num: f32 = 1.3
    fmt.println("float f32", dec_num)

    dec_num2 := f32(number3)
    fmt.println("float from int", dec_num2)

    dec_num3: f32 = f32(number3)
    fmt.println("float from int", dec_num3)

    CONSTANT_NUMBER :: 12

    number4 := CONSTANT_NUMBER
    fmt.println(number4)

    DECIMAL_CONSTANT: f32 : 9834.3
    fmt.printf("%.1f", DECIMAL_CONSTANT)
}
