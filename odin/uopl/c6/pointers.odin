package pointers

import "core:fmt"

inc :: proc(num: ^int) {
    num^ += 1
}

main :: proc() {
    num: int = 7
    fmt.println(num)
    inc(&num)
    fmt.println(num)
    fmt.println(typeid_of(type_of(num)))
    nump: ^int = &num
    fmt.println(typeid_of(type_of(nump)))
    fmt.printfln("poiner %i, value %d", nump, num)

    my_cat := Cat {
	name = "Bobby",
	age = 7,
	color = .Calico,
    }

    process_cat_birthday(&my_cat)
    fmt.println(my_cat)
    replace_cat(&my_cat)
    fmt.println(my_cat)

    number := 7
    pointer1 := &number
    pointer2 := pointer1
    pointer2^ = 10
    fmt.println(number)
    fmt.println(pointer1)
    fmt.println(pointer2)
    fmt.println(&pointer1)
    fmt.println(&pointer2)

    array: [10]int
    element_pointer := &array[2]
    element_pointer^ = 3
    fmt.println(array)
}

replace_cat :: proc(cat: ^Cat) {
    if cat == nil {
	return
    }

    cat^ = {
	name = "Kitty",
	age = 2,
	color = .Orange,
    }
}

process_cat_birthday :: proc(cat: ^Cat) {
    if cat == nil {
	return
    }
    cat.age += 1
}

Cat :: struct {
    name: string,
    age: int,
    color: Cat_Color,
}

Cat_Color :: enum {
    Black,
    White,
    Orange,
    Tabby,
    Calico,
}
