package casting

import "core:fmt"


main :: proc() {
    f: f64 = 123414.8334
    i: u64 = u64(f)
    f_back: f64 = f64(i)

    fmt.println("From f64 to u64 and back just cast: f64 -> ", f, "u64 -> i", i, 
        "agane f64 -> ", f_back)


    i_trans: u64 = transmute(u64)f
    f_trans: f64 = transmute(f64)i_trans
    fmt.println("From f64 to u64 and back transmute: f64 -> ", f, "u64 -> i",
        i_trans, "agane f64 -> ", f_trans)

    i_ptr: u64 = (^u64)(&f)^
    f_ptr: f64 = (^f64)(&i_ptr)^
    fmt.println("From f64 to u64 and back ptr cast: f64 -> ", f, "u64 -> i",
        i_ptr, "agane f64 -> ", f_ptr)


    a: [12]u8 = ---
    fmt.println("---", a)

    fmt.println(typeid_of(type_of(f)))

}
