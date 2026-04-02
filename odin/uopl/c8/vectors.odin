package vectors

import "core:fmt"


Vector3 :: [3]f32


main :: proc() {
    arr := [4]int{1, 2, 3, 4}
    arr2 := arr.yz

    fmt.println(arr2)

    position: Vector3

    velocity := Vector3{0, 0, 10}
    position += velocity
    fmt.println(position)

    position1 := Vector3 {10, 21, 1}
    position2 := Vector3 {9, 1, 3}
    from_1_to_2 := position2 - position1
    fmt.println(from_1_to_2)

    xz_vector := Vector3 {10, 0, -2}
    z_scaled_up := xz_vector * {1, 1, 10}
    fmt.println(z_scaled_up)

    one_meter_ahead := Vector3 {0, 0, 1}
    ten_meters_ahead := one_meter_ahead * 10
    fmt.println(ten_meters_ahead)

    draw_image({10, 223})

    nice_rating := [Nice_People]int {
	    .Bob = 5,
	    .Klucke = 7,
	    .Tim = 123,
    }
    bobs_niceness := nice_rating[.Bob]
    fmt.println(nice_rating)
    fmt.println(bobs_niceness)
    nice_rating2 := #partial [Nice_People]int {
	    .Klucke = 10,
    }
    fmt.println(nice_rating2)
}


Nice_People :: enum {
    Bob,
    Klucke,
    Tim,
}


draw_image :: proc(position: [2]f32) {
    fmt.println(position)
}
