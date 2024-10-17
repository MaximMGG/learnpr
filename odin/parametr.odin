package parametr
import "core:fmt"

tamp_struct :: struct($K, $V: typeid) {
    key: K,
    value: V,
}

make_array :: proc($T: typeid, $N: int) -> [dynamic]T {
    res := make([dynamic]T, N)
    return res
}

main :: proc() {
    array := make_array(f32, 10)

    append(&array, 1, 2, 3)
    fmt.println(array)
    defer delete(array)

    mmap := tamp_struct(int, byte) {
        123, 1
    }
    fmt.println(mmap)

    T :: int
    arr := foo(4, T)
    for v, i in arr {
        assert(v == T(i * i))
    }

}

foo :: proc($N: $I, $T: typeid) -> (res: [N]T) {
    fmt.printf("Generating an array of type %v from the value %v of type %v\n",
        typeid_of(type_of(res)), N, typeid_of(I))
    for i in 0..<N {
        res[i] = i*i
    }
    return
}
