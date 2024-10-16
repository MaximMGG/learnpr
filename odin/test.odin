package main


import "core:fmt"


getNum :: proc (x: u32) -> u32 {
    if x % 2 == 0 {
        return x + 1
    } else {
        return x + 0
    }

}


main :: proc () {
    x: u32 = 0

    for ;x < 3333333 ; x += 1 {
        x = getNum(x)
        fmt.printf("%d\n", x)
    }

}
