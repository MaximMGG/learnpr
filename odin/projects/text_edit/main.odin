package text_edit


import "core:fmt"
import "core:c/libc"
import "core:sys/posix"


orig_termios: posix.termios

CLEAR_SCREEN_CODE : string : "\x1b[2J"




die :: proc "c" (s: cstring) -> ! {
  libc.perror(s)
  libc.exit(libc.EXIT_FAILURE)
}


disable_raw_mode ::  proc "c" () {
  if posix.tcsetattr(posix.STDIN_FILENO, .TCSAFLUSH, &orig_termios) == .FAIL {
    die("tcsetattr")
  }
}

enable_raw_mode :: proc() {

  if posix.tcgetattr(posix.STDIN_FILENO, &orig_termios) == .FAIL {
    die("tcgetattr")
  }
  libc.atexit(disable_raw_mode)

  raw: posix.termios = orig_termios
  posix.tcgetattr(posix.STDIN_FILENO, &raw)
  raw.c_iflag -= {.IXON, .ICRNL, .BRKINT, .ISTRIP, .INPCK}
  raw.c_oflag -= {.OPOST}
  raw.c_cflag += {.CS8}
  raw.c_lflag -= {.ECHO, .ICANON, .ISIG, .IEXTEN}

  raw.c_cc[.VMIN] = 0
  raw.c_cc[.VTIME] = 1


  if posix.tcsetattr(posix.STDIN_FILENO, .TCSAFLUSH, &raw) == .FAIL {
    die("tcsetattr")
  }
}

editor_read_key :: #force_inline proc() -> byte {
  c: byte
  for nread := posix.read(posix.STDIN_FILENO, &c, 1); nread != 1;  nread =
    posix.read(posix.STDIN_FILENO, &c, 1) {
    if nread == -1 {die("read")}
  }
  return c
}

editor_process_keypress :: proc() {
  c := editor_read_key()
  fmt.printf("%d ('%c')\r\n", i32(c), c)

  switch(c) {
  case CTRL_KEY('q'):
    libc.exit(0)
  }
}

CTRL_KEY :: #force_inline proc(k: byte) -> byte {
  return k & 0x1f
}

editor_refresh_screen :: proc() {
  posix.write(posix.STDOUT_FILENO, raw_data(CLEAR_SCREEN_CODE[:]), len(CLEAR_SCREEN_CODE))
}

main :: proc() { 
  enable_raw_mode()

  for {
    editor_refresh_screen()
    editor_process_keypress()
  }
}
