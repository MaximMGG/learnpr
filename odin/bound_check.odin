package bound_check

import "core:fmt"


main :: proc() {
    arr := [100000]int{}
    num := 0

 #no_bounds_check {
    for i in 0..<100000 {
        arr[i] = num
        num += 1
    }

    for i in arr {
        fmt.println(i)
    }
}
}
