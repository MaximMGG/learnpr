package procs

import "core:fmt"
import "core:c"

foreign import lic {
    "libc",
}

foreign lic {
   printf :: proc(fmt: cstring, t: ..any) -> c.int ---
}

sum :: proc(nums: ..int) -> (result: int) {
    for n in nums {
        result += n
    }
    return
}


main :: proc() {
    printf("%d\n", sum(3, 4, 5, 1, 2, 3, 5, 9, 0))
    //fmt.println(sum(3, 4, 5, 1, 2, 3, 5, 9, 0))

}
