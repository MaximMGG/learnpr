package window

import "core:c"
import "core:c/libc"
import token "../tok"

foreign import ncurses {
  "system:ncurses",
}

WINDOW :: struct {}

stdscr: ^WINDOW 

Window :: struct {
  tokens: [dynamic]^token.Token
}


@(default_calling_convention = "c")
foreign ncurses {
    initscr :: proc() -> ^WINDOW ---
    raw :: proc() -> c.int ---
    cbreak :: proc() -> c.int ---
    timeout :: proc(delay: c.int) ---
    noecho :: proc() -> c.int ---
    keypad :: proc(widnow: ^WINDOW, param: c.bool) -> c.int ---
    // refresh :: proc() -> c.int ---
    wrefresh :: proc(win: ^WINDOW) -> c.int ---
    mvwprintw :: proc(windwo: ^WINDOW, y: c.int, x: c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
    mvprintw :: proc(y: c.int, x: c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
    box :: proc(win: ^WINDOW, verch: c.char, horch: c.char) -> c.int ---
    border :: proc(ls, rc, ts, bs, tl, tr, bl, br: c.char) -> c.int ---
    wborder :: proc(win: ^WINDOW, ls, rc, ts, bs, tl, tr, bl, br: c.char) -> c.int ---
    move :: proc(y, x: c.int) -> c.int ---
    wmove :: proc(win: ^WINDOW, y, x: c.int) -> c.int ---
    addch :: proc(ch: c.char) -> c.int ---
    waddch :: proc(win: ^WINDOW, ch: c.char) -> c.int ---
    mvwaddch :: proc(win: ^WINDOW, y,x: c.int, ch: c.char) -> c.int ---
    mvaddch :: proc(y,x: c.int, ch: c.char) -> c.int ---
    newwin :: proc(nlines, ncols, begin_y, begin_x: c.int) -> ^WINDOW ---
    delwin :: proc(win: ^WINDOW) -> c.int ---
    endwin :: proc() -> c.int ---
    getch :: proc() -> c.int ---
    wgetch :: proc(win: ^WINDOW) -> c.int ---
    // clear :: proc() -> c.int ---
    wclear :: proc(win: ^WINDOW) -> c.int ---
}


initncurses :: proc() -> ^WINDOW {
  stdscr = initscr()
  return stdscr
}


clear :: #force_inline proc() -> c.int {
  return wclear(stdscr)
}

refresh :: #force_inline proc() -> c.int {
  return wrefresh(stdscr)
}

FMT_HEADER : cstring : "%-20s %-20s %-20s %-20s"
FMT_FMT : cstring : "%-20s %-20lf %-20lf %-20s"

run :: proc(w: ^Window) {
  ch: c.int
  i: c.int = 1
  j: c.int = 1
  for ch != 'q' {

    i = 1
    j = 1

    for tok in w.tokens {
      token.request(tok)
    }
    
    clear()
    mvprintw(i, j, FMT_HEADER, cstring("TOKEN"), cstring("PRICE"), cstring("VOLUME"), cstring("-TEST-"))
    i += 1
    for tok in w.tokens {
      mvprintw(i, j, FMT_FMT,  cstring(raw_data(tok.symbol)), tok.ticker.lastPrice, tok.ticker.volume, cstring("-test-"))
      i += 1
      refresh()
    }
    ch = getch()
  }
}

create_window :: proc() -> ^Window {
  w := new(Window)
  return w
}

destroy_window :: proc(win: ^Window) {
  for tok in win.tokens {
    token.destroy(tok)
  }
  delete(win.tokens)
  free(win)
}

main :: proc() {
  w := initncurses()
  raw()
  noecho()
  keypad(w, true)
  timeout(50)

  win := create_window()
  append(&win.tokens, token.create("BTCUSDT"))
  append(&win.tokens, token.create("LTCUSDT"))

  run(win)

  destroy_window(win)

  endwin()
}


