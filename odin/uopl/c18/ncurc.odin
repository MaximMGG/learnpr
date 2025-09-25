package ncurc

import "core:fmt"
import "vendor:sdl2"
import "core:c"

foreign import lib {
    "system:curses",
}

Window :: struct {}

@(default_calling_convention="c")
foreign lib {
    initscr :: proc() -> ^Window ---
    refresh :: proc() ---
    wrefresh :: proc(w: ^Window) ---
    getch :: proc() -> c.int ---
    endwin :: proc() ---
}


main :: proc() {
    w := initscr()
    wrefresh(w)

    i := getch()
    
    endwin()
}
