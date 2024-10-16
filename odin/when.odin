package main


import "core:fmt"


main :: proc() {
    when ODIN_ARCH == .i386 {
        fmt.println("32 bit")
    } else when ODIN_ARCH == .amd64 {
        fmt.println("64 bit")
    } else {
        fmt.println("Unsupported architecture")
    }
}
