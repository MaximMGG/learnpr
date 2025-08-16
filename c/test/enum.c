#include <stdio.h>


typedef enum {
    INFO, WARN, ERROR, DEBUG, FATAL
} Level;

#define call_level(level) level##_call(level)

void INFO_call(Level level) {
    printf("INFO %d\n", level);
}
void WARN_call(Level level) {
    printf("WARN %d\n", level);
}
void ERROR_call(Level level) {
    printf("ERROR %d\n", level);
}
void DEBUG_call(Level level) {
    printf("DEBUG %d\n", level);
}
void FATAL_call(Level level) {
    printf("FATAL %d\n", level);
}

int main() {

    call_level(INFO);
    call_level(FATAL);


    return 0;
}
