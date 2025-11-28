#ifndef WINDOW_H
#define WINDOW_H
#include "token.h"
#include <cstdext/container/list.h>
#include <ncurses.h>

typedef struct {
  list *tokens;
  WINDOW *w;
} Window;

Window *windowCreate();
void windowAddToken(Window *w, Token *t);
void windowRemoveToken(Window *w, i32 index);
void windowDestroy(Window *w);
void windowDraw(Window *w);

#endif //WINDOW_H
