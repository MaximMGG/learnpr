#include "window.h"
#include <cstdext/container/list.h>
#include <stdarg.h>

static void windowSetUserConfig(Window *w, str config_path) {
  json_obj *obj = json_create_obj(null);
  json_add_to_obj(obj, json_create_str("dbname", ""));
  json_add_to_obj(obj, json_create_str("user_name", ""));
  json_add_to_obj(obj, json_create_str("password", ""));
  json_write_to_file(obj, config_path);
  json_destroy_obj(obj);
}

static void windowCheckConfigExists(Window *w) {
  i8 dir_access_buf[256] = {0};
  sprintf(dir_access_buf, "/home/%s/.config/token", w->system_user);
  if (access(dir_access_buf, F_OK) != 0) {
    mkdir(dir_access_buf, 0777);
  }
  str config_access = str_create_fmt("%s/config.json", dir_access_buf);
  if (access(config_access, F_OK) != 0) {
    i32 fd = open(config_access, O_CREAT | O_RDWR, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP); 
    if (fd <= 0) {
      log(ERROR, "Cant create file %s", config_access);
      dealloc(config_access);
      return;
    }
    close(fd);
    windowSetUserConfig(w, config_access);
  }
  dealloc(config_access);
}

Window *windowCreate() {
  Window *window = make(Window);
  WINDOW *w = initscr();
  window->w = w;
  window->tokens = list_create(PTR);
  window->errors = list_create(STR);
  window->system_user = getenv("USERNAME");
  windowCheckConfigExists(window);
  raw();
  noecho();
  keypad(w, true);
  refresh();
  log(INFO, "Create window");
  return window;
}

str windowGetInput(Window *w, str header) {
  WINDOW *input = newwin(3, COLS / 1.5, LINES - (LINES / 8), COLS / 8);
  box(input, 0, 0);
  mvwprintw(input, 0, (COLS / 1.5) / 2, "%s", header);
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
  log(INFO, "Input window done");
  return str_copy(in);
}

void windowAddToken(Window *w, Database *db, str token_name, i32 id) {
  Token *t;
  if (id != -1) {
    i32 token_id = databaseAddToken(db, token_name);
    t = tokenCreate(token_name, token_id);
  } else {
    t = tokenCreate(token_name, id);
  }
  list_append(w->tokens, t);
  log(INFO, "windowAddToken done");
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
    log(ERROR, "do not find token: %s", token_name);
  }
  log(INFO, "Remove token: %s", token_name);
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
  log(INFO, "Window draw");
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
  log(INFO, "Window destroy");
}

void windowRequest(Window *w) {
  for(i32 i = 0; i < w->tokens->len; i++) {
    tokenRequest(list_get(w->tokens, i));
  }
  log(INFO, "window request done");
}

void windowParseConfig(Window *w) {
  log(INFO, "window parse config done");
  str config = str_create_fmt("/home/%s/.config/token/config.json", w->system_user);
  json_obj *obj = json_connection(config);
  dealloc(config);
  if (obj == null) {
    log(ERROR, "open config.json error");
    return;
  }
  
  json_obj *dbname = json_get_obj(obj, "dbname");
  w->db_name = str_copy(dbname->val.str_val);
  if (strlen(w->db_name) == 0) {
    str db_name = windowGetInput(w, "Enter db name");
    dealloc(w->db_name);
    w->db_name = db_name;
  }
  json_obj *user_name = json_get_obj(obj, "user_name");
  w->user_name = str_copy(user_name->val.str_val);
  if (strlen(w->user_name) == 0) {
    str user_name = windowGetInput(w, "Enter user name");
    dealloc(w->user_name);
    w->user_name = user_name;
  }
  json_obj *password = json_get_obj(obj, "password");
  w->user_password = str_copy(password->val.str_val);
  if (strlen(w->user_password) == 0) {
    str user_password = windowGetInput(w, "Enter user password");
    dealloc(w->user_password);
    w->user_password = user_password;
  }
  json_connection_close(obj);
  log(INFO, "window parse config done");
}

void windowSetTokens(Window *w, Database *db) {
  w->token_ralation = databaseGetTokenRelation(db);
  iterator *it = map_iterator(w->token_ralation);
  KV kv = map_it_next(it);
  while(kv.key != null) {
    windowAddToken(w, db, kv.key, *(i32 *)kv.val);
    kv = map_it_next(it);
  }
}
