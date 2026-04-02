#include <cstdext/core.h>
#include <ncurses.h>



str read_input(str name) {
    WINDOW *input = newwin(3, COLS / 1.5, LINES - (LINES / 8), COLS / 8);
    box(input, 0, 0);
    mvwprintw(input, 0, (COLS / 1.5) / 2, "%s", name);
    wrefresh(input);
    wmove(input, 1, 1);
    i32 ch;
    byte in[32] = {0};
    i32 len = 0;
    i32 x = 1;

    while((ch = wgetch(input)) != '\n') {
        if (ch == 127) {
            len--;
            in[len] = 0;
            x--;
            mvwaddch(input, 1, x, ' ');
            wmove(input, 1, x);
            wrefresh(input);

            continue;
        }

        mvwaddch(input, 1, x, ch);
        x++;
        in[len++] = ch;
        wrefresh(input);
    }
    wborder(input, ' ',' ',' ',' ',' ',' ',' ',' ');
    wrefresh(input);
    delwin(input);
    
    return alloc_copy(in, len + 1);
}


int main() {

    initscr();
    noecho();
    raw();
    keypad(stdscr, true);
    refresh();

    i32 ch;


    while((ch = getch()) != 'q') {
        clear();
        if (ch == 'i') {
            str i = read_input("DIFJDIJF");
            mvprintw(1, 1, "%s\n", i);
            dealloc(i);
        }
        refresh();
    }

    endwin();
    return 0;
}
