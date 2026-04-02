#ifndef WINDOW_H
#define WINDOW_H
#include "token.h"
#include "database.h"
#include <cstdext/container/list.h>
#include <cstdext/io/json.h>
#include <ncurses.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>

typedef struct {
  list *tokens;
  WINDOW *w;
  list *errors;
  json_obj *config;
  str db_name;
  str user_name;
  str user_password;
  str system_user;
  map *token_ralation;
} Window;

Window *windowCreate();
void windowAddToken(Window *w, Database *db, str token_name, i32 id);
void windowRemoveToken(Window *w, str token_name);
void windowDestroy(Window *w);
void windowDraw(Window *w);
void windowRequest(Window *w);
void windowParseConfig(Window *w);
void windowSetTokens(Window *w, Database *db);
str windowGetInput(Window *w, str header);

#endif //WINDOW_H
