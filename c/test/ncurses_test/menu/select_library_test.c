#include <cstdext/core.h>
#include <ncurses.h>
#include <panel.h>
#include <menu.h>
#include <unistd.h>
#include <string.h>
#include <pthread.h>

#define REG_MENU_COLOR 1
#define SELECT_LIB_MENU_COLOR 2
#define POS_CURSOR_COLOR 3

pthread_mutex_t print_m;


ptr __print_info(ptr infomsg) {
  pthread_mutex_lock(&print_m);
  WINDOW *info = newwin(5, strlen(infomsg) + 2, 5, COLS - strlen(infomsg) - 2);
  box(info, 0, 0);
  mvwprintw(info, 1, 1, "%s", cast(str, infomsg));
  wrefresh(info);

  sleep(3);

  wborder(info, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
  wclear(info);
  wrefresh(info);
  delwin(info);
  DEALLOC(infomsg);
  pthread_mutex_unlock(&print_m);
  return null;
}


void print_info(str infomsg) {
  pthread_t w;
  pthread_create(&w, null, __print_info, strCopy(infomsg));
  pthread_detach(w);
}





void selectLibMenu(DA_ARR(str) libs) {
  pthread_mutex_init(&print_m, null);
  str exit_msg = strCopy("Exit");
  WINDOW *sel_win = newwin(DA_LEN(libs) + 2, 30, LINES / 4, COLS / 4);
  PANEL *sel_win_panel = new_panel(sel_win);
  box(sel_win, 0, 0);
  wrefresh(sel_win);
  update_panels();
  doupdate();

  ITEM **items = ALLOCZERO(sizeof(ITEM *) * (DA_LEN(libs) + 2));
  for(i32 i = 0; i < DA_LEN(libs); i++) {
    items[i] = new_item(libs[i], null);
  }
  items[DA_LEN(libs)] = new_item(exit_msg, null);
  items[DA_LEN(libs) + 1] = new_item(null, null);

  MENU *menu = new_menu(items);
  //menu_opts_off(menu, O_ONEVALUE);

  set_menu_win(menu, sel_win);
  set_menu_sub(menu, derwin(sel_win, DA_LEN(libs) - 0, 28, 1, 1));
  set_menu_format(menu, 8, 1);
  set_menu_mark(menu, "> ");

  post_menu(menu);
  wrefresh(sel_win);

  i32 c;
  while((c = getch()) != KEY_F(1)) {
    switch(c) {
      case KEY_DOWN:
        menu_driver(menu, REQ_DOWN_ITEM);
        break;
      case KEY_UP:
        menu_driver(menu, REQ_UP_ITEM);
        break;
      case 10: {
        ITEM *cur = current_item(menu);
        if (streql("Exit", item_name(cur))) {
          goto SELECT_END;
        } else {
          print_info(cast(str, item_name(cur)));
        }
      }
    }
    wrefresh(sel_win);
  }

SELECT_END:

  wborder(sel_win, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
  wrefresh(sel_win);

  unpost_menu(menu);

  for(i32 i = 0; i < DA_LEN(libs) + 2; i++) {
    free_item(items[i]);
  }
  free_menu(menu);
  del_panel(sel_win_panel);
  delwin(sel_win);
  DEALLOC(exit_msg);
  pthread_mutex_destroy(&print_m);
}

str main_menu[] = {
  "Create Lib",
  "Select Lib",
  "Delete Lib",
  "Exit"
};



int main() {

  str *libs = daCreate(str);
  for(i32 i = 0; i < 8; i++) {
    daAppend(libs, strCreateFmt("Library %d", i + 1));
  }

  initscr();
  start_color();
  init_pair(REG_MENU_COLOR,        COLOR_WHITE, COLOR_BLACK);
  init_pair(SELECT_LIB_MENU_COLOR, COLOR_CYAN,  COLOR_BLACK);
  init_pair(POS_CURSOR_COLOR,      COLOR_BLACK, COLOR_WHITE);
  noecho();
  cbreak();
  keypad(stdscr, true);
  refresh();

  i32 c = 0;
  i32 pos = 1;

  while(true) {
    for(i32 i = 1; i < 5; i++) {
      if (i == pos) {
        attron(COLOR_PAIR(POS_CURSOR_COLOR));
        mvprintw(i, 1, "> %s", main_menu[i - 1]);
        attroff(COLOR_PAIR(POS_CURSOR_COLOR));
      } else {
        attron(COLOR_PAIR(REG_MENU_COLOR));
        mvprintw(i, 1, "  %s", main_menu[i - 1]);
        attroff(COLOR_PAIR(REG_MENU_COLOR));
      }
    }
    refresh();
    c = getch();
    switch(c) {
      case KEY_DOWN:
      case 'j': {
        if (pos < 4) {
          pos++;
        }
        break;
      }
      case KEY_UP:
      case 'k': {
        if (pos > 1) {
          pos--;
        }
        break;
      }
      case 10: {
        switch(pos) {
          case 1: break;
          case 2: {
            selectLibMenu(libs);
          }
          case 3: break;
          case 4: goto END_OF_CURSE;
        }
      }
    }
  }


  for(i32 i = 0; i < DA_LEN(libs); i++) {
    DEALLOC(libs[i]);
  }
  daDestroy(libs);
END_OF_CURSE:

  endwin();
  return 0;
}
