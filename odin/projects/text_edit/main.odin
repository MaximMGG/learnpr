package text_edit


import "core:fmt"
import "core:c/libc"
import "core:sys/posix"

orig_termios: posix.termios


disable_raw_mode ::  proc "cdecl" () {
  posix.tcsetattr(posix.STDIN_FILENO, .TCSAFLUSH, &orig_termios)
}

enable_raw_mode :: proc() {

  posix.tcgetattr(posix.STDIN_FILENO, &orig_termios)
  libc.atexit(disable_raw_mode)

  raw: posix.termios = orig_termios
  posix.tcgetattr(posix.STDIN_FILENO, &raw)
  raw.c_lflag -= {.ECHO, .ICANON}
  posix.tcsetattr(posix.STDIN_FILENO, .TCSAFLUSH, &raw)
}



main :: proc() { 
  enable_raw_mode()

  c: [1]byte

  for posix.read(posix.STDIN_FILENO, raw_data(c[:]), 1) == 1 && c[0] != 'q' {
    if libc.iscntrl(i32(c[0])) == 1 {
      fmt.printf("%d\n", i32(c[0]))
    } else {
      fmt.printf("%d ('%c')\n", i32(c[0]), c[0])
    }
  }

}
