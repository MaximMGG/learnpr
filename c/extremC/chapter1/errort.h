#ifndef _ERROR_T_
#define _ERROR_T_

typedef struct {
    char active;
    char msg[128];
}my_error;

extern my_error _my_error_t;

#endif

