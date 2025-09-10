package types

import "core:fmt"

Rect :: struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,
}


main :: proc() {
    rect := Rect{width = 20, height = 33}
    fmt.println(rect)
    rect = {
	x = 1,
	width = 3,
	height = 234,
    }
    fmt.println(rect)
    person := Person{{3, 4}, "Pedro"}
    fmt.println(person)
    person.age = 33
    fmt.println(person)

    p := Player {
	id = 7,
	position = {5, 2},
	can_jump = true,
    }
    print_position(p)

    my_interface := My_Interface {
	required_name_length = 5,
	is_valid_name = my_proc,
    }
    fmt.println(my_interface.is_valid_name(my_interface, "Bobby"))
}

Person_Stats :: struct {
    health: int,
    age: int,
}

Person :: struct {
    using stats: Person_Stats,
    name: string,
}

Entity :: struct {
    id: int,
    position: [2]f32,
}

Player :: struct {
    using entity: Entity,
    can_jump: bool,
}


print_position :: proc(e: Entity) {
    fmt.println(e.position)
}


My_Interface :: struct {
    required_name_length: int,
    is_valid_name: proc(My_Interface, string) -> bool,
}

my_proc :: proc(i: My_Interface, name: string) -> bool {
    return i.required_name_length == len(name)
}
