#include <cstdext/core.h>
#include <ncurses.h>
#include <menu.h>

byte *choices[] = {
  "Choise 1",
  "Choise 2",
  "Choise 3",
  "Choise 4",
  "Exit",
};


i32 main() {
  ITEM **my_item;
  i32 c;
  i32 arr_len = 5;
  MENU *my_menu;
  ITEM *cur_item;
  my_item = (ITEM **)calloc(arr_len + 1, sizeof(ITEM *));

  initscr();
  cbreak();
  noecho();
  keypad(stdscr, true);
  
  for(i32 i = 0; i < arr_len; i++) {
    my_item[i] = new_item(choices[i], choices[i]);
  }
  my_item[arr_len] = null;

  my_menu = new_menu(my_item);
  mvprintw(LINES - 2, 0, "F1 to exit");
  post_menu(my_menu);
  refresh();

  while((c = getch()) != KEY_F(1)) {
    switch(c) {
    case KEY_DOWN:
      menu_driver(my_menu, REQ_DOWN_ITEM);
      break;
    case KEY_UP:
      menu_driver(my_menu, REQ_UP_ITEM);
      break;
    }
  }

  free_item(my_item[0]);
  free_item(my_item[1]);
  free_menu(my_menu);
  endwin();
  return 0;
}
