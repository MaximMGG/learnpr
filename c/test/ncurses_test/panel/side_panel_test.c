#include <ncurses.h>
#include <panel.h>
#include <cstdext/core.h>
#include <unistd.h>
#include <pthread.h>

WINDOW *side_window;
PANEL *side_panel;
str side_msg = "You press %c letter";
#define WIDTH 40
#define HEIGHT 5
pthread_mutex_t msg_m;



void initWindow() {
  pthread_mutex_init(&msg_m, null);
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
  pthread_mutex_destroy(&msg_m);
}

ptr showMsgHelper(ptr p) {
  pthread_mutex_lock(&msg_m);
  i8 c = *cast(i8 *, p);
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
  DEALLOC(p);
  pthread_mutex_unlock(&msg_m);
  return null;
}

void showMsg(i8 c) {
  pthread_t w;
  i8 *p = ALLOC(1);
  *p = c;
  pthread_create(&w, null, showMsgHelper, p);
  pthread_detach(w);
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
