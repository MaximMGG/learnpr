#include <stdio.h>
#include <ncurses.h>

#define TOKEN_HEADER "%-30s %-30s %-30s %-30s"

#define TOKEN_FMT \
    "%-30s %-30lf %-30lf %-30s"


void run() {
  int ch;
  int i = 1;
  int j = 1;
  while((ch = getch()) != 'q') {
    i = 1;
    j = 1;
    clear();
    mvprintw(i, j, TOKEN_HEADER, "TOKEN", "PRICE", "VOLUME", "-TEST-");
    i++;
    mvprintw(i, j, TOKEN_FMT, "BTCUSDT", 0.123123, 1.2323, "-test-");
    refresh();
  }
}



int main() {
  initscr();
  raw();
  noecho();
  keypad(stdscr, true);
  refresh();
  timeout(50);

  run();

  endwin();
  return 0;
}
