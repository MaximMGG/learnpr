package procidure

import "core:fmt"
import "core:bytes"
import "core:math"


write_message :: proc(message: string, label: string = "Info") {
    if label != "" {
	fmt.print(label)
	fmt.print(": ")
    }

    fmt.println(message)
}

my_proc :: proc(a: int, b := 1, c := "Hello") {
    fmt.println(a, b, c)
}

clone :: proc(s: []byte, allocator := context.allocator, loc := #caller_location) -> []byte {
    c := make([]byte, len(s), allocator, loc)
    copy(c, s)
    return c[:len(s)]
}

main :: proc() {
    defer fmt.println("In the begging of main")
    write_message("Message")
    my_proc(7, c = "IJIJIJ")

    b := [5]byte{1, 2, 3, 4, 5}
    new_b := clone(b[:])
    fmt.println(new_b)
    delete(new_b)

    bb := bytes.clone(b[:])
    fmt.println(bb)
    delete(bb)

    res, ok := divide_and_double(2, 4)
    if ok {
	fmt.println("Res of div: ", res)
    }
    res, ok = divide_and_double(4,1)
    if ok {
	fmt.println("Res2 is", res)
    }

    if res2, ok2 := divide_and_double(4, 9); ok2 {
	fmt.println("res2 of div2:", res2)
    }

    do_stuff()

    hans := Person {
	name = "Hans",
	age = 44,
	number_of_teeth = 6,
	health = 20,
	height_meters = 1.44,
    }
    fmt.printf("hans pointer: %p\n", &hans)
    fmt.printfln("hans.name pointer: %p", &hans.name)
    print_person_info(hans)

    couple_data := Couple_Data {
	person_1 = {
	    name = "Hans",
	    age = 65,
	},
	person_2 = {
	    name = "Msr Bin",
	    age = 40,
	},
    }

    aliasing_example(&couple_data, couple_data.person_1)

    fmt.println("Len of [2]f32", length([2]f32{3.1,4.3}))
    fmt.println("Len of [3]f32", length([3]f32{1.3, 4.5, 9.9}))

    
}

aliasing_example :: proc(cd: ^Couple_Data, person: Person) {
    cd.person_1 = {
	name = "This modifies 'person' too",
    }

    fmt.println(person.name)
}

print_person_info :: proc(p: Person) {
    fmt.printfln("%v is %v years old and has %v teeth", p.name, p.age, p.number_of_teeth)
    fmt.print(typeid_of(type_of(p)))
    fmt.println(" size is:", size_of(p))
}

Person :: struct {
    name: string,
    health: int,
    age: int,
    number_of_teeth: int,
    height_meters: f32,
}

Couple_Data :: struct {
    person_1: Person,
    person_2: Person,
}



//multiple return values

@require_results
divide_and_double :: proc(n: f32, d: f32) -> (f32, bool) {
    if d == 0 {
	return 0, false
    }
    return (n/d) * 2, true
}

divide_and_double2 :: proc(n: f32, d: f32) -> (res: f32, ok: bool) {
    if d == 0 {
	return
    }
    res = (n/d)*2
    ok = true
    return
}

//nested procedures

do_stuff :: proc() {
    print_message :: proc(msg: string) {
	fmt.println(msg)
    }

    print_message("HELLO FROM HELL")
}

length :: proc {
    length_float2,
    length_float3,
}


length_float2 :: proc(v: [2]f32) -> f32 {
    return math.sqrt(v.x * v.x + v.y * v.y)
}

length_float3 :: proc(v: [3]f32) -> f32 {
    return math.sqrt(v.x * v.x + v.y * v.y * v.z * v.z)
}

@init
startup :: proc() {
    fmt.println("Programm starting")
}


@fini
shutdown :: proc() {
    fmt.println("Programm shutting down")
}
