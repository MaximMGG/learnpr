package multi_p
import "core:fmt"

main :: proc() {
    x: [^]int
    fmt.println(x)
    b := [?]int{1, 2, 5}
    x = raw_data(b[:])
    fmt.println(x)
    fmt.println(x[1])
    fmt.println(b)
}
