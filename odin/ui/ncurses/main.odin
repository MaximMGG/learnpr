package cur_test

import "curses"
import "core:c"

TB_HEIGHT :: 14
TB_WIDTH :: 28

DEF_WIDTH :: 10

print_err_msg :: proc(msg: string) {
  y := len(msg) / DEF_WIDTH
  if len(msg) % DEF_WIDTH > 0 {
    y += 1
  }
  err_win := curses.newwin(c.int(y + 2), DEF_WIDTH + 2, 5, 5)
  curses.box(err_win, 0, 0)
  corret_y: c.int = 1
  corret_x: c.int = 1
  for i in 0..<len(msg) {
    curses.mvwaddch(err_win, corret_y, corret_x, c.uint(msg[i]))
    corret_x += 1
    if corret_x > DEF_WIDTH {
      corret_x = 1
      corret_y += 1
    }
  }
  curses.wrefresh(err_win)
  curses.wgetch(err_win)
  curses.wborder(err_win, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ')
  curses.wclear(err_win)
  curses.wrefresh(err_win)
  curses.delwin(err_win)
}

draw_tittle_box :: proc() {
  height, width: c.int
  curses.getmaxyx(y = &height, x = &width)
  tw := curses.newwin(TB_HEIGHT, TB_WIDTH, (height - TB_HEIGHT)/ 2, 
                                          (width - TB_WIDTH)/ 2)
  curses.box(tw, 0, 0)

  curses.mvwaddstr(tw, 1, 1, "Hello")

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
  print_err_msg("This is test err message width qute long string!")

  ch := curses.getch()

  curses.endwin()
}
