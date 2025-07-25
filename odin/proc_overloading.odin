package proc_over


import "core:fmt"
import "core:strings"


bool_to_string :: proc(b: bool) -> (s: string = "Bool") {
    return
}

int_to_string :: proc(b: int) -> (s: string = "Int") {
    return
}

to_string :: proc{bool_to_string, int_to_string}


main :: proc() {
    fmt.println("To string bool", to_string(true))
    fmt.println("To string int", to_string(1223))

    s_arr := [?]string{"My ", "name", " is ", "Maxim"}
    s := strings.concatenate(s_arr[:])
    defer delete(s)

    fmt.println(s)

}
