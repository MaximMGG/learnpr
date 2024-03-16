#include "../headers/calc.h"
#include <string.h>



LinkedList *tokinize_string(const char *expression) {
    LinkedList *list = LList_create(L_STRUCT);

    int e_len = strlen(expression);
    double temp_v;
    char type;
    char buf[32];
    
    for(int i = 0; i < e_len; ) {
        if (expression[i] >= '0' && expression[i] <= '9') {
            type = '8';
            for(int j = 0; j < e_len; j++) {
                if (expression[i] >= '0' && expression[i] <= '9' || expression[i] == '.') {
                    buf[j] = expression[i];
                    i++;
                }
                else 
                    goto next_sykle;
            }
        }
        switch (expression[i]) {
            case '+':
                type = '+';
                goto next_sykle;
            case '-':
                type = '-';
                goto next_sykle;
            case '*':
                type = '*';
                goto next_sykle;
            case '/':
                type = '/';
                goto next_sykle;
        }
        if (expression[i] == '(') {
            type = '(';
            goto next_sykle;

        } else if (expression[i] == ')') {
            type = ')';
            goto next_sykle;
        }
        if (expression[i] == ' ') {
            i++;
            continue;
        }
next_sykle:
        if (type == '8') {
            Token t = {.type = type, .value = atof(buf)};
            LList_append_next(list, &t, sizeof(Token));
            type = 0;
            memset(buf, 0, 32);
        } else {
            Token t = {.type = type};
            LList_append_next(list, &t, sizeof(Token));
            type = 0;
            memset(buf, 0, 32);
            i++;
        }
    }
    return list;
}
