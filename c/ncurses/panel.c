#include <panel.h>
#include <string.h>

#define NLINES 10
#define NCOLS 40


void print_in_middle(WINDOW *win, int starty, int startx, int width, char *string, chtype color) {
    int length, x, y;
    float temp;

    if (win == NULL) {
        win = stdscr;
    }
    getyx(win, y, x);
    if (startx != 0) {
        x = startx;
    }
    if (starty != 0) {
        y = starty;
    }
    if (width == 0) {
        width = 80;
    }
    length = strlen(string);
    temp = (float)(width - length) / 2;
    x = startx + (int)temp;
    wattron(win, color);
    mvwprintw(win, y, x, "%s", string);
    wattroff(win, color);
    refresh();
}

void win_show(WINDOW *win, char *label, int label_color) {
    int starty, startx, height, width;

    getbegyx(win, starty, startx);
    getmaxyx(win, height, width);

    box(win, 0, 0);
    mvwaddch(win, 2, 0, ACS_LTEE);
    mvwhline(win, 2, 1, ACS_HLINE, width - 2);
    mvwaddch(win, 2, width - 1, ACS_RTEE);

    print_in_middle(win, 1, 0, width, label, COLOR_PAIR(label_color));

}

void init_wins(WINDOW **wins, int n) {
    int x, y, i;
    char label[80] = {0};

    y = 2;
    x = 10;

    for(i = 0; i < n; i++) {
        wins[i] = newwin(NLINES, NCOLS, y, x);
        sprintf(label, "Window Number %d", i + 1);
        win_show(wins[i], label, i + 1);
        memset(label, 0, 80);
        y += 3;
        x += 7;
    }
}


int main() {
    WINDOW *my_wins[3];
    PANEL *my_panels[3];
    PANEL *top;
    int ch = 0;

    initscr();
    start_color();
    raw();
    noecho();
    keypad(stdscr, TRUE);

    init_pair(1, COLOR_RED, COLOR_BLACK);
    init_pair(2, COLOR_GREEN, COLOR_BLACK);
    init_pair(3, COLOR_BLUE, COLOR_BLACK);
    init_pair(4, COLOR_CYAN, COLOR_BLACK);

    init_wins(my_wins, 3);

    my_panels[0] = new_panel(my_wins[0]);
    my_panels[1] = new_panel(my_wins[1]);
    my_panels[2] = new_panel(my_wins[2]);

    set_panel_userptr(my_panels[0], my_panels[1]);
    set_panel_userptr(my_panels[1], my_panels[2]);
    set_panel_userptr(my_panels[2], my_panels[0]);

    update_panels();

    attron(COLOR_PAIR(4));
    mvprintw(LINES - 2, 0, "Use tab browse through the windows (F1 to exit)");
    attroff(COLOR_PAIR(4));
    doupdate();

    top = my_panels[2];
    int cur_panel = 2;
    char cur_panel_msg[40];

    while((ch = getch()) != KEY_F(1)) {
        switch(ch) {
            case 'a':
            case 9: {
                if (cur_panel == 2) {
                    cur_panel = 0;
                } else {
                    cur_panel++;
                }
                top = (PANEL *) panel_userptr(top);
                top_panel(top);
            };
        }
        attron(COLOR_PAIR(4));
        sprintf(cur_panel_msg, "Cur pannel is %d", cur_panel);
        mvprintw(LINES - 2, 60, (const char *)cur_panel_msg);
        memset(cur_panel_msg, 0, 40);
        attroff(COLOR_PAIR(4));
        update_panels();
        doupdate();
    }

    endwin();

    return 0;
}
