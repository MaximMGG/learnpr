#include <panel.h>
#include <cstdext/core.h>
#include <string.h>

#define NLINES 10
#define NCOLS 40

#define CTRL(k) (k & 0x1F)

#define CTRL_Q CTRL('q')

void initWins(WINDOW **wins, int n);
void win_show(WINDOW *win, i8 *label, i32 label_color);
void print_in_middle(WINDOW *win, i32 starty, i32 startx, i32 width, i8 *string, chtype color);

int main() {
  WINDOW *my_wins[3];
  PANEL *my_panels[3];
  PANEL *top;
  i32 ch;

  i32 lines = 10, cols = 40, y = 2, x = 4, i;

  initscr();
  start_color();
  cbreak();
  noecho();
  keypad(stdscr, true);

  init_pair(1, COLOR_RED, COLOR_BLACK);
  init_pair(2, COLOR_GREEN, COLOR_BLACK);
  init_pair(3, COLOR_BLUE, COLOR_BLACK);
  init_pair(4, COLOR_CYAN, COLOR_BLACK);


  initWins(my_wins, 3);
  my_panels[0] = new_panel(my_wins[0]);
  my_panels[1] = new_panel(my_wins[1]);
  my_panels[2] = new_panel(my_wins[2]);

  set_panel_userptr(my_panels[0], my_panels[1]);
  set_panel_userptr(my_panels[1], my_panels[2]);
  set_panel_userptr(my_panels[2], my_panels[0]);

  update_panels();

  attron(COLOR_PAIR(4));
  mvprintw(LINES - 2, 0, "Use tab to browse through the windows (F1 to Exit)");
  attroff(COLOR_PAIR(4));
  doupdate();

  top = my_panels[2];
  while((ch = getch()) != KEY_F(1)) {
    switch(ch) {
    case CTRL_Q:
      goto END;
    case 9:
      top = (PANEL *)panel_userptr(top);
      top_panel(top);
      break;
    }
    update_panels();
    doupdate();
  }
 END:
  
  endwin();
  return 0;
}


  /* my_wins[0] = newwin(lines, cols, y, x); */
  /* my_wins[1] = newwin(lines, cols, y + 1, x + 5); */
  /* my_wins[2] = newwin(lines, cols, y + 2, x + 10); */

void initWins(WINDOW **wins, int n) {
  i32 x = 2, y = 7;
  i8 lable[80];
  
  for(i32 i = 0; i < n; i++) {
    wins[i] = newwin(NLINES, NCOLS, y, x);
    sprintf(lable, "Window Number %d", i);
    win_show(wins[i], lable, i + 1);
    x += 3;
    y += 7;
  }
}

void win_show(WINDOW *win, i8 *label, i32 label_color) {
  i32 startx, starty, height, width;
  getbegyx(win, starty, startx);
  getmaxyx(win, height, width);
  box(win, 0, 0);
  mvwaddch(win, 2, 0, ACS_LTEE);
  mvwhline(win, 2, 1, ACS_HLINE, width - 2);
  mvwaddch(win, 2, width - 1, ACS_RTEE);

  print_in_middle(win, 1, 0, width, label, COLOR_PAIR(label_color));
}


void print_in_middle(WINDOW *win, i32 starty, i32 startx, i32 width, i8 *string, chtype color) {
  i32 length, x, y;
  f32 temp;

  if (win == null)
    win = stdscr;
  getyx(win, y, x);
  if (startx != 0)
    x= startx;
  if (starty != 0)
    y = starty;
  if (width == 0)
    width = 80;

  length = strlen(string);
  temp = cast(f32, (width - length) / 2);
  x = startx + cast(i32, temp);
  wattron(win, color);
  mvwprintw(win, y, x, "%s", string);
  wattroff(win, color);
  wrefresh(win);
}
