package basics

import "core:fmt"

if_statemets :: proc(n: int) {

    if true {
        fmt.println("True")
    }

    if n > 15 {
        fmt.printfln("Some number %d, is bigger then 15", n)
    }

    cond := n > 500

    if cond {
        fmt.println("Cond is true")
    } else {
        fmt.println("Cond is false")
    }

}
