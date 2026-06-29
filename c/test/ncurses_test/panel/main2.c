#include <curses.h>
#include <panel.h>
#include <cstdext/core.h>
#include <string.h>

typedef struct _PANEL_DATA {
  i32 x, y, w, h;
  i8 *label;
  i32 label_color;
  PANEL *next;
} PANEL_DATA;


#define NLINES 10
#define NCOLS 40

void init_wins(ST_ARR(WINDOW *) win);
void win_show(WINDOW *win, str label, i32 label_color);
void print_in_middle(WINDOW *win, i32 starty, i32 startx, i32 wigth, str label, chtype color);
void set_user_ptrs(ST_ARR(PANEL *) panels);


int main() {
  WINDOW **my_wins   = makeArr(WINDOW *, 3);
  PANEL **my_panels = makeArr(PANEL *, 3);
  PANEL_DATA *top;
  PANEL *stack_top;
  WINDOW *temp_win, *old_win;
  i32 ch;
  i32 newx, newy, neww, newh;
  bool size = false, move = false;

  //Initialize curses
  initscr();
  start_color();
  cbreak();
  noecho();
  keypad(stdscr, true);

  //Initialize all the colors

  init_pair(1, COLOR_RED, COLOR_BLACK);
  init_pair(2, COLOR_GREEN, COLOR_BLACK);
  init_pair(3, COLOR_BLUE, COLOR_BLACK);
  init_pair(4, COLOR_CYAN, COLOR_BLACK);

  init_wins(my_wins);

  //Attach a panel to each window
  my_panels[0] = new_panel(my_wins[0]);
  my_panels[1] = new_panel(my_wins[1]);
  my_panels[2] = new_panel(my_wins[2]);

  set_user_ptrs(my_panels);
  //update the stacking order. 2nd panel will be on top
  update_panels();

  //Show it on the screen
  attron(COLOR_PAIR(4));
  mvprintw(LINES - 3, 0, "Use 'm' for moving, 'r' for resizeing");
  mvprintw(LINES - 2, 0, "Use tab to browse through the window (F1 to Exit)");
  attroff(COLOR_PAIR(4));
  doupdate();

  stack_top = my_panels[2];
  top = (PANEL_DATA *)panel_userptr(stack_top);
  newx = top->x;
  newy = top->y;
  neww = top->w;
  newh = top->h;
  while((ch = getch()) != KEY_F(1)) {
    switch(ch) {
    case 9:  // tab
      top = cast(PANEL_DATA *, panel_userptr(stack_top)); // maybe this is doesn' t need, check later
      top_panel(top->next);
      stack_top = top->next;
      top = cast(PANEL_DATA *, panel_userptr(stack_top));
      newx = top->x;
      newy = top->y;
      neww = top->w;
      newh = top->h;
      break;
    case 'r':
      if (move) move = false;
      size = true;
      attron(COLOR_PAIR(4));
      mvprintw(LINES - 4, 0, "Entered Resizing: Use Arrow Keys to resize and press <ENTER> to end resizeng");
      refresh();
      attroff(COLOR_PAIR(4));
      break;
    case 'm':
      if (size) size = false;
      attron(COLOR_PAIR(4));
      mvprintw(LINES - 4, 0, "Entered Moving: Use Arrow Keys to Move and press <ETNER> to end moving");
      refresh();
      attroff(COLOR_PAIR(4));
      move = true;
      break;
    case KEY_LEFT:
      if (size) {
	newx--;
	neww++;
      }
      if (move) {
	--newx;
      }
      break;
    case KEY_RIGHT:
      if (size) {
	newx++;
	neww--;
      }
      if (move) {
	newx++;
      }
      break;
    case KEY_UP:
      if (size) {
	newy--;
	newh++;
      }
      if (move) {
	newy--;
      }
      break;
    case KEY_DOWN:
      if (size) {
	newy++;
	newh--;
      }
      if (move) {
	newy++;
      }
      break;
    case 10: // ENTER
      if (size)
    	size = false;
      if (move)
	move = false;

      break;
    }
    
    move(LINES - 4, 0);
    clrtoeol(); // clear window
    refresh();
    if (size && !move) {
      old_win = panel_window(stack_top);
      temp_win = newwin(newh, neww, newy, newx);
      replace_panel(stack_top, temp_win);
      PANEL_DATA *p = (PANEL_DATA *)panel_userptr(stack_top);
      p->x = newx;
      p->y = newy;
      p->w = neww;
      p->h = newh;
      win_show(temp_win, top->label, top->label_color);
      delwin(old_win);
    }
    
    if (move && !size) {
      move_panel(stack_top, newy, newx);
    }

    attron(COLOR_PAIR(4));
    mvprintw(LINES - 3, 0, "Use 'm' for moving, 'r' for resizeing");
    mvprintw(LINES - 2, 0, "Use tab to browse through the window (F1 to Exit)");
    attroff(COLOR_PAIR(4));
    update_panels();
    doupdate();
  }
  

  endwin();

  for(i32 i = 0; i < ARR_LEN(my_panels); i++) {
    PANEL_DATA *d = cast(PANEL_DATA *, panel_userptr(my_panels[i]));
    DEALLOC(d->label);
  }

  DEALLOC(my_wins);
  DEALLOC(my_panels);
  
  return 0;
}

//Put all the windows
void init_wins(ST_ARR(WINDOW *) win) {
  i32 x = 2, y = 10;
  i8 label[80];

  for(i32 i = 0; i < ARR_LEN(win); i++) {
    win[i] = newwin(NLINES, NCOLS, x, y);
    sprintf(label, "Window Number %d", i);
    win_show(win[i], label, i + 1);
    x += 3;
    y += 7;
  }
}

//Set the PANEL_DATA structures for individual panels
void win_show(WINDOW *win, str label, i32 label_color) {
  i32 startx, starty, height, width;
  getbegyx(win, starty, startx);
  getmaxyx(win, height, width);

  box(win, 0, 0);
  mvwaddch(win, 2, 0, ACS_LTEE);
  mvwhline(win, 2, 1, ACS_HLINE, width - 2);
  mvwaddch(win, 2, width - 1, ACS_RTEE);

  print_in_middle(win, 1, 0, width, label, COLOR_PAIR(label_color));
}

void print_in_middle(WINDOW *win, i32 starty, i32 startx, i32 width, str label, chtype color) {
  i32 length, x, y;
  f32 temp;

  if (!win) {
    win = stdscr;
  }
  getyx(win, y, x);
  if (startx)
    x = startx;
  if (starty)
    y = starty;
  if (!width)
    width = 80;

  length = strlen(label);
  temp = like(temp, (width - length) / 2);
  x = startx + cast(i32, temp);
  wattron(win, color);
  mvwprintw(win, y, x, "%s", label);
  wattroff(win, color);
  refresh();
}

void set_user_ptrs(ST_ARR(PANEL *) panels) {
  PANEL_DATA *ptrs;
  WINDOW *win;
  i32 x, y, w, h;

  ptrs = make_many(PANEL_DATA, ARR_LEN(panels));
  for(i32 i = 0; i < ARR_LEN(panels); i++) {
    win = panel_window(panels[i]);
    getbegyx(win, y, x);
    getmaxyx(win, h, w);
    ptrs[i].x = x;
    ptrs[i].y = y;
    ptrs[i].h = h;
    ptrs[i].w = w;
    ptrs[i].label = strCreateFmt("Window Number %d", i + 1);
    ptrs[i].label_color = i + 1;
    if (i + 1 == ARR_LEN(panels)) {
      ptrs[i].next = panels[0];
    } else {
      ptrs[i].next = panels[i + 1];
    }
    set_panel_userptr(panels[i], &ptrs[i]);
  }
  
}
