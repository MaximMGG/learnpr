package struct_arrays

import "core:fmt"

main :: proc() {
    Vector3 :: struct{x, y, z: f32}

    N :: 2

    v_aos: [N]Vector3
    v_aos[0].x = 1
    v_aos[0].y = 4
    v_aos[0].z = 9

    fmt.println(len(v_aos))
    fmt.println(v_aos[0])
    fmt.println(v_aos[0].x)
    fmt.println(&v_aos[0].x)

    v_aos[1] = {0, 3, 4}
    v_aos[1].x = 2

    fmt.println(v_aos[1])
    fmt.println(v_aos)

    v_soa: #soa[N]Vector3

    v_soa[0].x = 1
    v_soa[0].y = 4
    v_soa[0].z = 9

    fmt.println(len(v_soa))
    fmt.println(v_soa[0])
    fmt.println(v_soa[0].x)
    fmt.println(&v_soa[0].x)
    v_soa[1] = {0, 3, 4}
    v_soa[1].x = 2
    fmt.println(v_soa[1])

    // Can use SOA syntax if necessary

    v_soa.x[0] = 1
    v_soa.y[0] = 4
    v_soa.z[0] = 9
    fmt.println(v_soa.x[0])

    assert(&v_soa[0].x == &v_soa.x[0])

    fmt.println(v_aos)
    fmt.println(v_soa)
    fmt.println("___________________")
    main2()
    fmt.println("___________________")
    main3()
    fmt.println("___________________")
    main4()

}

main2 :: proc() {
    Vector3 :: struct{x: i8, y: i16, z: f32}

    N :: 3

    v: #soa[N]Vector3
    v[0].x = 1
    v[0].y = 4
    v[0].z = 9

    s: #soa[]Vector3
    s = v[:]
    assert(len(s) == N)
    fmt.println(s)
    fmt.println(s[0].x)

    a := s[1:2]
    assert(len(a) == 1)
    fmt.println(a)
    a[0].x = 123
    fmt.println(a)
}

main3 :: proc() {
    Vector3 :: distinct [3]f32
    d: #soa[dynamic]Vector3

    append_soa(&d, Vector3{1, 2, 3}, Vector3{4, 5, 6}, Vector3{-1, 3, -9})
    fmt.println(d)
    fmt.println(len(d))
    fmt.println(cap(d))
    fmt.println(d[:])
}

main4 :: proc() {
    x := []i32{1, 3, 9}
    y := []f32{2, 4, 1}
    z := []b32{true, false, true}

    s := soa_zip(a=x, b=y, c=z)

    for v, i in s {
        fmt.println(v, i)
        fmt.println(v.a, v.b, v.c)
    }

    a, b, c := soa_unzip(s)
    fmt.println(a, b, c)

}

