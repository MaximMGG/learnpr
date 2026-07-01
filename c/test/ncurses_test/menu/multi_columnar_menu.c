#include <cstdext/core.h>
#include <ncurses.h>
#include <menu.h>
#include <string.h>

char *choices[] = {"Choice 1", "Choice 2", "Choice 3", "Choice 4",
                   "Choice 5", "Choice 6", "Choice 7", "Choice 8",
                   "Choice 9", "Choice 10","Choice 11", "Choice 12", "Choice 13", "Choice 14",
                   "Choice 15", "Choice 16", "Choice 17", "Choice 18",
                   "Choice 19", "Choice 20", "Exit", null};

void print_in_middle(WINDOW *win, i32 starty, i32 startx, i32 width, str label, chtype color);

i32 main() {
  ITEM **items;
  i32 c;
  MENU *menu;
  WINDOW *menu_win;
  i32 arr_len = 22;

  initscr();
  start_color();
  cbreak();
  noecho();
  keypad(stdscr, true);
  init_pair(1, COLOR_RED, COLOR_BLACK);
  init_pair(2, COLOR_CYAN, COLOR_BLACK);

  items = ALLOCZERO(sizeof(ITEM *) * arr_len);
  for(i32 i = 0; i < arr_len; i++) {
    items[i] = new_item(choices[i], choices[i]);
    //items[i] = new_item(choices[i], null); 
  }
  menu = new_menu(items);

  //Set menu option not to show the description
  menu_opts_off(menu, O_SHOWDESC);
  //menu_opts_off(menu, O_ONEVALUE);

  menu_win = newwin(10, 70, 4, 4);
  keypad(menu_win, true);

  set_menu_win(menu, menu_win);
  set_menu_sub(menu, derwin(menu_win, 6, 68, 3, 1));
  set_menu_format(menu, 5, 3);

  set_menu_mark(menu, " * ");

  box(menu_win, 0, 0);
  
  attron(COLOR_PAIR(2));
  mvprintw(LINES - 3, 0, "Use PageUp adn PAgeDown to scroll or fown or up a page of items");
  mvprintw(LINES - 2, 0, "Arrow Kyes to naviage (F1 to exit)");
  attroff(COLOR_PAIR(2));
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
    case KEY_LEFT:
      menu_driver(menu, REQ_LEFT_ITEM);
      break;
    case KEY_RIGHT:
      menu_driver(menu, REQ_RIGHT_ITEM);
      break;
    case KEY_NPAGE:
      menu_driver(menu, REQ_SCR_DPAGE);
      break;
    case KEY_PPAGE:
      menu_driver(menu, REQ_SCR_UPAGE);
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
