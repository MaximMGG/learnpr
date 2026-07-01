#include <cstdext/core.h>
#include <ncurses.h>
#include <menu.h>
#include <string.h>


char *choices[] = {
  "Choice 1",
  "Choice 2",
  "Choice 3",
  "Choice 4",
  "Choice 5",
  "Choice 6",
  "Choice 7",
  "Exit",
  null
};

void print_in_middle(WINDOW *win, i32 starty, i32 startx, i32 width, str label, chtype color);

i32 main() {
  ITEM **items;
  i32 c;
  MENU *menu;
  i32 arr_len = 9;
  ITEM *cur_item;

  initscr();
  start_color();
  cbreak();
  noecho();
  keypad(stdscr, true);
  init_pair(1, COLOR_RED, COLOR_BLACK);
  init_pair(2, COLOR_GREEN, COLOR_BLACK);
  init_pair(3, COLOR_MAGENTA, COLOR_BLACK);


  items = ALLOCZERO(sizeof(ITEM *) * arr_len);
  for(i32 i = 0; i < arr_len; i++) {
    items[i] = new_item(choices[i], choices[i]);
  }
  item_opts_off(items[3], O_SELECTABLE);
  item_opts_off(items[6], O_SELECTABLE);
  
  menu = new_menu(items);
  
  set_menu_fore(menu, COLOR_PAIR(1) | A_REVERSE);
  set_menu_back(menu, COLOR_PAIR(2));
  set_menu_grey(menu, COLOR_PAIR(3));
  
  mvprintw(LINES - 3, 0, "Press <ENTER> to see the option selected");
  mvprintw(LINES - 2, 0, "Up and Down arrow keys to navigate (F1 to Exit)");
  post_menu(menu);
  refresh();

  while((c = getch()) != KEY_F(1)) {
    switch(c) {
    case KEY_DOWN:
      menu_driver(menu, REQ_DOWN_ITEM);
      break;
    case KEY_UP:
      menu_driver(menu, REQ_UP_ITEM);
      break;
    case 10: {
      move(20, 0);
      clrtoeol();
      mvprintw(20, 0, "Item selected is : %s", item_name(current_item(menu)));
      if (streql("Exit", item_name(current_item(menu)))) {
	goto EXIT;
      }
      pos_menu_cursor(menu);
    } break;
    }
  }

 EXIT:

  unpost_menu(menu);

  for(i32 i = 0; i < arr_len; i++) {
    free_item(items[i]);
  }
  free_menu(menu);

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
