package file_read

import "core:fmt"
import "core:os"


main :: proc() {
    f, err := os.open("main.odin", os.O_RDONLY)

    buf: [512]u8

    bytes, _ := os.read(f, buf[:])

    fmt.println("Read", bytes, "content: \n")
    fmt.printf("%s\n", buf)
    
}
