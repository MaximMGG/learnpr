package text_edit

import "core:c"
import "core:sys/linux"
import "core:os"
import "core:io"

foreign import lib "system:c"


tcflag_t :: c.int
Termios :: struct {
    c_iflag, c_oflag, c_cflag, c_lflag: tcflag_t,
    c_line:                             c.int,
    c_cc:                               [32]c.int,
    i_speed, c_ospeed:                  c.int,
}

ECHO :: 1 << 1
TCSAFLUS :: 2



@(default_calling_convention="c")
foreign lib {
	// struct termios
	//   {
	//     tcflag_t c_iflag;		/* input mode flags */
	//     tcflag_t c_oflag;		/* output mode flags */
	//     tcflag_t c_cflag;		/* control mode flags */
	//     tcflag_t c_lflag;		/* local mode flags */
	//     cc_t c_line;			/* line discipline */
	//     cc_t c_cc[NCCS];		/* control characters */
	//     speed_t c_ispeed;		/* input speed */
	//     speed_t c_ospeed;		/* output speed */
	// #define _HAVE_STRUCT_TERMIOS_C_ISPEED 1
	// #define _HAVE_STRUCT_TERMIOS_C_OSPEED 1
	// extern int tcgetattr (int __fd, struct termios *__termios_p) __THROW;

	/* Set the state of FD to *TERMIOS_P.
   Values for OPTIONAL_ACTIONS (TCSA*) are in <bits/termios.h>.  */
	// extern int tcsetattr (int __fd, int __optional_actions,
	// 		      const struct termios *__termios_p) __THROW;


	tcgetattr :: proc(fd: c.int, termios_p: ^Termios) -> c.int ---
	tcsetattr :: proc(fd: c.int, optional_actions: c.int, termios_p: ^Termios) -> c.int ---

}

enable_raw_mode :: proc() {
    raw: Termios
    tcgetattr(c.int(linux.STDIN_FILENO), &raw)

    raw.c_lflag &= (ECHO ~ 0xFF)

    tcsetattr(c.int(linux.STDIN_FILENO), TCSAFLUS, &raw)
}


main :: proc() {
    enable_raw_mode()

    for {
        buf: [1]u8
        c, c_ok := os.read(os.stdin, buf[:])
        if c_ok != nil {
            break
        }
        if buf[0] == 'q' {
            break
        }
    }
}
