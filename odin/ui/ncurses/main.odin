package cur_test


import "curses"
import "core:c"
//import "core:fmt"

TB_HEIGHT :: 14
TB_WIDTH :: 28


draw_tittle_box :: proc() {
  height, width: c.int
  curses.getmaxyx(y = &height, x = &width)
  tw := curses.newwin(TB_HEIGHT, TB_WIDTH, 5, 5)
  curses.box(tw, 0, 0)
  curses.wrefresh(tw)
  curses.delwin(tw)
}

draw_outer_box :: proc() {
  curses.box(curses.stdscr, 0, 0)
}


main :: proc() {
  curses.initscr()

  y, x: c.int
  curses.getmaxyx(curses.stdscr, &y, &x)
  draw_outer_box()
  curses.mvprintw(y-2, 1, "Width=%d, Height=%d", x, y)
  curses.refresh()

  draw_tittle_box()

  ch := curses.getch()

  curses.endwin()
}
