package remword

import "core:c"



foreign import curses {
  "system:ncurses",
}

COLOR_BLACK	   :: 0
COLOR_RED	     :: 1
COLOR_GREEN	   :: 2
COLOR_YELLOW	 :: 3
COLOR_BLUE	   :: 4
COLOR_MAGENTA	 :: 5
COLOR_CYAN	   :: 6
COLOR_WHITE	   :: 7

WINDOW :: struct {}

KEY_DOWN ::	0402		/* down-arrow key */
KEY_UP ::		0403		/* up-arrow key */
KEY_LEFT ::	0404		/* left-arrow key */
KEY_RIGHT ::	0405		/* right-arrow key */
KEY_HOME ::	0406		/* home key */
KEY_BACKSPACE ::	0407		/* backspace key */
KEY_F0 :: 0410
KEY_DL ::		0510		/* delete-line key */
KEY_IL ::		0511		/* insert-line key */
KEY_DC ::		0512		/* delete-character key */
KEY_IC ::		0513		/* insert-character key */
KEY_EIC ::		0514		/* sent by rmir or smir in insert mode */
KEY_CLEAR ::	0515		/* clear-screen or erase key */
KEY_EOS ::		0516		/* clear-to-end-of-screen key */
KEY_EOL ::		0517		/* clear-to-end-of-line key */
KEY_SF ::		0520		/* scroll-forward key */
KEY_SR ::		0521		/* scroll-backward key */
KEY_NPAGE ::	0522		/* next-page key */
KEY_PPAGE ::	0523		/* previous-page key */
KEY_STAB ::	0524		/* set-tab key */
KEY_CTAB ::	0525		/* clear-tab key */
KEY_CATAB ::	0526		/* clear-all-tabs key */
KEY_ENTER ::	0527		/* enter/send key */
KEY_PRINT ::	0532		/* print key */
KEY_LL ::		0533		/* lower-left key (home down) */
KEY_A1 ::		0534		/* upper left of keypad */
KEY_A3 ::		0535		/* upper right of keypad */
KEY_B2 ::		0536		/* center of keypad */
KEY_C1 ::		0537		/* lower left of keypad */
KEY_C3 ::		0540		/* lower right of keypad */
KEY_BTAB ::	0541		/* back-tab key */
KEY_BEG ::		0542		/* begin key */
KEY_CANCEL ::	0543		/* cancel key */
KEY_CLOSE ::	0544		/* close key */
KEY_COMMAND ::	0545		/* command key */
KEY_COPY ::	0546		/* copy key */
KEY_CREATE ::	0547		/* create key */
KEY_END ::		0550		/* end key */
KEY_EXIT ::	0551		/* exit key */
KEY_FIND ::	0552		/* find key */
KEY_HELP ::	0553		/* help key */
KEY_MARK ::	0554		/* mark key */
KEY_MESSAGE ::	0555		/* message key */
KEY_MOVE ::	0556		/* move key */
KEY_NEXT ::	0557		/* next key */
KEY_OPEN ::	0560		/* open key */
KEY_OPTIONS ::	0561		/* options key */
KEY_PREVIOUS ::	0562		/* previous key */
KEY_REDO ::	0563		/* redo key */
KEY_REFERENCE ::	0564		/* reference key */
KEY_REFRESH ::	0565		/* refresh key */
KEY_REPLACE ::	0566		/* replace key */
KEY_RESTART ::	0567		/* restart key */
KEY_RESUME ::	0570		/* resume key */
KEY_SAVE ::	0571		/* save key */
KEY_SBEG ::	0572		/* shifted begin key */
KEY_SCANCEL ::	0573		/* shifted cancel key */
KEY_SCOMMAND ::	0574		/* shifted command key */
KEY_SCOPY ::	0575		/* shifted copy key */
KEY_SCREATE ::	0576		/* shifted create key */
KEY_SDC ::		0577		/* shifted delete-character key */
KEY_SDL ::		0600		/* shifted delete-line key */
KEY_SELECT ::	0601		/* select key */
KEY_SEND ::	0602		/* shifted end key */
KEY_SEOL ::	0603		/* shifted clear-to-end-of-line key */
KEY_SEXIT ::	0604		/* shifted exit key */
KEY_SFIND ::	0605		/* shifted find key */
KEY_SHELP ::	0606		/* shifted help key */
KEY_SHOME ::	0607		/* shifted home key */
KEY_SIC ::		0610		/* shifted insert-character key */
KEY_SLEFT ::	0611		/* shifted left-arrow key */
KEY_SMESSAGE ::	0612		/* shifted message key */
KEY_SMOVE ::	0613		/* shifted move key */
KEY_SNEXT ::	0614		/* shifted next key */
KEY_SOPTIONS ::	0615		/* shifted options key */
KEY_SPREVIOUS ::	0616		/* shifted previous key */
KEY_SPRINT ::	0617		/* shifted print key */
KEY_SREDO ::	0620		/* shifted redo key */
KEY_SREPLACE ::	0621		/* shifted replace key */
KEY_SRIGHT ::	0622		/* shifted right-arrow key */
KEY_SRSUME ::	0623		/* shifted resume key */
KEY_SSAVE ::	0624		/* shifted save key */
KEY_SSUSPEND ::	0625		/* shifted suspend key */
KEY_SUNDO ::	0626		/* shifted undo key */
KEY_SUSPEND ::	0627		/* suspend key */
KEY_UNDO ::	0630		/* undo key */
KEY_MOUSE ::	0631		/* Mouse event has occurred */

foreign curses {
  stdscr: ^WINDOW

  echo         :: proc() -> c.int ---
  noecho       :: proc() -> c.int ---
  cbreak       :: proc() -> c.int ---
  newwin       :: proc(w, h, y, x: c.int) -> ^WINDOW ---
  raw          :: proc() -> c.int ---
  wattron      :: proc(w: ^WINDOW, attr: c.int) -> c.int ---
  wattroff     :: proc(w: ^WINDOW, attr: c.int) -> c.int ---
  wrefresh     :: proc(w: ^WINDOW) -> c.int ---
  initscr      :: proc() -> ^WINDOW ---
  getch        :: proc() -> c.int ---
  delwin       :: proc(w: ^WINDOW) -> c.int ---
  endwin       :: proc() -> c.int ---
  COLOR_PAIR   :: proc(color: c.int) -> c.int ---
  clrtoeol     :: proc() -> c.int ---
  clear        :: proc() -> c.int ---
  wclear       :: proc(w: ^WINDOW) -> c.int ---
  box          :: proc(w: ^WINDOW, o1, o2: c.char) -> c.int ---
  border       :: proc(p1, p2, p3, p4, p5, p6, p7, p8: c.char) -> c.int ---
  wborder      :: proc(w: ^WINDOW, p1, p2, p3, p4, p5, p6, p7, p8: c.char) -> c.int ---
  attron       :: proc(atr: c.int) -> c.int ---
  attroff      :: proc(atr: c.int) -> c.int ---
  mvprintw     :: proc(y, x: c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
  mvwprintw    :: proc(w: ^WINDOW, y, x: c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
  start_color  :: proc() -> c.int ---
  init_pair    :: proc(color_index: c.int, front: c.int, back: c.int) -> c.int ---
  move         :: proc(y, x: c.int) -> c.int ---
  wmove        :: proc(w: ^WINDOW, y, x: c.int) -> c.int ---
  mvwaddch     :: proc(w: ^WINDOW, y, x: c.int, ch: c.char) -> c.int ---
  refresh      :: proc() -> c.int ---
  keypad       :: proc(w: ^WINDOW, b: bool) -> c.int ---
}

KEY_F  :: #force_inline proc(f: int) -> int {
  return KEY_F0 + f
}

//refresh :: #force_inline proc() -> c.int { return wrefresh(stdscr) }
wborder_wrapper :: #force_inline proc(w: ^WINDOW, p: c.char) -> c.int {
  return wborder(w, p, p, p, p, p, p, p, p)
}
