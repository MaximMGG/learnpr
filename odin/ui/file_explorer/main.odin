package file_explorer

import "core:fmt"
import X "vendor:x11/xlib"
import GL "vendor:OpenGL"


main :: proc() {
    fmt.printf("Hello world!\n")

    display: ^X.Display

    display = X.OpenDisplay(nil)
    if display == nil {
        fmt.eprintf("Cannot open display\n")
        return
    }

    screen := X.DefaultScreenOfDisplay(display)
    screenId := X.DefaultScreen(display)
    

}
