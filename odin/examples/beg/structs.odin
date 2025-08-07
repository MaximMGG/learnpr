package basics

import "core:fmt"

Cat :: struct {
    name: string,
    age: int,
}


structs :: proc() -> Cat {
    cat1: Cat
    fmt.println(cat1)

    cat1.name = "Pontious1"
    cat1.age = 4
    fmt.println(cat1)
    fmt.println(typeid_of(type_of(cat1)))

    cat2 := Cat{
        name = "Bobby",
        age = 7,
    }

    fmt.println(cat2)

    cat1 = {name = "ijij", age = 2}
    fmt.println(cat1)

    return {
        name = "dkjf",
        age = 12,
    }
}
