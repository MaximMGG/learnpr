#include "oop.h"
#include <stdlib.h>



int main() {

    stock *s = create_stock("TSL", 14441422314, 234.0);
    s->to_string(s->hash);
    s->set_capacity(s->hash, 10000000000);
    s->to_string(s->hash);
    s->set_name(s->hash, "BMW");
    s->to_string(s->hash);
    stock *n = create_stock(NULL, 0, 0);
    n->set_name(n->hash, "PAYPAL");
    n->set_capacity(n->hash, 999999);
    n->set_average(n->hash, 999.9);
    n->to_string(n->hash);
    destroy_stock(s);
    destroy_stock(n);
    return 0;
}
