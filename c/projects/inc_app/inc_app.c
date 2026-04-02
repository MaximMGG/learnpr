#include <cstdext/core.h>
#include <libpq/libpq.h>
#include <cstdext/io/logger.h>
#include <cstdext/container/list.h>
#include <cstdext/io/writer.h>
#include <stdio.h>
#include <stdlib.h>
#include <ncurses.h>
#include <unistd.h>
#include <sys/uio.h>
#include <fcntl.h>

#define PATH_TO_INC_LOG_FMT "/home/%s/.config/inc.cfg"
byte PATH_TO_INC_LOG[128] = {0};
i32 inc_fd;


const str def_msg[32] = {"Name", "Current expends", "Limit", "Difference"};
typedef struct {
    i8 name[32];
    u32 cur_exp;
    u32 limit;
    i32 dif;
}expends_t;


void check_inc_log() {
    log(INFO, "Check ing log");
    str user_name = getenv("USER");
    snprintf(PATH_TO_INC_LOG, 128, PATH_TO_INC_LOG_FMT, user_name);

    if (access(PATH_TO_INC_LOG, F_OK)) {
        log(WARN, "File %s doisn't exists, create it", PATH_TO_INC_LOG);

        inc_fd = open(PATH_TO_INC_LOG, O_CREAT | O_RDWR | O_APPEND, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP | S_IWOTH | S_IROTH);
        if (inc_fd < 0) {
            log(ERROR, "Cant open/create file %s", PATH_TO_INC_LOG);
            exit(1);
        }
    } else {
        inc_fd = open(PATH_TO_INC_LOG, O_RDWR | O_APPEND, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP | S_IWOTH | S_IROTH);
        if (inc_fd < 0) {
            log(ERROR, "Cant open/create file %s", PATH_TO_INC_LOG);
            exit(1);
        }
    }
}

void cleanup(list *l) {
    close(inc_fd);

    for(i32 i = 0; i < l->len; i++) {
        expends_t *tmp = list_get(l, i);
        dealloc(tmp);
    }
    list_destroy(l);
    log(INFO, "Cleanup");
}

list *read_inc_file() {

    list *l = list_create(STRUCT);
    expends_t e = {0};
    struct iovec io[1] = {0};
    io[0].iov_base = &e;
    io[0].iov_len = sizeof(e);

    while(readv(inc_fd, io, 1) == sizeof(e)) {
        expends_t *new = alloc_copy(&e, sizeof(expends_t));
        list_append(l, new);
    }

    return l;
}


void write_inc_file(list *l) {

    truncate(PATH_TO_INC_LOG, 0);

    struct iovec io[1] = {0};

    for(i32 i = 0; i < l->len; i++) {
        expends_t *tmp = list_get(l, i);
        io[0].iov_base = tmp;
        io[0].iov_len = sizeof(expends_t);
        writev(inc_fd, io, 1);
    }
}


void show_help() {
    log(INFO, "Showing help");
    WINDOW *help_window = newwin(LINES / 2, COLS / 2, LINES / 4, COLS / 4);
    box(help_window, 0, 0);

    mvwprintw(help_window, 1, 1, "Pres q/F1 for Quit");
    mvwprintw(help_window, 2, 1, "Pres j for navigate down");
    mvwprintw(help_window, 3, 1, "Pres k for navigate up");
    mvwprintw(help_window, 4, 1, "Pres c for create new expands");
    mvwprintw(help_window, 5, 1, "Pres d for delete expands");
    mvwprintw(help_window, 6, 1, "Pres l for set limit");
    mvwprintw(help_window, 7, 1, "Pres i for increase current expands");
    mvwprintw(help_window, 8, 1, "Pres a to extract to file");
    mvwprintw(help_window, 9, 1, "Pres r to raname expand");
    wrefresh(help_window);

    wgetch(help_window);
    wborder(help_window, ' ',' ',' ',' ',' ',' ',' ',' ');
    wrefresh(help_window);
    delwin(help_window);
}


str read_input(str input_name) {

    WINDOW *input = newwin(3, COLS / 1.5, LINES - LINES / 8, COLS / 8);
    box(input, 0, 0);
    mvwprintw(input, 0, (COLS / 1.5) / 2, "%s", input_name);
    wrefresh(input);
    noecho();
    i32 ch;
    byte in[33] = {0};
    i32 len = 0;
    i32 x = 1;
    wmove(input, 1, 1);

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

        in[len++] = ch;
        mvwaddch(input, 1, x, ch);
        x++;
        wrefresh(input);
    }

    wborder(input, ' ',' ',' ',' ',' ',' ',' ',' ');
    wrefresh(input);
    delwin(input);

    return alloc_copy(in, len + 1);
}

void extract_to_file(list *l, str file_name) {
    i32 fd = open(file_name, O_CREAT | O_RDWR, S_IWUSR | S_IRUSR);
    if (fd < 0) {
        log(ERROR, "Can't create file %s", file_name);
    }

    writer *w = writer_create(fd, null, 0);

    writer_print(w, "%-30s %-30s %-30s %-30s\n", def_msg[0], def_msg[1], def_msg[2], def_msg[3]);
    i8 buf[128] = {0};
    u64 total_expension = 0;
    u64 total_limit = 0;
    i64 total_difference = 0;

    for(i32 i = 0; i < l->len; i++) {
        expends_t *tmp = list_get(l, i);
        total_expension += tmp->cur_exp;
        total_limit += tmp->limit;
        total_difference += tmp->dif;
        writer_print(w, "%-30s %-30d %-30d %-30d\n", tmp->name, tmp->cur_exp, tmp->limit, tmp->dif);
    }
    writer_print(w, "%-30s %-30lu %-30lu %-30ld\n", "TOTAL", total_expension, total_limit, total_difference);

    log(INFO, "Extrancs to file %s", file_name);
    writer_flush(w);
    writer_destroy(w);

    close(fd);

}


int main() {
    log_set_opt(DEF_OPTION, LOG_TYPE_FILE, "inc_app.log");
    log(INFO, "Init ncurses funcs");
    initscr();
    noecho();
    raw();
    keypad(stdscr, true);
    start_color();
    refresh();
    check_inc_log();
    i32 ch = 0;
    i32 line = 0;

    list *l = read_inc_file();

    while(ch != KEY_F(1) && ch != 'q') {
        clear();
        attron(A_BOLD);
        mvprintw(0, 0, "%-30s %-30s %-30s %-30s", def_msg[0], def_msg[1], def_msg[2], def_msg[3]);
        attroff(A_BOLD);
        switch(ch) {
            case 'j': {
                if (line < l->len - 1) {
                    line++;
                }
            } break;
            case 'k': {
                if (line > 0) {
                    line--;
                }
            } break;
            case 'h': {
                show_help();
                refresh();
            } break;
            case 'i': {
                str r = read_input("Enter sum");
                u32 sum = atol(r);
                dealloc(r);
                expends_t *tmp = list_get(l, line);
                tmp->cur_exp += sum;
                tmp->dif = tmp->limit - tmp->cur_exp;
            } break;
            case 'c': {
                str name = read_input("Enter expand name");
                str limit = read_input("Enter limits");
                expends_t tmp = {0};
                strncpy(tmp.name, name, 32);
                tmp.limit = atol(limit);
                list_append(l, alloc_copy(&tmp, sizeof(expends_t)));
                dealloc(name);
                dealloc(limit);
            } break;
            case 'd': {
                if (l->len == 0) {
                    continue;
                }

                expends_t *tmp = list_get(l, line);
                byte buf[64] = {0};
                snprintf(buf, 64, "Delete %s?(y/n)", tmp->name);
                str answer = read_input(buf);
                if (answer[0] == 'y') {
                    list_remove(l, line);
                    log(INFO, "Line %d l->len %d", line, l->len);
                    if (line == l->len) {
                        line--;
                    }
                    log(INFO, "Remove expend %s", tmp->name);
                    dealloc(answer);
                    dealloc(tmp);
                } else {
                    dealloc(answer);
                    continue;
                }
            } break;
            case 'l': {
                expends_t *tmp = list_get(l, line);
                str new_lim = read_input("Enter new limit");
                u32 new_lim_n = atol(new_lim);
                tmp->limit = new_lim_n;
                tmp->dif = tmp->limit - tmp->cur_exp;
                dealloc(new_lim);
            } break;
            case 'r': {
                expends_t *tmp = list_get(l, line);
                str new_name = read_input("Enter new name");
                strncpy(tmp->name, new_name, 32);
                dealloc(new_name);
            } break;
            case 'a': {
                str file_name = read_input("Enter file name for extraction");
                extract_to_file(l, file_name);
                dealloc(file_name);
            } break;
        }

        i32 offset = 0;
        if (line - (LINES - 10) > 0) {
            offset = line - (LINES - 10);
        }

        i32 y = 1;
        u64 total_expension = 0;
        u64 total_limit = 0;
        i64 total_difference = 0;

        for(i32 i = 0; i < offset; i++) {
            expends_t *tmp = list_get(l, i);
            total_expension += tmp->cur_exp;
            total_limit += tmp->limit;
            total_difference += tmp->dif;
        }

        
        for(i32 i = offset; i < l->len; i++, y++) {
            expends_t *tmp = list_get(l, i);
            total_expension += tmp->cur_exp;
            total_limit += tmp->limit;
            total_difference += tmp->dif;

            if (line == i) {
                attron(A_REVERSE);
                mvprintw(y, 0, "%-30s %-30d %-30d %-30d", tmp->name, tmp->cur_exp, tmp->limit, tmp->dif);
                attroff(A_REVERSE);
            } else {
                mvprintw(y, 0, "%-30s %-30d %-30d %-30d", tmp->name, tmp->cur_exp, tmp->limit, tmp->dif);
            }
        }
        mvprintw(y, 0, "%-30s %-30lu %-30lu %-30ld", "TOTAL", total_expension, total_limit, total_difference);

        refresh();
        ch = getch();
        log(INFO, "ch == %c", ch);
    }

    endwin();
    write_inc_file(l);
    log(INFO, "Finish app work");

    cleanup(l);
    return 0;
}
