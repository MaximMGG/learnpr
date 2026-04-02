#include <string>
#include <iostream>
#include <cstdlib>
#include <cstring>

void foo1();
void foo2();
void foo3();
void foo4();
void foo5();
void foo6();



int main() {

    std::string msg {"Syper msg"};
    std::string s2 {"OOOO b ijijij"};

    std::cout << msg << '\n';
    msg += " and more";

    std::cout << msg << '\n';
    msg.append(" A");
    msg.append(" " + s2);

    std::cout << msg << '\n';

    msg.append(s2, 5, 1);
    std::cout << msg << '\n';
    msg.append(34, '!');
    std::cout << msg << '\n';

    for(int i = 0; i < msg.length(); i++) {
        std::cout << msg[i];
    }
    char& a = msg.front();
    char *pa = &a;
    std::cout.put('\n');
    std::cout.flush();

    std::cout << pa << '\n';

    long find_t = msg.find_first_of("OOOO");
    std::cout << "OOOO finding at position : " << find_t << '\n';
    std::string n_msg{msg.substr(find_t, 4)};
    std::cout << n_msg << '\n';
    std::cout << "char : " << msg.at(12) << '\n'; 
    std::cout << "char : " << msg[12] << '\n'; 
    msg.at(12) = 'B';
    std::cout << "char : " << msg.at(12) << '\n'; 
    msg[12] = 'C';
    std::cout << "char : " << msg.at(12) << '\n'; 


    std::string c {"one"};
    c.reserve(100);
    std::cout << "one : " << c << '\n';
    c.resize(8);
    c[0] = 'O';
    c[3] = 'O';
    c[4] = 'n';
    c[5] = ' ';
    c[6] = 'b';
    c[7] = ' ';
    c.resize(25);
    c[17] = '8';

    std::cout << "one : " << c << '\n';
    std::cout << "copacity of one : " << c.capacity() << '\n';
    std::cout << "one : " << c << '\n';
    c += " thing to do with another thing, but I don't now what acthactly I wont to do...";
    std::cout << "copacity of changed one : " << c.capacity() << '\n';

    std::cout << "one : " << c << '\n';
    c.shrink_to_fit();
    std::cout << "copacity of shrinked one : " << c.capacity() << '\n';

    std::cout << "one : " << c << '\n';

    std::cout << "Max size of string could be : " << c.max_size() << '\n';
    c.clear();
    std::cout << "one : " << c << " and capacity : " << c.capacity() << '\n';
    std::cout << std::boolalpha << c.empty() << '\n';

    std::string hw {"H world!"};
    hw.insert(1, "ello", 4);
    hw.replace(1, 1, "o");
    hw.erase(4, 1);

    std::cout << hw << '\n';
    // hw.compare();

    const std::basic_string<char>&  aaa {"ee"};
    std::cout << aaa << '\n';

    std::string str5 {"Hello"};
    std::string msg1 {"Hello World"};
    std::cout << "Comparing Hello to World : " << msg1.compare(6, 5, str5) << '\n'; 
    std::cout << "Comparing Hello to World : " << str5.compare("World") << '\n'; 


    foo1();
    foo2();
    foo3();
    foo4();
    foo5();
    foo6();


    return 0;
}


void foo1() {

    std::string str1 {"Finding Nemo"};
    std::string str2 {"The Horse was Found in the Fields Searching For Food"};

    std::cout << "str1 : " << str1 << '\n';
    std::cout << "Replacing..." << '\n';

    str1.replace(0, 7, str2, 34, 13);

    std::cout << "str1 : " << str1 << '\n';

    std::basic_string<char> a {"HEllo"};


    std::string str3 {"Climbing Kirimanjaro"};
    char txt1[15]{};

    str3.copy(txt1, 11, 9);

    std::cout << str3 << '\n';
    std::cout << "Txt : " << txt1 << '\n';

    str3.resize(10, 'f');
    std::cout << str3 << '\n';


    std::string str_a {"This is a string stored in A"};
    std::string str_b {"This is a string stored in B and it's really great to be able to do that."};

    std::cout << "str_a : " << str_a << '\n';
    std::cout << "str_b : " << str_b << '\n';
    std::cout << "str_a.size() : " << str_a.size() << '\n'; 
    std::cout << "str_a.capacity() : " << str_a.capacity() << '\n'; 
    std::cout << "str_b.size() : " << str_b.size() << '\n'; 
    std::cout << "str_b.capacity() : " << str_b.capacity() << '\n'; 

    std::cout << "Swapping..." << '\n';

    str_a.swap(str_b);

    std::cout << "str_a : " << str_a << '\n';
    std::cout << "str_b : " << str_b << '\n';
    std::cout << "str_a.size() : " << str_a.size() << '\n'; 
    std::cout << "str_a.capacity() : " << str_a.capacity() << '\n'; 
    std::cout << "str_b.size() : " << str_b.size() << '\n'; 
    std::cout << "str_b.capacity() : " << str_b.capacity() << '\n'; 



}


void foo2() {
    std::string str1{"Water was poured in the header"};
    std::string str2{"ter"};

    size_t f_pos = str1.find(str2);
    std::cout << "ter find in position : " << f_pos << '\n';
    f_pos = str1.find_last_of(str2);
    std::cout << "ter find in position : " << f_pos << '\n';
    str2 = "chicken";
    f_pos = str1.find(str2);
    long f_pos_long = str1.find(str2);
    std::cout << "chicken find in position : " << f_pos << '\n';
    std::cout << "std::string::npos : " << std::string::npos << '\n';
    std::cout << "long pos of find : " << f_pos_long << '\n';

}

void foo3() {
     std::cout << "Turning numbers to std::basic_string<CharT> : " << '\n';
     float float_val {123.88f};
     double double_val {.1838438e6};
     int int_val {888};

     std::string float_str {std::to_string(float_val)};
     std::string double_str {std::to_string(double_val)};
     std::string int_str {std::to_string(int_val)};

     std::cout << "float val : " << float_val << " and string_float_val : " << float_str << '\n';
     std::cout << "double val : " << double_val << " and string_double_val : " << double_str << '\n';
     std::cout << "int val : " << int_val << " and string_int_val : " << int_str << '\n';

     std::cout << "Transformation back to digits : " << '\n';

     float new_f = std::stof(float_str);
     double new_d = std::stod(double_str);
     int new_i = std::stoi(int_str);

     std::cout << "new_f : " << new_f << '\n';
     std::cout << "new_d : " << new_d << '\n';
     std::cout << "new_i : " << new_i << '\n';



}


void foo4() {
    std::string lit {
R"(Clean the house
wolk with dogs
play games
make do dinner)"};
    std::cout << lit << '\n';

    std::string escape {R"("\\" escapes)"};
    std::cout << escape << '\n';

    std::string sep {R"--(Interest sitypation "(Spacy)")--"};

    std::cout << sep << '\n';

}

void foo5() {
    std::string m1{"Hello world!"};
    std::string& m2 = m1;
    std::string *m3 = new std::string {"Hello world!"};
    char *m4 = (char *)malloc(sizeof(char) * 20);
    std::strcpy(m4, "Hello world!");

    char *p1 = m1.data();
    char *p2 = m2.data();
    char *p3 = m3->data();
    std::cout << "&m1[0] " << (void *)p1 << '\n';
    std::cout << "&m2[0] " << (void *)p2 << '\n';
    std::cout << "&m3[0] " << (void *)p3 << '\n';
    std::cout << "malloc char * " << (void *)m4 << '\n';



    delete m3;
    free(m4);
}

//std::string_literal
void foo6() {
    std::string_view sv {"Hello"};
    std::string_view sv1 {sv};
    std::string_view sv2 {sv};

    std::cout << "size of std::string_view : " << sizeof(std::string_view) << '\n';
    std::cout << "size of std::string: " << sizeof(std::string) << '\n';

    std::cout << "sv : " << sv << '\n';
    std::cout << "p_sv  : " << (void *)sv.data() << '\n';
    std::cout << "p_sv1  : " << (void *)sv1.data() << '\n';
    std::cout << "p_sv2  : " << (void *)sv2.data() << '\n';

    const char *msg {"Test message for remove chars in string_view"};
    std::string_view v {msg};
    std::cout << "msg : " << msg << '\n';
    std::cout << "v : " << v << '\n';
    std::cout << "v.length(): " << v.length() << ' ';
    std::cout << "std::strlen(v): " << std::strlen(v.data()) << '\n';
    std::cout << "msg len is : " << std::strlen(msg) << '\n';

    v.remove_prefix(5);
    v.remove_suffix(11);

    std::cout << "v.length(): " << v.length() << ' ';
    std::cout << "std::strlen(v): " << std::strlen(v.data()) << '\n';

    std::cout << "msg len is : " << std::strlen(msg) << '\n';

}

