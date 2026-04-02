package custom_it

import "core:fmt"


main :: proc() {
    //one()
    two()
}


Slot :: struct {
    important_val: int,
    used: bool,
}

Slots_Iterator :: struct {
    index: int,
    data: []Slot,
}

make_slots_iterator :: proc(data: []Slot) -> Slots_Iterator {
    return {data = data}
}

slots_iterator :: proc(it: ^Slots_Iterator) -> (val: Slot, idx: int, cond: bool) {
    cond = it.index < len(it.data)

    for ;cond; cond = it.index < len(it.data) {
	if !it.data[it.index].used {
	    it.index += 1
	    continue
	}

	val = it.data[it.index]
	idx = it.index
	it.index += 1
	break
    }
    return
}

one :: proc() {
    slots := make([]Slot, 128)

    slots[10] = {
	important_val = 7,
	used = true,
    }

    it := make_slots_iterator(slots[:])

    for val in slots_iterator(&it) {
	fmt.println(val)
    }
}

My_Arr :: struct {
    data: []int,
}


Arr_It :: struct {
    arr: []int,
    index: int,
}

make_arr_it :: proc(arr: ^My_Arr) -> Arr_It {
    return {arr = arr.data}
}
arr_it :: proc(arr: ^Arr_It) -> (val: int, idx: int, cond: bool) {
    cond = arr.index < len(arr.arr)

    for ; cond; cond = arr.index < len(arr.arr) {
	val = arr.arr[arr.index]
	idx = arr.index
	arr.index += 1
	return
    }
    return
}


two :: proc() {
    m := My_Arr{data = {1, 2, 3, 4, 5}}
    it := make_arr_it(&m)

    for val in arr_it(&it) {
	fmt.println(val)
    }
    
}
