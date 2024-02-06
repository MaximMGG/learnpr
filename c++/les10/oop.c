#include "oop.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


typedef struct {
    char *name;
    long capasity;
    double average;
    int hash;
} stock_p;

static stock_p **buf;
static int stock_count = 0;
static int hash_p = 0;

static stock_p *get_stock_by_hash(int hash) {
    stock_p *p = NULL;
    for(int i = 0; i < stock_count; i++) {
        if (buf[i] != NULL) {
            if (hash == buf[i]->hash) {
                p = buf[i]; 
            }
        }
    }
    return p;
}


static void set_name(int hash, const char *name) {
    stock_p *p = get_stock_by_hash(hash);
    if (p->name != NULL) {
        free(p->name);
    }
    p->name = (char *) malloc(sizeof(char) * strlen(name));
    strcpy(p->name, name);
}
static char *get_name(int hash) {
    stock_p *p = get_stock_by_hash(hash);
    return p->name;
}

static void set_capasity(int hash, long capasity) {
    stock_p *p = get_stock_by_hash(hash);
    p->capasity = capasity;
}

static long get_capasity(int hash) {
    stock_p *p = get_stock_by_hash(hash);
    return p->capasity;
}

static void set_average(int hash, double average) {
    stock_p *p = get_stock_by_hash(hash);
    p->average = average;
}

static double get_average(int hash) {
    stock_p *p = get_stock_by_hash(hash);
    return p->average;
}

static void to_string(int hash) {
    stock_p *p = get_stock_by_hash(hash);
    printf("Name of stock is: %s, capasity is: %ld, average is: %lf.\n", p->name, p->capasity, p->average);
}

stock *create_stock(char *name, long capasity, double average) {
    stock *s = (stock *) malloc(sizeof(stock));
    s->hash = hash_p;
    if (stock_count == 0) {
        buf = (stock_p **) malloc(sizeof(stock_p *));
        buf[stock_count] = (stock_p *) malloc(sizeof(stock_p));
    } else {
        buf = (stock_p **) realloc(buf, sizeof(stock_p *) * stock_count + 1);
        buf[stock_count] = (stock_p *) malloc(sizeof(stock_p));
        buf[stock_count]->hash = hash_p;
    }
    buf[stock_count]->hash = hash_p;
    if (name != NULL) {
        buf[stock_count]->name = (char *) malloc(sizeof(char) * strlen(name));
        strcpy(buf[stock_count]->name, name);
    } else {
        buf[stock_count]->name = NULL;
    }
    if (capasity != 0) {
        buf[stock_count]->capasity = capasity;
    } else {
        buf[stock_count]->capasity = 0;
    } 
    if (average != 0) {
        buf[stock_count]->average = average;
    } else {
        buf[stock_count]->average = 0.0;
    }

    stock_count++;
    hash_p++;

    s->set_name = set_name;
    s->get_name = get_name;
    s->set_average = set_average;
    s->get_average = get_average;
    s->set_capacity = set_capasity;
    s->get_capacity = get_capasity;
    s->to_string = to_string;

    return s;
}

static void free_stock_p(stock_p *p) {
    for(int i = 0; i < stock_count; i++) {
        if (p->hash == buf[i]->hash) {
            if (buf[i]->name != NULL) {
                free(buf[i]->name);
            }
            free(buf[i]);
            buf[i] = NULL;
            if (i == stock_count - 1) {
                stock_count--;
                break;
            } else {
                for(int j = i; j < stock_count - 1; j++) {
                    buf[j] = buf[j + 1];
                }
                stock_count--;
                break;
            }
        }
    }
    if (stock_count == 0) {
        free(buf);
    } else {
        buf = (stock_p **) realloc(buf, sizeof(stock_p *) * stock_count);
    }
}

void destroy_stock(stock *s) {
    stock_p *p = get_stock_by_hash(s->hash);
    free_stock_p(p);
    free(s);
}




