#include <ncurses.h>


int main() {

  initscr();
  raw();
  noecho();
  keypad(stdscr, true);
  refresh();


  int ch;
  while(ch != 'q') {
    ch = getch();
    mvprintw(2, 2, "%d", ch);
    refresh();
  }

  endwin();
  return 0;
}
