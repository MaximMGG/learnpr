#include "gofl.h"


int main() {

    golf g;
    setgolf(g, "Merry", 2);
    showgolf(g);
    golf g2;
    setgolf(g2);
    showgolf(g2);
    handicap(g, 44);
    showgolf(g);

    return 0;
}
