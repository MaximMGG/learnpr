#ifndef WINDOW_H
#define WINDOW_H
#include "token.h"
#include <cstdext/container/list.h>
#include <cstdext/io/json.h>
#include <ncurses.h>

typedef struct {
  list *tokens;
  WINDOW *w;
  list *errors;
  json_obj *config;
  //bool config_change;
} Window;

Window *windowCreate();
void windowAddToken(Window *w, str token_name);
void windowRemoveToken(Window *w, str token_name);
void windowDestroy(Window *w);
void windowDraw(Window *w);
void windowRequest(Window *w);
void windowParseConfig(Window *w);
str windowGetInput(Window *w);

#endif //WINDOW_H
