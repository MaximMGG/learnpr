package conteiners

import "core:fmt"
import "core:math/rand"
import "core:slice"


main :: proc() {
    //one()
    //two()
    //three()
    four()
}

four :: proc() {
    arr := [10]int{}
    for i in 0..<len(arr) {
	arr[i] = i * i
    }

    s1 := arr[0:6]
    s2 := slice.clone(s1)
    s1[0] = 123123

    fmt.println(s1)
    fmt.println(s2)

    delete(s2)
    
}




Cat :: struct {
    name: string,
    age: int,
}

add_cat_of_random_age :: proc(cats: ^[dynamic]Cat, name: string) {
    random_age := rand.int_max(12) + 2
    append(cats, Cat{
	name = name,
	age = random_age,
    })
}


print_cats :: proc(cats: []Cat) {
    for cat in cats {
	fmt.printfln("%v is %v years old", cat.name, cat.age)
    }
}

mutate_cats :: proc(cats: []Cat) {
    for &cat in cats {
	cat.age = rand.int_max(12) + 2
    }
}


three :: proc() {
    all_the_cats: [dynamic]Cat
    add_cat_of_random_age(&all_the_cats, "Klucke")
    add_cat_of_random_age(&all_the_cats, "Pontus")

    print_cats(all_the_cats[:])
    mutate_cats(all_the_cats[:])
    print_cats(all_the_cats[:])    
}



display_numbers :: proc(numbers: []int) {
    fmt.println(numbers)
}

my_numbers: [128]int

two :: proc() {
    for i in 0..<len(my_numbers) {
	my_numbers[i] = i * i
    }

    for i := 0; i < len(my_numbers); i += 10 {
	slice_end := min(i + 10, len(my_numbers))
	ten_numbers := my_numbers[i:slice_end]
	display_numbers(ten_numbers)
    }
}

one :: proc() {
    
    arr: [50]int
    index: int

    for &i in arr {
	i = index
	index += 1
    }

    first_five := arr[0:6]

    fmt.println(first_five)

    last_6 := arr[len(arr) - 6:]

    fmt.println(last_6)


    dyn_arr: [dynamic]f32

    for i in 0..<200 {
	append(&dyn_arr, f32(i * i))
    }

    half_dyn_arr_size := len(dyn_arr) / 2
    half_the_dyn_arr := dyn_arr[:half_dyn_arr_size]

//    fmt.println(half_the_dyn_arr)

    dyn_arr[20] = 777.777
    for v, i in half_the_dyn_arr {
	fmt.printf("Index %d - %f\n", i, v)
    }
}
