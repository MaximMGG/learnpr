#include "../headers/calc.h"
#include <string.h>

#define NEGATIVE_VAL 11


LinkedList *tokinize_string(const char *expression) {
    LinkedList *list = LList_create(L_STRUCT);

    int e_len = strlen(expression);
    double temp_v;
    char type;
    char buf[32];
    char last_token = 0;
    
    for(int i = 0, j = 0; i < e_len; ) {
        if (expression[i] == '-') {
            switch (last_token) {
                case 0:
                    buf[j++] = '-';
                    i++;
                    break;
                case '(':
                    buf[j++] = '-';
                    i++;
                    break;
                case '+':
                case '-':
                case '*':
                case '/':
                    buf[j++] = '-';
                    i++;
                    break;
            }
        }
        if (expression[i] >= '0' && expression[i] <= '9') {
            type = '8';
            for( ; j < e_len; j++) {
                if (expression[i] >= '0' && expression[i] <= '9' || expression[i] == '.') {
                    buf[j] = expression[i];
                    i++;
                }
                else {
                    if (buf[0] == '-' && j == 1) {
                        return NULL;
                    }
                    goto next_sykle;
                }
            }
        }
        switch (expression[i]) {
            case '+':
                type = '+';
                if (last_token != '8' && last_token != ')') {
                    return NULL;
                }
                goto next_sykle;
            case '-':
                type = '-';
                if (last_token != '8' && last_token != ')') {
                    return NULL;
                }
                goto next_sykle;
            case '*':
                type = '*';
                if (last_token != '8' && last_token != ')') {
                    return NULL;
                }
                goto next_sykle;
            case '/':
                type = '/';
                if (last_token != '8' && last_token != ')') {
                    return NULL;
                }
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
            last_token = '8';
            type = 0;
            memset(buf, 0, 32);
            j = 0;
        } else {
            Token t = {.type = type};
            LList_append_next(list, &t, sizeof(Token));
            last_token = type;
            type = 0;
            memset(buf, 0, 32);
            i++;
        }
    }
    return list;
}
