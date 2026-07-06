#include <unistd.h>
#include <termios.h> // for terminal attributes
#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
#include <errno.h>
#include <cstdext/core.h>


struct termios orig_termios;

void die(const i8 *s) {
  perror(s);
  exit(EXIT_FAILURE);
}

void disableRawMode() {
  if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios) == -1) {
    die("tcsetattr");
  }
}

void enableRawMode() {
  if (tcgetattr(STDIN_FILENO, &orig_termios) == -1) // get attributes of STDIN_FILENO, write to struct termios
    die("tcgetattr");
  atexit(disableRawMode); //this fuction registred function the will be call on exit call

  struct termios raw = orig_termios;

  raw.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
  //IXON disable Ctrl-s and Ctrl-q XON enable it
  //ICRNL disable Ctrl-M
  //BRKINT is a break condition well cause a SIGINT signal to be sen to the
  //program, like pressing Ctrl-C
  //INPCK enables parity checking, which doesn't seem to apply to modern
  //terminal emulators
  //ISTRIP causes the 8th bit of each input byte to be stripped, meaning it will
  //setit to 0. This is probably already truned off
  raw.c_oflag &= ~(OPOST);
  //OPOST turn off all output processing features
  raw.c_cflag |= (CS8);
  //CS is not al falg, it is a bit mask with multiple bits, which we set using
  //the OR (|) It sets the character size (CS) to 8 bits per byte.
  raw.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG); //trun off printing latters while typing it in terminal
  //ICANON flag means the we will finally be reading input byte-by-byte, instead
  //of line-by-line
  //ISIG is telling to ignore Ctrl-z and Ctrl-c codes for terminating app
  //IEXTEN disable Ctrl-v command
  raw.c_cc[VMIN] = 0;
  //VMIN values sets the minimum number of bytes of input needed before read()
  //can return. We set to 0 so that read() returns as soon as there is any input
  //to be read
  raw.c_cc[VTIME] = 1;
  //VTIME value sets the maximum amount of time to wait before read() returns.
  //we set it to 1/10 of a second, or 100 millisconds. 
  //If read() times out, it will return 0, which makes sense because its usual
  //return value is the number of bytes read.

  if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw) == -1) //apply attribute from @raw to terminal input STDIN_FILENO
    die("tcsetattr");
  //TCSAFLUSH waits for all pending output to be written to the terminal, and
  //also discards any input taht hasn't been read.
  
}


i32 main() {
  enableRawMode();

  while(true) {
    i8 c = '\0';
    if (read(STDIN_FILENO, &c, 1) == -1 && errno != EAGAIN) die("read");
    if (iscntrl(c)) { // iscntrl tests whether a char is control character.
                      // contral characters are nonprintable chars that we don't want to print to the screen. ACCII codes 0-31 and 127
                      // Ctrl-s means thet you've asked program to stop sending
                      // you output
                      // Ctrl-z tell program to suspend to the background
                      // Ctrl-c is SIGINT for terminatin terminal application
                      // Ctrl-q is used or software flow control
      printf("%d\r\n", c);
    } else {
      printf("%d ('%c')\r\n", c, c);
    }
    if (c == 'q') break;
  }
  return 0;
}



