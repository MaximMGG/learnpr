#include "window.h"
#include <stdarg.h>

Window *windowCreate() {
  Window *window = make(Window);
  WINDOW *w = initscr();
  window->w = w;
  window->tokens = list_create(PTR);
  window->errors = list_create(STR);
  raw();
  noecho();
  keypad(w, true);
  refresh();
  return window;
}

str windowGetInput(Window *w) {
  WINDOW *input = newwin(3, COLS / 1.5, LINES - (LINES / 8), COLS / 8);
  box(input, 0, 0);
  mvwprintw(input, 0, (COLS / 1.5) / 2, "Enter here:");
  wrefresh(input);
  wmove(input, 1, 1);
  i32 ch;
  byte in[128] = {0};
  i32 len = 0;
  i32 x = 1;
  bool exit = false;
  while((ch = wgetch(input)) != '\n') {
    if (ch == 27) {
      exit = true;
      break;
    }
    if (ch == 127) {
      if (len != 0) {
        len--;
        in[len] = 0;
        x--;
        mvwaddch(input, 1, x, ' ');
        wmove(input, 1, x);
        wrefresh(input);
        continue;
      }
    }
    mvwaddch(input, 1, x, ch);
    x++;
    in[len++] = ch;
    wrefresh(input);
    if (len == 128) {
      break;
    }
  }
  wborder(input, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
  wrefresh(input);
  delwin(input);
  if (exit) {
    return null;
  }
  return str_copy(in);
}

void windowAddToken(Window *w, str token_name) {
  Token *t = tokenCreate(token_name);
  list_append(w->tokens, t);
}

static void windowErrorSetMsg(Window *w, str fmt, ...) {
  va_list li;
  va_start(li, fmt);
  i8 buf[1024] = {0};
  vsprintf(buf, fmt, li);
  list_append(w->errors, str_copy(buf));
  va_end(li);
}

static void windowErrorClear(Window *w) {
  if (w->errors->len == 0) return;
  for(i32 i = 0; i < w->errors->len; i++) {
    dealloc(list_get(w->errors, i));
  }
  list_clear(w->errors);
}

void windowRemoveToken(Window *w, str token_name) {
  bool removed = false;
  for(i32 i = 0; i < w->tokens->len; i++) {
    Token *tmp = list_get(w->tokens, i);
    if (strcmp(tmp->token_symbol, token_name)) {
      list_remove(w->tokens, i);
      removed = true;
    }
  }
  if (!removed) {
    windowErrorSetMsg(w, "windowRemoveToken => Do not find token: %s", token_name);
  }
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
  i32 err_pos = 10;
  for(i32 i = 0; i < w->errors->len; i++) {
    mvprintw(err_pos, 1, "Error: %s", (str)list_get(w->errors, i));
    err_pos++;
  }
  windowErrorClear(w);
  refresh();
}

void windowDestroy(Window *w) {
  endwin();
  for(i32 i = 0; i < w->tokens->len; i++) {
    tokenDestroy(list_get(w->tokens, i));
  }
  for(i32 i = 0; i < w->errors->len; i++) {
    dealloc(list_get(w->errors, i));
  }
  list_destroy(w->tokens);
  list_destroy(w->errors);
  json_connection_close(w->config);
  dealloc(w);
}

void windowRequest(Window *w) {
  for(i32 i = 0; i < w->tokens->len; i++) {
    tokenRequest(list_get(w->tokens, i));
  }
}

void windowParseConfig(Window *w) {
  json_obj *config = json_connection("./config.json");
  json_obj *tokens = json_get_obj(config, "tokens");
  for(i32 i = 0; i < tokens->arr_len; i++) {
    windowAddToken(w, tokens->arr[i]->val.str_val);
  }
  w->config = config;
}

