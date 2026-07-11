package text_edit

import "core:fmt"
import "core:c/libc"
import "core:sys/posix"
import "core:sys/linux"


WinSize :: struct {
		ws_row, ws_col, ws_xpixel, ws_ypixel: i32
}

EditorConfig :: struct {
		orig_termios: posix.termios,
		cx, cy: i32,
		ws: WinSize
}

E: EditorConfig = {cx = 1, cy = 1}

CODE_CLEAR_SCREEN        : string : "\x1b[2J"
CODE_CURSOR_DEFAULT_POS  : string : "\x1b[H"
CODE_MOVE_CURSOR         : string : "\x1b[%d;%dH"
CODE_HIDE_CURSOR         : string : "\x1b[?25l"
CODE_SHOW_CURSOR         : string : "\x1b[?25h"



editor_exit :: proc "c" (s: cstring) -> ! {
  libc.perror(s)
  libc.exit(libc.EXIT_FAILURE)
}


disable_raw_mode ::  proc "c" () {
  if posix.tcsetattr(posix.STDIN_FILENO, .TCSAFLUSH, &E.orig_termios) == .FAIL {
    editor_exit("tcsetattr")
  }
}

enable_raw_mode :: proc() {
  if posix.tcgetattr(posix.STDIN_FILENO, &E.orig_termios) == .FAIL {
    editor_exit("tcgetattr")
  }
  libc.atexit(disable_raw_mode)

  raw: posix.termios = E.orig_termios
  posix.tcgetattr(posix.STDIN_FILENO, &raw)
  raw.c_iflag -= {.IXON, .ICRNL, .BRKINT, .ISTRIP, .INPCK}
  raw.c_oflag -= {.OPOST}
  raw.c_cflag += {.CS8}
  raw.c_lflag -= {.ECHO, .ICANON, .ISIG, .IEXTEN}

  raw.c_cc[.VMIN] = 0
  raw.c_cc[.VTIME] = 1

  if posix.tcsetattr(posix.STDIN_FILENO, .TCSAFLUSH, &raw) == .FAIL {
    editor_exit("tcsetattr")
  }
}

editor_init :: proc() {
		enable_raw_mode()
		ws: WinSize
		linux.ioctl(posix.STDOUT_FILENO, linux.TIOCGWINSZ, cast(uintptr)&ws)
		editor_run()
}


editor_refresh :: proc() {
		if posix.write(posix.STDOUT_FILENO, raw_data(CODE_CLEAR_SCREEN), len(CODE_CLEAR_SCREEN)) != len(CODE_CLEAR_SCREEN) {
				editor_exit("write CODE_CLEAR_SCREEN")
		}
		buf: [64]byte
		cursor_pos := fmt.bprintf(buf[:], CODE_MOVE_CURSOR, E.cy, E.cx)
		if posix.write(posix.STDOUT_FILENO, raw_data(cursor_pos), len(cursor_pos)) != len(cursor_pos) {
				editor_exit("write CODE_MOVE_CUROSR")
		}
}

editor_read_key :: proc() -> (c: byte) {
		for posix.read(posix.STDIN_FILENO, &c, 1) != 1 {
		}
		return
}

editor_run :: proc() {
		editor_refresh()
		for {
				c := editor_read_key()

				switch c {
				case 'j':
						E.cy = E.cy + 1 if E.cy < E.ws.ws_row else E.cy
				case 'k':
						E.cy = E.cy - 1 if E.cy > 1 else E.cy
				case 'h':
						E.cx = E.cx - 1 if E.cx > 1 else E.cx
				case 'l':
						E.cx = E.cx + 1 if E.cx < E.ws.ws_col else E.cx
				case 'q':
						return
				}
				editor_refresh()
		}
}

main :: proc() { 
		editor_init()
		fmt.printf("Win size is %d %d", E.ws.ws_row, E.ws.ws_col)
		libc.exit(libc.EXIT_SUCCESS)
}
