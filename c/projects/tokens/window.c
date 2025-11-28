#include "window.h"



Window *windowCreate() {
  Window *window = make(Window);
  WINDOW *w = initscr();
  window->w = w;
  window->tokens = list_create(PTR);
  raw();
  noecho();
  keypad(w, true);
  refresh();
  return window;
}

void windowAddToken(Window *w, Token *t) {
  list_append(w->tokens, t);
}

void windowRemoveToken(Window *w, i32 index) {
  list_remove(w->tokens, index);
}

#define WINDOW_DRAW_TIKER_PLATE   \
    "%-30s %-30s %-30s %-30s", "Symbol", "Price", "Volume" , "Test"

#define WINDOW_DRAW_TIKER_FMT     \
  "%-30s %-30lf %-30lf %-30s"


void windowDraw(Window *w) {
  clear();
  i32 index = 1;
  mvprintw(index, 1, WINDOW_DRAW_TIKER_PLATE);
  index++;
  for(i32 i = 0; i < w->tokens->len; i++) {
    Token *t = list_get(w->tokens, i);
    mvprintw(index, 1, WINDOW_DRAW_TIKER_FMT, t->ticker->symbol, t->ticker->lastPrice, t->ticker->volume, "-test-");
    index++;
  }
  refresh();
}

void windowDestroy(Window *w) {
  endwin();
  for(i32 i = 0; i < w->tokens->len; i++) {
    tokenDestroy(list_get(w->tokens, i));
  }
  list_destroy(w->tokens);
  dealloc(w);
}
