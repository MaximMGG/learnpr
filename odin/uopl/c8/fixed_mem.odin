package fixedmem

import "core:fmt"


main :: proc() {
    arr := [5]int {4234, 151, 23423, 343, 1919}


    for v, i in arr {
	fmt.printfln("Index %d, value %d", i, v)
    }

    fmt.println("Rex index")

    for i in 0..<len(arr) {
	fmt.printfln("Index %d, value %d", i, arr[i])
    }

    rd := &arr[0]
    fmt.println(rd^)

    fmt.println("Copying arrays")
    arr2 := arr

    arr[3] = 888

    for i in arr2 {
	fmt.println(i)
    }

    fmt.printf("arr1 address: %p\n", arr)

    fmt.printf("arr2 address: %p\n", arr2)

    arr3 := arr[0:3]

    fmt.println("arr3, arr[0:3] sliced")

    for i in arr3 {
	fmt.println(i)
    }

    arr4 := arr[3:5]

    fmt.println("arr4, arr[3:5] sliced")

    for i in arr4 {
	fmt.println(i)
    }

    
}
