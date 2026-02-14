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
  initscr   :: proc() -> ^WINDOW ---
  raw       :: proc() -> c.int ---
  cbreak    :: proc() -> c.int ---
  timeout   :: proc(delay: c.int) ---
  noecho    :: proc() -> c.int ---
  keypad    :: proc(widnow: ^WINDOW, param: c.bool) -> c.int ---
  // refresh :: proc() -> c.int ---
  wrefresh  :: proc(win: ^WINDOW) -> c.int ---

  //PRINTING
  printw    :: proc(#c_vararg args: ..any) -> c.int ---
  wprintw   :: proc(win: ^WINDOW, #c_vararg args: ..any) -> c.int ---
  mvwprintw :: proc(windwo: ^WINDOW, y: c.int, x: c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
  mvprintw  :: proc(y: c.int, x: c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---

  box       :: proc(win: ^WINDOW, verch: c.char, horch: c.char) -> c.int ---
  border    :: proc(ls, rc, ts, bs, tl, tr, bl, br: c.char) -> c.int ---
  wborder   :: proc(win: ^WINDOW, ls, rc, ts, bs, tl, tr, bl, br: c.char) -> c.int ---
  move      :: proc(y, x: c.int) -> c.int ---
  wmove     :: proc(win: ^WINDOW, y, x: c.int) -> c.int ---
  addch     :: proc(ch: c.char) -> c.int ---
  waddch    :: proc(win: ^WINDOW, ch: c.char) -> c.int ---
  mvwaddch  :: proc(win: ^WINDOW, y, x: c.int, ch: c.char) -> c.int ---
  mvaddch   :: proc(y, x: c.int, ch: c.char) -> c.int ---
  newwin    :: proc(nlines, ncols, begin_y, begin_x: c.int) -> ^WINDOW ---
  delwin    :: proc(win: ^WINDOW) -> c.int ---
  endwin    :: proc() -> c.int ---
  wgetch    :: proc(win: ^WINDOW) -> c.int ---
  // clear :: proc() -> c.int ---
  wclear    :: proc(win: ^WINDOW) -> c.int ---

  getattrs  :: proc(win: ^WINDOW) -> c.int ---
  getbegx   :: proc(win: ^WINDOW) -> c.int ---
  getbegy   :: proc(win: ^WINDOW) -> c.int ---
  getcurx   :: proc(win: ^WINDOW) -> c.int ---
  getcury   :: proc(win: ^WINDOW) -> c.int ---
  getmaxx   :: proc(win: ^WINDOW) -> c.int ---
  getmaxy   :: proc(win: ^WINDOW) -> c.int ---
  getparx   :: proc(win: ^WINDOW) -> c.int ---
  getpary   :: proc(win: ^WINDOW) -> c.int ---
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


