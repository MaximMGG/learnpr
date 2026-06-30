#include <cstdext/core.h>
#include <ncurses.h>
#include <menu.h>
#include <string.h>


char *choices[] = {
  "Choice 1",
  "Choice 2",
  "Choice 3",
  "Choice 4",
  "Exit",
  null
};

void print_in_middle(WINDOW *win, i32 starty, i32 startx, i32 width, str label, chtype color);

i32 main() {
  ITEM **items;
  i32 c;
  MENU *menu;
  WINDOW *menu_win;
  i32 arr_len = 6;

  initscr();
  start_color();
  cbreak();
  noecho();
  keypad(stdscr, true);
  init_pair(1, COLOR_RED, COLOR_BLACK);

  items = ALLOCZERO(sizeof(ITEM *) * arr_len);
  for(i32 i = 0; i < arr_len; i++) {
    items[i] = new_item(choices[i], choices[i]);
  }
  menu = new_menu(items);

  menu_win = newwin(10, 40, 4, 4);
  keypad(menu_win, true);

  set_menu_win(menu, menu_win);
  set_menu_sub(menu, derwin(menu_win, 6, 38, 3, 1));

  set_menu_mark(menu, " * ");

  box(menu_win, 0, 0);
  print_in_middle(menu_win, 1, 0, 40, "My Menu", COLOR_PAIR(1));
  mvwaddch(menu_win, 2, 0, ACS_LTEE);
  mvwhline(menu_win, 2, 1, ACS_HLINE, 38);
  mvwaddch(menu_win, 2, 39, ACS_RTEE);
  mvprintw(LINES - 2, 0, "F1 to exit");
  refresh();

  post_menu(menu);
  wrefresh(menu_win);

  while((c = wgetch(menu_win)) != KEY_F(1)) {
    switch(c) {
    case KEY_DOWN:
      menu_driver(menu, REQ_DOWN_ITEM);
      break;
    case KEY_UP:
      menu_driver(menu, REQ_UP_ITEM);
      break;
    }
    wrefresh(menu_win);
  }

  unpost_menu(menu);
  free_menu(menu);
  for(i32 i = 0; i < arr_len; i++) {
    free_item(items[i]);
  }
  endwin();

  return 0;
}



void print_in_middle(WINDOW *win, i32 starty, i32 startx, i32 width, str label, chtype color) {
  i32 length, x, y;
  f32 temp;

  if (!win) {
    win = stdscr;
  }
  getyx(win, y, x);
  if (startx) x = startx;
  if (starty) y = starty;
  if (!width) width = 80;

  length = strlen(label);
  temp = cast(f32, (width - length) / 2);
  x = startx + cast(i32, temp);
  wattron(win, color);
  mvwprintw(win, y, x, "%s", label);
  wattroff(win, color);
  refresh();
}
