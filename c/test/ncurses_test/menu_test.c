#include <ncurses.h>
#include <cstdext/core.h>

str menu[] = {
  "first option",
  "second option",
  "third option",
  "fourse option",
  "fives option" 
};
#define MENU_LEN 5




void draw_option_menu(str menu_name, u32 option_count) {
  clear();
  i32 x = 1;
  mvprintw(0, 1, "%s", menu_name);

  i32 ch = 0;
  while(true) {
    for(i32 i = 1; i <= option_count; i++) {
      if (i == x) {
        attron(COLOR_PAIR(1));
        mvprintw(i, 1, "> %d option", i);
        attroff(COLOR_PAIR(1));
      } else {
        attron(COLOR_PAIR(2));
        mvprintw(i, 1, "  %d option", i);
        attroff(COLOR_PAIR(2));
      }
    }
    ch = getch();
    switch(ch) {
      case 'j': {
        if (x == option_count) {
          continue;
        }
        x++;
      } break;
      case 'k': {
        if (x == 1) {
          continue;
        }
        x--;
      } break;
      case 'b': {
        return;
      } break;
    }
    refresh();
  }
}

void run_menu() {
  clear();
  i32 x = 1;
  i32 ch = 0;
  start_color();
  init_pair(1, COLOR_BLACK, COLOR_WHITE);
  init_pair(2, COLOR_WHITE, COLOR_BLACK);
  while(true) {
    for(i32 i = 1; i <= MENU_LEN; i++) {
      if (i == x) {
        attron(COLOR_PAIR(1));
        mvprintw(i, 1, "> %s", menu[i - 1]);
        attroff(COLOR_PAIR(1));
      } else {
        attron(COLOR_PAIR(2));
        mvprintw(i, 1, "  %s", menu[i - 1]);
        attroff(COLOR_PAIR(2));
      }
    }
    ch = getch();
    mvprintw(15, 15, "%d", ch);
    switch(ch) {
      case 10: {
        switch (x) {
          case 1: {
            draw_option_menu("FIRST_MENU", 10);
            clear();
          } break;
          case 2: {
            draw_option_menu("SECOND_MENU", 23);
            clear();
          } break;
          case 3: {
            draw_option_menu("THIRD_MENU", 5);
            clear();
          } break;
          case 4: {
            draw_option_menu("FOURSE_MENU", 9);
            clear();
          } break;
          case 5: {
            draw_option_menu("FIVES_MENU", 14);
            clear();
          } break;
        }
        continue;
      } 
      case 'q': {
                  return;
                } break;
      case 'j': {
                  if (x == 5) {
                    continue;
                  } else {
                    x++;
                  }
                } break;
      case 'k': {
                  if (x == 1) {
                    continue;
                  } else {
                    x--;
                  }
                } break;
    }
    refresh();
  }
}

void ncurses_init() {
  initscr();
  raw();
  noecho();
  keypad(stdscr, true);
  refresh();
}

void ncurses_deinit() {
  endwin();
}


int main() {
  ncurses_init();
  run_menu();
  ncurses_deinit();
  return 0;
}
