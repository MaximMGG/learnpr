package dyn_arr


import "core:fmt"
import "core:container/small_array"


dyn_arr :: struct($T: typeid){
    data: []T,
    len: u32,
    cap: u32,
}


dyn_arr_make :: proc {
    _dyn_arr_make,
    dyn_arr_make_len,
    dyn_arr_make_len_cap,
}

_dyn_arr_make :: proc($T: typeid) -> dyn_arr {
    return dyn_arr_make_len_cap(T)
}

dyn_arr_make_len :: proc($T: typeid, len: int = 0) -> dyn_arr {
    return dyn_arr_make_len_cap(T, len)
    
}

dyn_arr_make_len_cap :: proc($T: typeid, len: int = 0, cap: int = 8) -> dyn_arr {
    da: dyn_arr
    da.data = make([dynamic]T, len, cap)
    da.len = len
    da.cap = cap

    return da
}

dyn_arr_append :: proc(a: ^$A/dyn_arr($T), data: T) {
    if a.len == a.cap {
	old := a.data
	a.data = make([dynamic]T, 0, a.cap * 2)
	copy(a.data[:a.cap], old[:])
	delete(old)
    }


    i: [^]int = make([^]int, 20)
    i[0]
    raw_data(i)
}
