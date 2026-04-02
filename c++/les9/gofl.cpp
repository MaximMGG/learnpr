#include "gofl.h"
#include <cstring>
#include <iostream>


void setgolf(golf& g, const char *name, int hc) {
    strncpy(g.fullname, name, Len);
    g.handicap = hc;
}
int setgolf(golf& q) {
    char buf[Len];
    int hc;
    std::cout << "Enter fullname: ";
    std::cin.getline(buf, 40);
    std::cout << "Enter handicap: ";
    std::cin >> hc;
    if (strlen(buf) == 0) return 0;

    strcpy(q.fullname, buf);
    q.handicap = hc;
    return 1;

}

void handicap(golf& g, int hc) {
    g.handicap = hc;
}
void showgolf(const golf& g) {
    std::cout << "Name is: " << g.fullname << std::endl
                << "Handicap is: " << g.handicap << std::endl;
}
