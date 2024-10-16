package fixed_arrays


import "core:fmt"

main :: proc() {
    x := [5]int{1, 2, 3, 4, 5}
    for i in 0..=4 {
        fmt.println(x[i])
    }

    y := [?]int{1, 2, 3, 4, 5, 6, 7, 8}
    for i, index in y {
        fmt.println(i, y[index])
    }

    favorite_animals := [?]string{
        0 = "Raven",
        1 = "Zebra",
        2 = "Spider",
        3..=5 = "Frog",
        6..<8 = "Cat",
    }

    for animal in favorite_animals {
        fmt.println(animal)
    }

}
