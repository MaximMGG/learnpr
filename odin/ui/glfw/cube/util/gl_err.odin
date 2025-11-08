package util
import "core:fmt"
import gl "vendor:OpenGL"


check_err :: proc() {
    err: u32
    err = gl.GetError()
    for err != 0 {
        fmt.eprintln("0X", err)
        fmt.eprintln(gl.get_last_error_message())
    }
}
