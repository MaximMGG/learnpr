#include <stdio.h>
#include "../headers/calc.h"
#include <string.h>

static Token *set_left_token(Token **tokens, int i, int *pos) {
    i--;
    while(1) {
        if (tokens[i] == NULL) {
            i--;
            if (i < 0) {
                return NULL;
            }
        } else {
            *pos = i;
            return tokens[i];
        }
    }
}

static Token *set_right_token(Token **tokens, int i, int max_size, int *pos) {
    i++;
    while(1) {
        if (tokens[i] == NULL) {
            if (i >= max_size) {
                return NULL;
            }
            i++;
        } else {
            *pos = i;
            return tokens[i];
        }
    }
}

int main(int argc, char **argv) {

    if (argc < 2) {
        perror("argc < 2");
    }

    LinkedList *list = tokinize_string(argv[1]);
    Literator *it = LList_get_iterator(list);

    char calc = 1;
    int it_c = 0;
    int mult = 0;
    int div = 0;
    int b_mult = 0;
    int b_div = 0;
    int sum = 0;
    int sub = 0;
    int brecket = 0;
    int brecket_oper = 0;
    char in_brecket = 0;

    while(it->data != NULL) {
        switch (((Token *)it->data)->type) {
            case '+':
                sum++;
                break;
            case '-':
                sub++;
                break;
            case '*':
                mult++;
                break;
            case '/':
                div++;
                break;
        }

        if (((Token *)it->data)->type == '(') {
            brecket++;
            while(((Token *)it->data)->type != ')') {
                switch (((Token *)it->data)->type) {
                    case '+':
                        brecket_oper++;
                        sum++;
                        break;
                    case '-':
                        brecket_oper++;
                        sub++;
                        break;
                    case '*':
                        brecket_oper++;
                        b_mult++;
                        break;
                    case '/':
                        brecket_oper++;
                        b_div++;
                        break;
                }
                LList_iterator_next(it);
                it_c++;
            }
        }
        LList_iterator_next(it);
        it_c++;
    }

    Token **tokens = (Token **) malloc(sizeof(Token *) * it_c);


    it = LList_get_iterator(list);
    for(int i = 0; i < it_c; i++) {
        tokens[i] = (Token *)it->data;
        LList_iterator_next(it);
    }

    int token_count = it_c;
    int token_x_pos = 0;
    int token_y_pos = 0;

    while(calc) {
        int i = 0;
        if (token_count == 1) {
            break;
        }
        while(i < it_c) {
            if (tokens[i] == NULL) {
                i++;
                continue;
            } 

            if (tokens[i]->type == '(') {
                in_brecket = 1;
                tokens[i] = NULL;
                token_count--;
                i++;
                continue;
            } else if (tokens[i]->type == ')') {
                brecket--;
                tokens[i] = NULL;
                token_count--;
                i++;
                in_brecket = 0;
                continue;
            }

            if (tokens[i]->type == '*') {
                if (brecket > 0 && !in_brecket) {
                    i++;
                    continue;
                }
                Token *x = set_left_token(tokens, i, &token_x_pos);
                Token *y = set_right_token(tokens, i, it_c, &token_y_pos);
                if (y == NULL) {
                    calc = 0;
                    break;
                }
                x->value *= y->value;
                tokens[i] = NULL;
                tokens[token_y_pos] = NULL;
                token_count -= 2;
                mult--;
                i++;
                continue;
            } else if (tokens[i]->type == '/') {
                if (brecket > 0 && !in_brecket) {
                    i++;
                    continue;
                }
                Token *x = set_left_token(tokens, i, &token_x_pos);
                Token *y = set_right_token(tokens, i, it_c, &token_y_pos);
                if (y == NULL) {
                    calc = 0;
                    break;
                }
                x->value /= y->value;
                tokens[i] = NULL;
                tokens[token_y_pos] = NULL;
                token_count -= 2;
                div--;
                i++;
                continue;
            }
            if (mult <= 0 && div <= 0 || in_brecket) {
                if (b_mult <= 0 && b_div <= 0 || !in_brecket) {
                    if (tokens[i]->type == '+') {
                        Token *x = set_left_token(tokens, i, &token_x_pos);
                        Token *y = set_right_token(tokens, i, it_c, &token_y_pos);
                        if (y == NULL) {
                            calc = 0;
                            break;
                        }
                        x->value += y->value;
                        tokens[i] = NULL;
                        tokens[token_y_pos] = NULL;
                        token_count -= 2;
                        sum--;
                        i++;
                        continue;
                    } else if (tokens[i]->type == '-') {
                        Token *x = set_left_token(tokens, i, &token_x_pos);
                        Token *y = set_right_token(tokens, i, it_c, &token_y_pos);
                        if (y == NULL) {
                            calc = 0;
                            break;
                        }
                        x->value -= y->value;
                        tokens[i] = NULL;
                        tokens[token_y_pos] = NULL;
                        token_count -= 2;
                        sub--;
                        i++;
                        continue;
                    }
                }
            }
            i++;
        }
    }


    Token *t = tokens[0];
    printf("%lf\n", t->value);


    LList_iterator_free(it);
    // LList_destroy_list(list, NULL);
    free(tokens);
    return 0;
}
