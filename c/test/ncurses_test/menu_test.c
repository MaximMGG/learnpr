#include <ncurses.h>
#include <cstdext/core.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <panel.h>

str menu[] = {
  "first option",
  "second option",
  "third option",
  "fourse option",
  "fives option" 
};
#define MENU_LEN 5


#define CTRL(n) (n & 0x1f)

#define CTRL_Q CTRL('q')


ptr draw_temp_win(ptr p) {
  str message = cast(str, p);
  WINDOW *tmp = newwin(LINES / 2, COLS / 2, 3, 10);
  PANEL *dp;
  box(tmp, 0, 0);
  wrefresh(tmp);
  mvwprintw(tmp, 1, 1, "%s", "Hello");
  wrefresh(tmp);
  sleep(4);
  wborder(tmp, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
  wclear(tmp);
  wrefresh(tmp);
  delwin(tmp);
  return null;
 }



 void draw_option_menu(str menu_name, u32 option_count) {
   clear();
   i32 x = 1;
   attron(COLOR_PAIR(3));
   mvprintw(0, 1, "%-*s", COLS - 1, menu_name);
   attroff(COLOR_PAIR(3));
   
   //pthread_t tr;
   /* pthread_create(&tr, null, draw_temp_win, "Hello"); */
   /* pthread_detach(tr); */

   draw_temp_win("Hello");
   
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
   init_pair(3, COLOR_WHITE, COLOR_BLUE);

   /* pthread_t tr; */
   /* pthread_create(&tr, null, draw_temp_win, "Hello"); */
   /* pthread_detach(tr); */
   draw_temp_win("Hello");   
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
       case CTRL_Q: {
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
