#ifndef _CALC_H_
#define _CALC_H_
#include <util/m_linkedlist.h>

typedef struct {
    char type;
    double value;
} Token;

LinkedList *tokinize_string(const char *expression);

#endif //_CALC_H_
