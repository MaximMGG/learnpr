#ifndef INC_H_
#define INC_H_

struct l_list;

typedef struct l_list list;

list *l_create();
int l_add(list *l);

#endif 
