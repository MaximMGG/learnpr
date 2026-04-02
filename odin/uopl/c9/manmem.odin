package manmem

import "core:fmt"
import "core:mem"

main :: proc() {
    dyn_arr: [dynamic]int

    append(&dyn_arr, 5)

    fmt.println("After first append:")
    fmt.println("Capacity:", cap(dyn_arr))
    fmt.println("Length:", len(dyn_arr))


    for i in 0..<7 {
	append(&dyn_arr, i)
    }
    
    fmt.println("\nAfter 7 more appends:")
    fmt.println("Capacity:", cap(dyn_arr))
    fmt.println("Length:", len(dyn_arr))

    append(&dyn_arr, 5)
    
    fmt.println("\nAfter one more append:")
    fmt.println("Capacity:", cap(dyn_arr))
    fmt.println("Length:", len(dyn_arr))

    delete(dyn_arr)
    prealloc_dun_arr()
    jeck()
    arr_experiment()
    new_arr()


    b := make([dynamic]int, allocator = context.temp_allocator)


    free_all(context.temp_allocator)
}

prealloc_dun_arr :: proc() {
    dyn_arr := make([dynamic]int, 0 , 20)

    fmt.println("just make dynamic array")
    fmt.println("Capacity:", cap(dyn_arr))
    fmt.println("Length:", len(dyn_arr))
    
    delete(dyn_arr)
    experiment_1()
}

Dog :: enum {
    Jussy,
    Bill,
    Kur,
}

jeck :: proc() {
    arr := [Dog]int{}
    arr[.Bill] = 123
    fmt.println(arr)
}

dyn_arr :: struct($T: typeid) {
    data: []T,
    len: int,
    cap: int,
}

dyn_arr_create :: proc($T: typeid) -> dyn_arr(T) {
    return dyn_arr(T){data = make([]T, 20), len = 0, cap = 20}
}

dyn_arr_append :: proc(a: ^$A/dyn_arr($T), data: T) {
    if a.len == a.cap {
	new_arr := make([]T, a.cap * 2)
	mem.copy(raw_data(new_arr), raw_data(a.data), size_of(T) * a.cap)
	delete(a.data)
	a.data = new_arr
	a.cap *= 2
    }

    
    a.data[a.len] = data
    a.len += 1
}

dyn_arr_destroy :: proc(a: ^$A/dyn_arr($T)) {
    delete(a.data)
    a.len = 0
    a.cap = 0
}

arr_experiment :: proc() {
    da := dyn_arr_create(f32)
    defer dyn_arr_destroy(&da)

    dyn_arr_append(&da, 2.3)

    for i in 0..<25 {
	dyn_arr_append(&da, f32(i))
    }
    
    fmt.println(da)
}

experiment_1 :: proc() {
    my_ints: [dynamic]int

    for i in 0..<1024 {
	print_info(my_ints)
	append(&my_ints, 5)
    }
}

print_info :: proc(arr: [dynamic]int) {
    fmt.println("len: %v", len(arr))
    fmt.println("cap: %v", cap(arr))
    fmt.println("data: %p", raw_data(arr))
    
}


new_arr :: proc() {
    arr := new([dynamic]int)

    for i in 0..<100 {
	append(arr, i)
    }

    fmt.println(len(arr))
    fmt.println(cap(arr))

    fmt.println(arr)


    free(arr)
    
}
