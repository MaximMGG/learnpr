#include "compare.h"

int comp_int(int a, int b) {
    return a > b ? 1 : b > a ? -1 : 0;
}
