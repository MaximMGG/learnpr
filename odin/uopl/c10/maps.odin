package maps

import "core:fmt"

main :: proc() {
    //one()
    two()
}

add_to_set :: proc(m: ^map[$V]struct{}, v: V) {
    m[v] = {}
}

two :: proc() {
    set_of_names: map[string]struct{}
    defer delete(set_of_names)

    set_of_names["Pontus"] = {}

    if "Pontus" in set_of_names {
	fmt.println("Yes")
    }

    add_to_set(&set_of_names, "Mushulitos")

    for k in set_of_names {
	fmt.println(k)
    }
    
    delete_key(&set_of_names, "Pontus")
}

one :: proc() {
    age_by_name: map[string]int
    defer delete(age_by_name)

    age_by_name["Karl"] = 35
    age_by_name["Klucke"] = 7
    age_by_name["Billy"] = 14
    age_by_name["Marry"] = 11

    fmt.println(age_by_name)

    if karl_age, ok := age_by_name["Karl"]; ok {
	fmt.println("Karl age is:", karl_age)
    }

    fmt.println("Karl" in age_by_name)
    fmt.println("OJOJ" not_in age_by_name)

    for k, v in age_by_name {
	fmt.printfln("%s - %d", k, v)
    }
}
