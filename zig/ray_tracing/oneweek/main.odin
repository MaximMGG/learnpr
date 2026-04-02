package main

import "core:fmt"
import "core:math"
import "core:io"
import "core:slice"
import "core:os"
import "core:bufio"

Vec3 :: [3]f64


length_squared :: proc(vec: Vec3) -> f64 {
    return vec.x * vec.x + vec.y * vec.y + vec.z * vec.z
}


write_color :: proc(bw: ^bufio.Writer, vec: Vec3) {
    rb: i32 = i32(255.999 * vec.r)
    gb: i32 = i32(255.999 * vec.g)
    bb: i32 = i32(255.999 * vec.b)
    buf: [512]byte
    s := fmt.bprintf(buf[:], "%d %d %d\n", rb, gb, bb)

    bufio.writer_write_string(bw, s)
}



main :: proc() {

    image_width: i32 = 256
    image_height: i32 = 256;


    fmt.println("P3\n", image_width, ' ', image_height, "\n255\n", sep = "")
    wr := bufio.Writer{}

    stdout_stream := os.stream_from_handle(os.stdout)
    bufio.writer_init(&wr, stdout_stream)
    defer bufio.writer_flush(&wr);
    defer bufio.writer_destroy(&wr)

    #no_bounds_check {for j in 0..<image_height {
        fmt.eprint("\rScanlines remaining: ", (image_height - j), ' ', sep = "")
        for i in 0..<image_width {
            vec: Vec3 = {0, 0, 0}
            vec.r = f64(i) / f64((image_width - 1))
            vec.g = f64(j) / f64((image_height - 1))
            vec.b = 0.0

            write_color(&wr, vec)
        }
    }
    }
}


