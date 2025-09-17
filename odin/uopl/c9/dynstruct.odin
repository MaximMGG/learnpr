package dynstruct

import "core:fmt"


Cat :: struct {
    age: int,
    name: string,
}

make_cat :: proc(name: string, age: int) -> ^Cat {
    cat := new(Cat)
    cat^ = {
	name = name,
	age = age,
    }
    return cat
}

cat_simulation :: proc() {
    cat := make_cat("Fluffe", 12)

    free(cat)
}

main :: proc() {
    cat_simulation()

    
}
