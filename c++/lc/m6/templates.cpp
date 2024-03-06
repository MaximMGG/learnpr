#include <iostream>



template <typename T> T& add_ret(T& t, T& t2) {
    std::cout << "Inline addres is: " << &t << '\n';
    std::cout << "Inline addres is: " << &t2 << '\n';
    t++;
    t2++;

    return t;
};

template <> std::string& add_ret<std::string> (std::string& a, std::string& b) {

    return a;
}

template <typename T> T maximum(T a, T b);
template <> const char* maximum<const char *> (const char* a, const char *b);
template <> std::string& maximum<std::string&> (std::string& a, std::string& b);

template <typename T>
requires std::integral<T> T add(T a, T b) {return a + b;}


class Name {
    private:
        std::string name;

    public:
        Name(const char *name) {this->name = name;}
        std::string get_name(){return name;}
        void change_name(const char *n_name) {this->name = n_name;}
};

class Dog : public Name {


};

template <typename T>
requires requires (T m) { m.get_name();}
void change_name(T& t, const char *n_name) {
    t.change_name(n_name);
}

class Sortable {

};

class Type : public Sortable {

};

// template <typename Cont>
//     requires Sortable<Cont>
// void sort(Cont& container);

template <typename T>
    requires std::is_standard_layout_v<T> && std::is_trivial_v<T>
    void buf(T v);

template <typename T>
concept correct_value = std::is_integral_v<typename T::value_type>;

template <typename T>
concept div_two = requires(T t) {t % 2 == 0;};


template <typename T>
requires (!correct_value<T>)
    void func(T& t);

template <typename T>
requires (requires (T t) {t % 2 == 0;}) void print_int(T t) {
    std::cout << t << '\n';
}



int main() {
    int a {5};
    int b {9};

    std::cout << "Main addres is: " << &a << '\n';
    std::cout << "Main addres is: " << &b << '\n';
    add_ret<int>(a, b);

    int c = add(a, b);
    std::cout << c << '\n';

    Dog d {"Milo"};
    Name nn{"Bob"};
    std::string bob {"alisa"};

    change_name(d, "Hulio");
    change_name(nn, "Pedro");

    std::cout << d.get_name() << '\n';
    std::cout << nn.get_name() << '\n';

    // buf(1);

    for(int i{10}; i < 100; i+=5) {
        print_int(i);
    }
    // print_int(3.09);
    print_int(short(800));

    return 0;
}
