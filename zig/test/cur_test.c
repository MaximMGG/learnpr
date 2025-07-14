#include <locale.h>
#include <ncursesw/ncurses.h>


int main() {

    setlocale(LC_ALL, "ru_RU.UTF-8");
    initscr();
    raw();
    keypad(stdscr, TRUE);
    refresh();
    int ch;
    char buf[128] = {0};
    int i = 0;

    while(ch != KEY_F(1)) {
        ch = getch();

        buf[i] = (char)ch;
        i++;
    }

    mvprintw(2, 0, "%s", buf);
    getch();

    endwin();

    return 0;
}
