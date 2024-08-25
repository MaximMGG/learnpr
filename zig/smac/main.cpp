#include <iostream>
#include <list>
#include <cstring>
#include <cstdio>


void print_list(std::list<char *>& list) {
    for(auto i = list.begin(); i != list.end(); i++) {
        std::cout << *i << '\n';
    }

}

int main() {
    std::list<char *> list;
    char buf[16]{0};

    for(int i = 0; i < 1000001; i++) {
        if(i % 10 == 7 || i % 7 == 0) {
            list.push_back((char *)"SMAC");
        } else {
            sprintf(buf, "%d", i);
            list.push_back(buf);
            memset(buf, 0, 16);
        }
    }

    print_list(list);

    return 0;
}
