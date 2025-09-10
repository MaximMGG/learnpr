package basics

import "core:fmt"


is_bigger_then :: proc(number: int, compare_to: int) -> bool {
    return number > compare_to
}

main :: proc() {
    fmt.println(is_bigger_then(123, 2))

    res := is_bigger_then(2, 4)
    if res {
	fmt.println("Bigger")
    } else {
	fmt.println("Not bigger")
    }

    i: int
    for { // infinite loop
	fmt.println("Any")

	i += 1
	if i == 10 do break
    }

    for i := 0; i < 5; i += 1 {
	fmt.println(i)
    }

    for i in 0..<10 {
	fmt.println("for i in 0..<10", i)
    }

    out: for i in 0..<10 {
	for j in 0..<20 {
	    if i == 2 && j == 3 {
		fmt.println("Break out")
		break out
	    }
	}
    }

    ten_ints: [10]int = [10]int{3, 4, 5, 1, 4, 2, 1, 0, 2, 9}
    //ten_ints := [10]int{3, 4, 5, 1, 4, 2, 1, 0, 2, 9} can use like that
    
    for i in ten_ints {
	fmt.println(i)
    }

    #reverse for i in ten_ints {
	fmt.println(i)
    }
    test_proc()
}

test_proc :: proc() {
    numbers := [10]int {
	8, 1, -4, 123, 4, 8, 11, 0, 43, 8
    }

    cmp := 6

    for n in numbers {
	if is_bigger_then(n, cmp) {
	    fmt.printfln("%v is bigger than %v", n, cmp)
	}
    }
}
