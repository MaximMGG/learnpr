package compress

import "core:fmt"
import "core:os"
import "core:slice"

main :: proc() {
    file, f_err := os.open("test.txt", os.O_RDONLY)
    defer os.close(file)
    if f_err != nil {
        fmt.eprintf("Can't open file\n")
        return
    }
    stat, _ := os.fstat(file)
    buf := make([]u8, stat.size)
    defer delete(buf)
    os.read(file, buf)

    tree: map[u8]int

    total: u64
    for i in 0..<stat.size {
        if buf[i] in tree {
            tree[buf[i]] += 1
        } else {
            tree[buf[i]] = 1
        }
        total += 1
    }

    for k, v in tree {
        fmt.printf("Char: %c, value: %d\n", k, v)
    }
    fmt.printf("Total: %d\n", total)
}
