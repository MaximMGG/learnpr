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
  WINDOW *menu_win;
  i32 arr_len = 9;

  initscr();
  cbreak();
  noecho();
  keypad(stdscr, true);


  items = ALLOCZERO(sizeof(ITEM *) * arr_len);
  for(i32 i = 0; i < arr_len; i++) {
    items[i] = new_item(choices[i], choices[i]);
  }
  menu = new_menu(items);
  menu_opts_off(menu, O_ONEVALUE);

  
  mvprintw(LINES - 3, 0, "Use <SPACE> to select or onselect an item.");
  mvprintw(LINES - 2, 0, "<ENTER> to see presently selected items (F1 to exit)");
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
    case ' ':
      menu_driver(menu, REQ_TOGGLE_ITEM);
      break;
    case 10: {
      byte temp[200];
      ITEM **tmp_items;

      tmp_items = menu_items(menu);
      temp[0] = '\0';
      for(i32 i = 0; i < item_count(menu); i++) {
        if (item_value(tmp_items[i]) == true) {
          strcat(temp, item_name(tmp_items[i]));
          strcat(temp, " ");
        }
      }
      
      move(20, 0);
      clrtoeol();
      mvprintw(20, 0, "%s", temp);
      refresh();
    } break;
    }
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
