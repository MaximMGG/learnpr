package main


import "core:fmt"

Monitor :: struct {}

Window :: struct {}


main :: proc() {
    foo(2)

    fmt.println(sum())
    fmt.println(sum(1, 2))
    fmt.println(sum(1, 2, 3, 4, 5))

    odds := []int{1, 3, 5}
    fmt.println(sum(..odds))

    fmt.println(swap(111, 333))

    fmt.printf("%d - %d\n", do_math(7))
    fmt.printf("%d - %d\n", do_math_with_naked_return(7))

    foonc(11, name="Non", x=true, y=3.1)

    a: Monitor

    //create_window(title="Titl", width=100, height=300, monitor=&a)


}


foo :: proc(x: int) {
    x := x
    for x > 0 {
        fmt.println("x")
        x -= 1
    }
}

sum :: proc(nums: ..int) -> (result: int) {
    result = 0
    for n in nums {
        result += n
    }
    return
}

swap :: proc(x, y: int) -> (int, int) {
    return y, x
}

do_math :: proc(input: int) -> (x, y: int) {
    x = 2 * input + 1
    y = 3 * input / 5
    return x, y
}

do_math_with_naked_return :: proc(input: int) -> (x, y: int) {
    x = 2 * input + 1
    y = 3 * input / 5
    return
}


foonc :: proc(value: int, name: string, x: bool, y: f32, z := 0) {

}


create_window :: proc(title: string, x := 0, y := 0, width := 854, height :=
    480, monitor: ^Monitor = nil) -> (^Window) {//Window_error){

    return nil
}


