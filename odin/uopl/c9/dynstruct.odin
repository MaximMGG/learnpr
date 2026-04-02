package dynstruct

import "core:fmt"
import "core:slice"


Cat :: struct {
    age: int,
    name: string,
}

make_cat :: proc(name: string, age: int) -> ^Cat {
    cat := new(Cat)
    cat^ = {
	name = name,
	age = age,
    }
    return cat
}

cat_simulation :: proc() {
    cat := make_cat("Fluffe", 12)

    free(cat)
}

main :: proc() {
    //cat_simulation()
    dyn_arr: [dynamic]int
    defer delete(dyn_arr)
    append(&dyn_arr, 5)
    //    dyn_arr2 := dyn_arr
    dyn_arr2 := slice.clone_to_dynamic(dyn_arr[:])
    delete(dyn_arr2)
    fmt.printfln("dyn_arr: %p", dyn_arr)
    fmt.printfln("dyn_arr2: %p", dyn_arr2)
    
    a: [5]int = {1, 2, 3, 4, 5}
    b := a

    fmt.println("a:", a)
    fmt.println("b:", b)

    fmt.printfln("a: %p", &a)
    fmt.printfln("b: %p", &b)


    no_dyn_arr := slice.clone(dyn_arr[:])

    fmt.println(no_dyn_arr)

    dyn_arr4 := new([dynamic]int)

    append(dyn_arr4, 99)

    fmt.println(dyn_arr4^)
    free(dyn_arr4)
}
