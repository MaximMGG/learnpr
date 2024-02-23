#include <stdio.h>

char res[36];

char *map_num_to_bits(int a) {
    int bit_pos = 0;
    int bit_count = 0;
    for(int i = 31; i >= 0; i--) {
        int t = (a >> i) & 0b0001;
        res[bit_pos++] = t == 1 ? '1' : '0';
        bit_count++;
        if (bit_count == 8) {
            res[bit_pos++] = ' ';
            bit_count = 0;
        }
    }
    res[bit_pos] = '\0';
    return res;
}


void inplace_swap(int *x, int *y) {
    printf("%s\n", map_num_to_bits(*x));
    printf("%s\n", map_num_to_bits(*y));
    *y = *x ^ *y;
    printf("%s\n", map_num_to_bits(*y));
    *x = *x ^ *y;
    printf("%s\n", map_num_to_bits(*x));
    *y = *x ^ *y;
    printf("%s\n", map_num_to_bits(*y));
}


int main() {

    int x = 123;
    int y = 666666;
    printf("%d - %d\n", x, y);
    inplace_swap(&x, &y);
    printf("%d - %d\n", x, y);

    return 0;
}
