#include <unistd.h>
#include <termios.h> // for terminal attributes
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <cstdext/core.h>

#define TEST_EDITOR_VERSION "0.0.1"
#define CTRL_KEY(k) ((k) & 0x1F)
#define REFRESH_SCREEN_CODE "\x1b[2J", 4
#define REPOSITION_CURSORE_CODE "\x1b[H", 3

typedef enum {
  ARROW_LEFT = 1000,
  ARROW_RIGHT,
  ARROW_UP,
  ARROW_DOWN,
} EditorKey;

typedef struct {
  i32 cx, cy;
  i32 s_rows;
  i32 s_cols;
  struct termios orig_termios;

} EditorConfig;

EditorConfig E;


typedef struct {
  i8 *b;
  i32 len;
} abuf;

#define ABUF_INIT {null, 0}

void abAppend(abuf *ab, const i8 *s, i32 len) {
  i8 *new = realloc(ab->b, ab->len + len);

  if (new == null) return;
  memcpy(&new[ab->len], s, len);
  ab->b = new;
  ab->len += len;
}

void abFree(abuf *ab) {
  free(ab->b);
}


void die(const i8 *s) {
  write(STDOUT_FILENO, REFRESH_SCREEN_CODE);
  write(STDOUT_FILENO, REPOSITION_CURSORE_CODE);
  perror(s);
  exit(EXIT_FAILURE);
}

void disableRawMode() {
  if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &E.orig_termios) == -1) {
    die("tcsetattr");
  }
}

void enableRawMode() {
  if (tcgetattr(STDIN_FILENO, &E.orig_termios) == -1) // get attributes of STDIN_FILENO, write to struct termios
    die("tcgetattr");
  atexit(disableRawMode); //this fuction registred function the will be call on exit call

  struct termios raw = E.orig_termios;

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

i32 editorReadKey() {
  i32 nread;
  i8 c;
  while((nread = read(STDIN_FILENO, &c, 1)) != 1) {
    if (nread == -1 && errno != EAGAIN) die("read");
  }

  if (c == '\x1b') {
    i8 seq[3];

    if (read(STDIN_FILENO, &seq[0], 1) != 1) return '\x1b';
    if (read(STDIN_FILENO, &seq[1], 1) != 1) return '\x1b';

    if (seq[0] == '[') {
      switch(seq[1]) {
        case 'A': return ARROW_UP;
        case 'B': return ARROW_DOWN;
        case 'C': return ARROW_RIGHT;
        case 'D': return ARROW_LEFT;
      }
    }
    return '\x1b';
  } else {
    return  c;
  }
}

i32 getCursorPosition(i32 *rows, i32 *cols) {
  i8 buf[32];
  u32 i = 0;
  if (write(STDOUT_FILENO, "\x1b[6b", 4) != 4) return -1;

  printf("\r\n");
  i8 c;
  while(i < sizeof(buf) - 1) {
    if (read(STDIN_FILENO, &buf[i], 1) != 1) break;
    if (buf[i] == 'R') break;
    i++;
  }
  buf[i] = '\0';
  if (buf[0] != '\x1b' || buf[1] != '[') return -1;
  if (scanf(&buf[2], "%d;%d", rows, cols) != 2) return -1;
  return -1;
}

i32 getWindowSize(i32 *rows, i32 *cols) {
  struct winsize ws;

  if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) == -1 || ws.ws_col == 0) {
    if (write(STDOUT_FILENO, "\x1b[999C\x1b[999B", 12) != 12) return -1;
    //ioctl with this code TIOCGWINSZ, write to ws terminal window size
    return getCursorPosition(rows, cols);
  } else {
    *cols = ws.ws_col;
    *rows = ws.ws_row;
    return 0;
  }
}

void editorMoveCursor(i32 key) {
  switch(key) {
    case ARROW_LEFT:
      E.cx--;
      break;
    case ARROW_RIGHT:
      E.cx++;
      break;
    case ARROW_UP:
      E.cy--;
      break;
    case ARROW_DOWN:
      E.cy++;
      break;
  }
}

void editorProcessKeypress() { 
  i32 c = editorReadKey();

  switch(c) {
    case CTRL_KEY('q'):
      write(STDOUT_FILENO, REFRESH_SCREEN_CODE);
      write(STDOUT_FILENO, REPOSITION_CURSORE_CODE);
      exit(0);
      break;
    case ARROW_UP:
    case ARROW_DOWN:
    case ARROW_LEFT:
    case ARROW_RIGHT:
      editorMoveCursor(c);
  }
}

void editorDrawRows(abuf *ab) {
  i32 i = 0;
  for(i = 0; i < E.s_rows; i++) {
    if (i == E.s_rows / 3) {
      byte welcome[80];
      i32 welcomelen = snprintf(welcome, sizeof(welcome), "Test editor -- version  %s", TEST_EDITOR_VERSION);
      if (welcomelen > E.s_cols) welcomelen = E.s_cols;
      i32 padding = (E.s_cols - welcomelen) / 2;
      if (padding) {
        abAppend(ab, "~", 1);
        padding--;
      }
      while(padding--) abAppend(ab, " ", 1);
      abAppend(ab, welcome, welcomelen);
    } else {
      abAppend(ab, "~", 1);
    }
    //write(STDOUT_FILENO, "~\r\n", 3);
    abAppend(ab, "\x1b[K", 3);
    if (i < E.s_rows - 1) {
      abAppend(ab, "\r\n", 2);
      // write(STDOUT_FILENO, "\r\n", 2);
    }
  }
}

void editorRefreshScreen() {
  abuf ab = ABUF_INIT;

  abAppend(&ab, "\x1b[?25l", 6);
  //abAppend(&ab, "\x1b[2J", 4);
  //write(STDOUT_FILENO, REFRESH_SCREEN_CODE); // "\x1b[2J" this is escape
  // sequence to the terminal
  // Here we are using 'J' comand
  // (Erase In Display) to clear the
  // screen
  // arguments for escape sequences comming before command. 
  // In this case the argument is 2, which says to clear the entire screen.
  // <esc>[1J would clear the screen up to the end of the screen. Also 0 is the
  // default argument for 'J', so just <esc>[J be itself would also clear the
  // screen from the cursor to the end

  abAppend(&ab, "\x1b[H", 3);
  // write(STDOUT_FILENO, REPOSITION_CURSORE_CODE);
  //"\x1b[H" is command for cursor position, is takes 2 arguments, for example
  //\x1b[12;33H

  editorDrawRows(&ab);

  byte buf[32];
  snprintf(buf, sizeof(buf), "\x1b[%d;%dH", E.cy + 1, E.cx + 1);
  abAppend(&ab, buf, strlen(buf));
  //write(STDOUT_FILENO, REPOSITION_CURSORE_CODE);
  abAppend(&ab, "\x1b[H", 3);
  abAppend(&ab, "\x1b[?25h", 6);
  write(STDOUT_FILENO, ab.b, ab.len);
  abFree(&ab);
}

void editorInit() {
  E.cx = 0;
  E.cy = 0;
  if (getWindowSize(&E.s_rows, &E.s_cols) == -1) die("getWindowSize");
}


i32 main() {
  enableRawMode();
  editorInit();

  while(true) {
    editorRefreshScreen();
    editorProcessKeypress();
  }
  exit(1);
  return 0;
} 



