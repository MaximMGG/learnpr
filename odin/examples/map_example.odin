#feature dynamic-literals
package map_example

import "core:fmt"

main :: proc() {
    m := make(map[string]int)
    delete(m)

    m["Alice"] = 1
    m["Bob"] = 2

    fmt.println(m["Alice"])
    fmt.println(m["Bob"])

    alice_exists := "Alice" in m

    if alice_exists {
	fmt.println("Hurray, Alice is included!")
    } else {
	fmt.println("Please be sure to include Alice to the party :(")
    }

    fmt.println("Length of map is", len(m))

    deleted_key, deleted_value := delete_key(&m, "Alice")

    fmt.println("We have now removed key", deleted_key, "with value", deleted_value)

    clear(&m)

    Actor :: struct {
	age: int,
	salary: int,
    }
    actors := make(map[string]Actor)
    defer delete(actors)

    actors["Alice"] = {45, 140_000}
    actors["Bob"] = {35, 120_000}

    value, ok := &actors["Alice"]
    if ok {
	value^ = {36, 200_000}
    }

    for k, v in actors {
	fmt.println("Name:", k, "Age:", v.age, "Salary:", v.salary)
    }

    m2 := map[string]int {
	"Bob" = 10,
	"Chloe" = 20,
    }
    defer delete(m2)
    fmt.println(m2)
    
}
