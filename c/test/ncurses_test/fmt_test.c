#include <stdio.h>
#include <ncurses.h>


#define TOKEN_FMT_PLATE   \
    "%-30s %-30s %-30s %-30s", "Symbol", "Price", "Volume", "Test"

#define TOKEN_FMT \
    "%-30s %-30lf %-30lf %-30s"


int main() {
  initscr();
  raw();
  noecho();
  keypad(stdscr, true);
  refresh();

  int ch = 0;
  while(ch != 'q') {
    clear();
    mvprintw(1, 1, TOKEN_FMT_PLATE);
    mvprintw(2, 1, TOKEN_FMT, "BTCUSDT", 0.0, 0.0, "--test--");
    refresh();
    ch = getch();
  }

  endwin();
  return 0;
}
