package curses

import "core:c"

foreign import ncurses {
	"system:ncurses",
}

WINDOW :: struct {}

@(default_calling_convention = "c")
foreign ncurses {
  COLS: c.int
  LINES: c.int
  stdscr: ^WINDOW
  initscr         :: proc() -> ^WINDOW ---
  raw             :: proc() -> c.int ---
  cbreak          :: proc() -> c.int ---
  timeout         :: proc(delay: c.int) ---
  noecho          :: proc() -> c.int ---
  keypad          :: proc(widnow: ^WINDOW, param: c.bool) -> c.int ---
  // refresh       :: proc() -> c.int ---
  wrefresh        :: proc(win: ^WINDOW) -> c.int ---

  //PRINTING
  printw          :: proc(#c_vararg args: ..any) -> c.int ---
  wprintw         :: proc(win: ^WINDOW, #c_vararg args: ..any) -> c.int ---
  mvwprintw       :: proc(windwo: ^WINDOW, y: c.int, x: c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
  mvprintw        :: proc(y: c.int, x: c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---

  box             :: proc(win: ^WINDOW, verch: c.char, horch: c.char) -> c.int ---
  border          :: proc(ls, rc, ts, bs, tl, tr, bl, br: c.char) -> c.int ---
  wborder         :: proc(win: ^WINDOW, ls, rc, ts, bs, tl, tr, bl, br: c.char) -> c.int ---
  wmove           :: proc(win: ^WINDOW, y, x: c.int) -> c.int ---
  newwin          :: proc(nlines, ncols, begin_y, begin_x: c.int) -> ^WINDOW ---
  delwin          :: proc(win: ^WINDOW) -> c.int ---
  endwin          :: proc() -> c.int ---
  wgetch          :: proc(win: ^WINDOW) -> c.int ---
  // clear       :: proc() -> c.int ---
  wclear          :: proc(win: ^WINDOW) -> c.int ---

  getattrs        :: proc(win: ^WINDOW) -> c.int ---
  getbegx         :: proc(win: ^WINDOW) -> c.int ---
  getbegy         :: proc(win: ^WINDOW) -> c.int ---
  getcurx         :: proc(win: ^WINDOW) -> c.int ---
  getcury         :: proc(win: ^WINDOW) -> c.int ---
  getmaxx         :: proc(win: ^WINDOW) -> c.int ---
  getmaxy         :: proc(win: ^WINDOW) -> c.int ---
  getparx         :: proc(win: ^WINDOW) -> c.int ---
  getpary         :: proc(win: ^WINDOW) -> c.int ---

  move            :: proc() -> c.int ---
  addchstr        :: proc(chstr: ^c.uint) -> c.int ---
  addchnstr       :: proc(chstr: ^c.uint, n: c.int) -> c.int ---
  waddchstr       :: proc(win: ^WINDOW, chstr: ^c.uint) -> c.int ---
  waddchnstr      :: proc(win: ^WINDOW, chstr: ^c.uint, n: c.int) -> c.int ---
  mvaddchnstr     :: proc(y,x: c.int, chstr: ^c.uint) -> c.int ---
  mvaddchstr      :: proc(y, x: c.int, chstr: ^c.uint) -> c.int ---
  mvwaddchstr     :: proc(win: ^WINDOW, y, x: c.int, chstr: ^c.uint) -> c.int ---
  mvwaddchnstr    :: proc(win: ^WINDOW, y, x: c.int, chstr: ^c.uint, n: c.int) -> c.int ---
  echochar        :: proc(ch: c.uint) -> c.int ---

  addstr          :: proc(str: cstring) -> c.int ---
  waddstr         :: proc(win: ^WINDOW, str: cstring) -> c.int ---
  mvaddstr        :: proc(y, x: c.int, str: cstring) -> c.int ---
  mvwaddstr       :: proc(win: ^WINDOW, y, x: c.int, str: cstring) -> c.int ---
  addnstr         :: proc(str: cstring, n: c.int) -> c.int ---
  waddnstr        :: proc(win: ^WINDOW, str: cstring, n: c.int) -> c.int ---
  mvaddnstr       :: proc(y, x: c.int, str: cstring, n: c.int) -> c.int ---
  mvwaddnstr      :: proc(win: ^WINDOW, y, x: c.int, str: cstring, n: c.int) -> c.int ---
  addch           :: proc(ch: c.uint) -> c.uint ---
  waddch          :: proc(win: ^WINDOW, ch: c.uint) -> c.int ---
  mvaddch         :: proc(y, x: c.int, ch: c.uint) -> c.int ---
  mvwaddch        :: proc(win: ^WINDOW, y, x: c.int, ch: c.uint) -> c.int ---
}

clear :: #force_inline proc() -> c.int {
	return wclear(stdscr)
}

refresh :: #force_inline proc() -> c.int {
  return wrefresh(stdscr)
}

getch :: #force_inline proc() -> c.int {
		return wgetch(stdscr)
}

getmaxyx :: #force_inline proc(win: ^WINDOW = stdscr, y, x: ^c.int) {
  y^ = getmaxy(win)
  x^ = getmaxx(win)
}


