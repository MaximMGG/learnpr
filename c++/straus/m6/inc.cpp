#include <list>
#include <iostream>



template <typename T>
void printl(const std::list<T> &list) {
    for(auto i = list.begin(); i != list.end(); i++) {
        std::cout << *i << '\n';
    }
}

template <typename T>
void printd(const std::list<T> &list) {
    for(auto i = list.begin(); i != list.end(); ++i) {
        std::cout << *i << '\n';
    }
}



int main() {

    std::list<int> li;

    for(int i = 0; i < 10; i++) {
        li.push_back(i + 10);
    }


    printl(li);
    printd(li);

    li.clear();

    return 0;
}
