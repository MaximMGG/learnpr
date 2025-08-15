package inc


import "core:fmt"
import "core:c"
foreign import ncurses "system:ncurses"


WINDOW :: struct {

}

int :: proc() {

}

foreign ncurses {
    initscr :: proc() -> ^WINDOW ---
    refresh :: proc() -> c.int ---
    endwin :: proc() -> c.int ---

    getch :: proc() -> c.int ---


}

main :: proc() {
    ch: c.int

    initscr()
    refresh()

    for(ch != '\n') {
        ch = getch()
    }


    endwin()


}
