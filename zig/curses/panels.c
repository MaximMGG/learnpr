#include "panel.h"


int main() {

    WINDOW *my_win[3];
    PANEL *my_panel[3];
    int lines = 10, cols = 40, y = 2, x = 4, i;

    initscr();
    cbreak();
    noecho();

    my_win[0] = newwin(lines, cols, y, x);
    my_win[1] = newwin(lines, cols, y + 1, x + 5);
    my_win[2] = newwin(lines, cols, y + 2, x + 10);


    for(i = 0; i < 3; i++) {
        box(my_win[i], 0, 0);
    }

    my_panel[0] = new_panel(my_win[0]);
    my_panel[1] = new_panel(my_win[1]);
    my_panel[2] = new_panel(my_win[2]);


    update_panels();

    doupdate();

    getch();

    endwin();

    return 0;
}
