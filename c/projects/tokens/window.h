#ifndef WINDOW_H
#define WINDOW_H
#include "token.h"
#include <cstdext/container/list.h>
#include <ncurses.h>

typedef struct {
  list *tokens;
  WINDOW *w;
  list *errors;
} Window;

Window *windowCreate();
void windowAddToken(Window *w, str token_name);
void windowRemoveToken(Window *w, str token_name);
void windowDestroy(Window *w);
void windowDraw(Window *w);
void windowRequest(Window *w);

#endif //WINDOW_H
