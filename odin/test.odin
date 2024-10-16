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
    y := make([dynamic]int, 0, 3333333)
    defer delete(y)

 #no_bounds_check {
    // for i in 0..<3333333 {
    //     assign_at(&y, i, i)
    // }
    //

     for i in 0..<3333333 {
         y[i] = i
     }

     for i in 0..<3333333 {
         fmt.println(y[i])
     }

    // for num in y {
    //     fmt.println(num)
    // }
}

}
