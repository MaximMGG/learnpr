package basics

import "core:fmt"

main :: proc() {

    fmt.println("Hello Odin world!")

    variables()

    res := loops(21)


    if_statemets(res)

    cat := structs()
    fmt.println(cat)

    fmt.println("Pointers")
    pointres(&cat)

}
