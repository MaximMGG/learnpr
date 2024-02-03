#include <stdio.h>

typedef struct {
    float x, y;
} vec;

typedef struct {
    vec t[3];
} tri;

#define a 0
#define b 1
#define c 2

int point_in_triangle(vec p, tri tr) {

    if ((((p.x - tr.t[a].x) * (tr.t[a].y - tr.t[b].y) - (p.y - tr.t[a].y) * (tr.t[a].x - tr.t[b].x)) >= 0) && 
        (((p.x - tr.t[b].x) * (tr.t[b].y - tr.t[c].y) - (p.y - tr.t[b].y) * (tr.t[b].x - tr.t[c].x)) >= 0) &&
        (((p.x - tr.t[c].x) * (tr.t[c].y - tr.t[a].y) - (p.y - tr.t[c].y) * (tr.t[c].x - tr.t[a].x)) >= 0)) {
        return 1;
    }
    return 0;
}


int main() {

    tri triangle = {   .t[a].x = 1.0, .t[a].y = 2.0,
                .t[b].x = 3.0, .t[b].y = 1.0,
                .t[c].x = 2.0, .t[c].y = 5.0};

    // vec point1 = {1.0, 1.2};
    vec point2 = {10.2, 12.1};
    vec point3 = {2.2, 3.1};
    vec point4 = {2.2, 2.5};

    // printf("%d\n", point_in_triangle(point1, triangle));
    printf("%d\n", point_in_triangle(point2, triangle));
    printf("%d\n", point_in_triangle(point3, triangle));
    printf("%d\n", point_in_triangle(point4, triangle));

    return 0;
}
