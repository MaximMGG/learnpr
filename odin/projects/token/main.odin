package main
import DB "database"
import N "window"


import "core:fmt"
import "core:c"
import "core:testing"



main :: proc() {
    fmt.println("Hello")
}

@(test)
ncureses_test :: proc(t: ^testing.T) {
    stdscr := N.initscr()
    N.raw()
    N.noecho()
    N.keypad(stdscr, true)

    ch: c.int
    for ch != 'q' {
	N.clear()
	ch = N.getch()

	N.refresh()
    }
    testing.expect_value(t, int('q'), int(ch))
    N.endwin()    
}
