package plymofr

import "base:intrinsics"
import "core:fmt"
import "core:math/rand"


my_clamp :: proc(val: $T, min: T, max: T) -> T where
intrinsics.type_is_numeric(T) {
    if val < min {
	return min
    }

    if val >= max {
	return max
    }

    return val
}

make_random_sized_slice :: proc($T: typeid) -> []T {
    random_size := rand.int_max(1024)
    return make([]T, random_size)
}


make_array_of_7 :: proc($N: int, $T: typeid) -> [N]T {
    res := [N]T{}
    for &v in res {
	v = 7
    }
    return res
}


make_dyn_arr :: proc($T: typeid) -> [dynamic]T {
    arr := make([dynamic]T)

    return arr
}


delete_dyn_arr :: proc(arr: $T/[dynamic]$E) {
    delete(arr)
}

MY_Arr :: [dynamic]int

one :: proc() {
    a: MY_Arr = make_dyn_arr(int)
    fmt.println(len(a))
    delete_dyn_arr(a)
}

main :: proc() {
    number: int = 7

    fmt.println(my_clamp(number, 2, 7))
    s := make_random_sized_slice(f32)
    fmt.println(len(s))
    delete(s)


    arr := make_array_of_7(123, f32)

    s_arr: Special_Array(f64, 128)

    for i in 0..<32 {
	s_arr.items[i] = rand.float64_range(-10, 10)
	s_arr.num_items_used += 1
    }

    random_thing := find_random_thing_in_special_array(s_arr)
    fmt.println(random_thing)


    m: Maybe(f64)
    m = 4.44

    if m_val, m_ok := m.?; m_ok {
	fmt.println(m_val)
    }


    t: Test
    t = f64(1.4)

    if v, ok := t.(f64); ok {
	fmt.println(v)
    }
    one()
}

Test :: union {
    int,
    f32,
    f64,
}


find_random_thing_in_special_array :: proc(arr: Special_Array($T, $N)) -> T {
    return arr.items[rand.int_max(arr.num_items_used)]
}


Special_Array :: struct($T: typeid, $N: int) {
    items: [N]T,
    num_items_used: int,
}


