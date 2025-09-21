package type_exper


import "core:fmt"
import i "base:intrinsics"




print_type :: proc(t: typeid) {
    if (i.type_is_numeric(typeid_of(t))) {
	fmt.println("Type is number", t)
    }
}


main :: proc() {

    print_type(int)
    
}
