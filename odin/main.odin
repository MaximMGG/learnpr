package one

import "core:fmt"
import "core:os"
import "core:mem"
import "core:c"
import "base:runtime"

// foreign import stdlib {
//     "clib",
// }
//
// foreign stdlib {
//     malloc :: proc(size: c.size_t) ---
// }


main :: proc() {
    x : int = 3
    y := 23

    fmt.println(size_of(y))

    for i in os.args {
        fmt.println(i)
    }

    a := "Hello world!"
    defer delete(a)

    fmt.print("[")
    for c in a {
        fmt.printf("%c, ", c)
    }
    fmt.print("]\n")

    arr := [3]int{3, 4, 8}

    for i in arr {
        fmt.printf("%d\n", i)
    }

    fmt.println("The cap of arr", cap(arr), "", sep = "")


    dyn_arr := [dynamic]int{1, 4, 4}
    for i in dyn_arr {
        fmt.println(i)
    }

    arr2 := make([dynamic]int, 0, 3)

    //defer free(cast(rawptr)&dyn_arr)
    defer delete(dyn_arr)
    defer mem.delete(arr2)

    some_map := map[string]int{"A"=33, "B"=55, "C"=123}
    for key in some_map {
        fmt.println(key, some_map[key])
    }
    defer delete(some_map)

    for c, i in a {
        fmt.printf("%d - %c, ", i, c)
    }
    

    fmt.println()

    for k, v in some_map {
        fmt.printf("%s - %d\n", k, v)
    }

    fmt.println("Experiment with array -- begin")

    arr3 := [5]i32{3, 5, 8, 2, 1}

    for &v in arr3 {
        if v == 8 {
            v = 0
        }
    }

    for v in arr3 {
        fmt.println(v)
    }

    fmt.println("Experiment with array -- end")
    fmt.println("Experiment with map -- begin")

    some_map2 := map[int]string{5 = "My ", 4 = "dog ", 3 = "ate ", 2 =
        "bananas ", 1 = "in ", 0 = "garden!"}

    for k, v in some_map2 {
        fmt.println(k, " - ", v, sep ="")
    }

    for k, &v in some_map2 {
        if v == "dog " {
            v = "cat "
        }
    }
    for k, v in some_map2 {
        fmt.println(k, " - ", v, sep ="")
    }
    delete(some_map2)
    fmt.println("Experiment with map -- end")


    arr4 := [?]int{1, 2, 3, 4, 5, 6, 7}

    #reverse for i in arr4 {
        fmt.println(i)
    }


}
