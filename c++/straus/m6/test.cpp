#include <list>
#include <iostream>

class T {
    public:
        int a;
        const char *b;
        char c;

        T(int x, const char *b, char c) {
            this->a = x;
            this->b = b;
            this->c = c;
        }
};



int main() {
    std::list<T*> list;

    T *t = new T{1, "Hello", 'x'};
    T *t2 = new T{2, "Hello2", 'j'};

    list.push_back(t);
    list.push_back(t2);

    std::list<T*>::iterator it = list.begin();


    std::cout << (*it)->b << '\n';
    it++;
    std::cout << (*it)->b << '\n';


    list.remove(*it);

    for(auto t : list) {
        std::cout << t->b << '\n';
    }



    delete(t);
    delete(t2);

    return 0;
}
