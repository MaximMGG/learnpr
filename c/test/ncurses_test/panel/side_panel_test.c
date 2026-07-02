#include <ncurses.h>
#include <panel.h>
#include <cstdext/core.h>
#include <unistd.h>

WINDOW *side_window;
PANEL *side_panel;
str side_msg = "You press %c letter";
#define WIDTH 40
#define HEIGHT 5


void initWindow() {
  initscr();
  noecho();
  cbreak();
  keypad(stdscr, true);

  side_window = newwin(HEIGHT, WIDTH, 0, COLS - WIDTH);
  box(side_window, 0, 0);
  side_panel = new_panel(side_window);
  hide_panel(side_panel);
  update_panels();
  doupdate();
  refresh();

}

void shutdownWindow() {
  del_panel(side_panel);
  delwin(side_window);
  endwin();
}

void showMsg(i8 c) {
  show_panel(side_panel);
  update_panels();
  doupdate();

  mvwprintw(side_window, 1, 1, side_msg, c);
  update_panels();
  doupdate();
  sleep(3);
  
  hide_panel(side_panel);
  update_panels();
  doupdate();
}

int main() {
  initWindow();
  i32 c;

  while((c = getch()) != KEY_F(1)) {
    showMsg(c);
  }
  shutdownWindow();
  return 0;
}
