#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cctype>

#define NL std::cout << std::endl;
//questions--------------------------------------


void song(const char *name = "O, My Papa?", int times = 1) {
    std::cout << name << " " << times << std::endl;
}

void iquote(int x) {
    std::cout << "\"" << x << "\"" << std::endl;
}
void iquote(double x) {
    std::cout << "\"" << x << "\"" << std::endl;
}
void iquote(std::string x) {
    std::cout << "\"" << x << "\"" << std::endl;
}

typedef struct {
    char maker[40];
    float height;
    float width;
    float length;
    float volume;
} box;

void show(box& x) {
    printf( "Name is: %s\nheight: %f\nwidth: %f\nlength: %f\nvolume: %f\n", 
            x.maker, x.height, x.width, x.length, x.volume);
}

void set_volume(box& x) {
    x.volume = x.length * x.width * x.height;
}

double mass(double density, double volume = 1.0);

void repeat(int x, std::string s);
void repeat(std::string s);

int average(int, int);
double average(double, double);
char mangle(char*);
// char *mangle(char*);


template <typename T>
T bigger (T a, T b) {
    return a > b ? a : b;
}

template <> box bigger<box> (box a, box b) {
    return a.volume > b.volume ? a : b;
}



//questions--------------------------------------
//exersizes========================================

void print_count(const char *str, int x = 0) {
    static int count = 0;
    if (x == 0) {
        std::cout << str << std::endl;
    } else {
        for(int i = 0; i < count; i++) {
            std::cout << str << std::endl;
        }
    }
    count++;
}

typedef struct {
    char box_name[40];
    double weight;
    int calory;
} CandyBar;

void show_bar(CandyBar& bar) {
    printf("Bar name: %s\nWeight is: %lf\nCalory is: %i\n", bar.box_name, bar.weight, bar.calory);
}


CandyBar &create_candybar(CandyBar& bar, const char *s = "Millennium Munch", double w = 2.80, int c = 350) {
    strncpy(bar.box_name, s, 40);
    bar.weight = w;
    bar.calory = c;
    return bar;
}

std::string& to_upper(std::string& s) {
    for(int i = 0; i < s.size(); i++) {
        if (isalpha(s[i])) {
            s[i] = toupper(s[i]);
        }
    }
    return s;
}

typedef struct {
    char *str;
    int ct;
} stringy;


void set(stringy& str, char *t) {
    int len = strlen(t);
    char *temp = new char[len + 1];
    str.str = temp;
    strcpy(str.str, t);
    str.str[len] = '\0';
    str.ct = len;
}
void show(stringy& str, int c = 1) {
    for (int i = 0; i < c; i++)
        std::cout << str.str << std::endl;
}

void show(const char *s, int c = 1) {
    for (int i = 0; i < c; i++)
        std::cout << s << std::endl;
}

int main2() {
    stringy beany;
    char testing[] = "Reality isn't what it used to be.";
    set(beany, testing);
    show(beany);
    show(beany, 2);
    testing[0] = 'D';
    testing[1] = 'u';
    show(testing);
    show(testing, 3);
    show("Done!");
    return 0;
}

template <typename T>
T max5(T t[5]) {
    T temp = 0;
    for(int i = 0; i < 5; i++) {
        temp = t[i] > temp ? t[i] : temp;
    }
    return temp;
}

template <typename T>
T maxn(T t[], int c) {
    T temp = 0;
    for(int i = 0; i < c; i++) {
        temp = t[i] > temp ? t[i] : temp;
    }
    return temp;
}

template <> const char* maxn<const char*>(const char *list[], int c) {
    const char *temp = "";
    for(int i = 0; i < c; i++) {
        if (strlen(list[i]) > strlen(temp)) {
            temp = list[i]; 
        } else if (strlen(list[i]) == strlen(temp)) {
            continue;
        }
    }
    return temp;
}

template <typename T>
T SumArray(T t[], int c) {
    T sum = 0;
    for (int i = 0; i < c; i++) {
        sum += t[i];
    }
    std::cout << "Total is: " << sum << " count of sumbjects is: " << c << std::endl;
    return sum;
}













//exersizes========================================


int main() {

    iquote(2);
    iquote(3.0);
    iquote("Hello");

    box box_t {"Julia", 20.2, 30.9, 123.1, 2.0};
    show(box_t);
    set_volume(box_t);
    show(box_t);
    NL;
    print_count("Diamon");
    print_count("Diamon");
    print_count("Diamon");
    print_count("Diamon");
    print_count("Diamon", 1);

    CandyBar bar = create_candybar(bar);
    show_bar(bar);

    std::string s = "littel stri2#1!lsdi*";
    to_upper(s);
    std::cout << s << std::endl;
    main2();

    int arri[5] {1, 2, 5, 4, 0};
    double arrd[5] {2.0, 4.9, 11.0, 324.8, 1.1};

    int arri_m = max5(arri);
    double arrd_m = max5(arrd);
    std::cout << arri_m << std::endl;
    std::cout << arrd_m << std::endl;
    NL;

    int arri2[] {1, 5, 2, 4, 5, 1};
    double arrd2[]{8.0, 3.09, 3434.99, 0.2};
    const char *list[] {"Hello", "Bye", "Param param", "Cat", "qwert irire", "a"};

    int arri2_m = maxn(arri2, 6);
    double arrd2_m = maxn(arrd2, 4);
    const char *arrs = maxn(list, 6);

    std::cout << arri2_m << std::endl;
    std::cout << arrd2_m << std::endl;
    std::cout << arrs << std::endl;

    int sum = SumArray(arri2, 6);

    return 0;
}




