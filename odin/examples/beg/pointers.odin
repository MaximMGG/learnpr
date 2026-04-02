package basics
import "core:fmt"


pointres :: proc(cat: ^Cat) {
    fmt.println(cat)
    fmt.println(typeid_of(type_of(cat)))

    fmt.printfln("%p", cat)

    cat.age = 23

    fmt.println(cat)
}
