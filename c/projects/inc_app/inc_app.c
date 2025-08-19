#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <cstdext/container/list.h>
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
    str name[32];
    u32 cur_exp;
    u32 limit;
    i32 dif;
}expends_t;


void check_inc_log() {
    log(INFO, "Check ing log");
    str user_name = getenv("USERNAME");
    snprintf(PATH_TO_INC_LOG, 128, PATH_TO_INC_LOG_FMT, user_name);

    if (access(PATH_TO_INC_LOG, F_OK)) {
        log(WARN, "File %s doisn't exists, create it", PATH_TO_INC_LOG);

        inc_fd = open(PATH_TO_INC_LOG, O_CREAT | O_RDWR | O_APPEND, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP | S_IWOTH | S_IROTH);
        if (inc_fd < 0) {
            log(ERROR, "Cant open/create file %s", PATH_TO_INC_LOG);
        }
    } else {
        inc_fd = open(PATH_TO_INC_LOG, O_RDWR | O_APPEND, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP | S_IWOTH | S_IROTH);
        if (inc_fd < 0) {
            log(ERROR, "Cant open/create file %s", PATH_TO_INC_LOG);
        }
    }
}

void cleanup() {
    close(inc_fd);
}

list *read_inc_file() {

    list *l = list_create(STRUCT);
    expends_t e = {0};
    l->data_size = sizeof(e);
    struct iovec io[1] = {0};
    io[0].iov_base = &e;
    io[0].iov_len = sizeof(e);

    while(readv(inc_fd, io, 1) == sizeof(e)) {


    }

}



int main() {
    log_set_opt(DEF_OPTION, LOG_TYPE_FILE, "inc_app.log");
    log(INFO, "Init ncurses funcs");
    initscr();
    noecho();
    raw();
    keypad(stdscr, true);
    start_color();
    check_inc_log();

    endwin();
    log(INFO, "Finish app work");

    return 0;
}
