package maps_and_othero


import "core:fmt"
import "core:strings"


main :: proc() {

    m := make(map[string]int)
    defer delete(m)

    m["Bob"] = 33
    m["a"] = 1
    fmt.println(m)
    fmt.println("Len of map:", len(m), "cap of map:", cap(m))
    m["b"] = 2
    fmt.println(m)
    fmt.println("Len of map:", len(m), "cap of map:", cap(m))
    m["c"] = 3
    fmt.println(m)
    fmt.println("Len of map:", len(m), "cap of map:", cap(m))
    m["d"] = 4
    fmt.println(m)
    fmt.println("Len of map:", len(m), "cap of map:", cap(m))
    m["e"] = 5
    fmt.println(m)
    fmt.println("Len of map:", len(m), "cap of map:", cap(m))
    m["f"] = 6
    fmt.println(m)
    fmt.println("Len of map:", len(m), "cap of map:", cap(m))
    m["g"] = 7
    fmt.println(m)
    fmt.println("Len of map:", len(m), "cap of map:", cap(m))
    m["y"] = 8
    fmt.println(m)
    fmt.println("Len of map:", len(m), "cap of map:", cap(m))
    m["y"] = 9
    fmt.println(m)
    fmt.println("Len of map:", len(m), "cap of map:", cap(m))
    m["u"] = 10

    reserve(&m, 44)

    res, ok := m["j"]

    if ok {
        fmt.println("Result j:", res)
    } else {
        fmt.println("Key j, dont exists in map")
    }

    res, ok = m["y"]
    if ok {
        fmt.println("Result y:", res)
    } else {
        fmt.println("Key y, dont exists in map")
    }

    delete_key(&m, "y")
    res, ok = m["y"]
    if ok {
        fmt.println("Result y:", res)
    } else {
        fmt.println("Key y, dont exists in map")
    }


    fmt.println(m)
    fmt.println("Len of map:", len(m), "cap of map:", cap(m))

    for c: u8 = 'a'; c <= 'z'; c += 1 {
        tmp: ^u8
        tmp = &c
        tmp_s := strings.string_from_ptr(tmp, 1)

        elem, good := m[tmp_s]
        if good {
            fmt.println("Key:", tmp_s, "has value:", elem)
        } else {
            fmt.println("Key:", tmp_s, "has no any value")
        }

    }

}
