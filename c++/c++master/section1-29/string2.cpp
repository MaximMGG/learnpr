#include <cstring>
#include <string>
#include <iostream>
#include <iomanip>


int main() {

    const char *test_msg = "laifj";

    std::string tok {"ijasdlfij83820"};


    std::cout << "After skiping > " << std::strspn(tok.c_str(), test_msg) << '\n';
    std::cout << tok.substr(std::strspn(tok.c_str(), test_msg)) << '\n';


    std::cout << "std::strpbrk\n";

    const char *str = "hello world, friend of mine!";
    const char *sep = " ,!";

    unsigned int cnt = 0;
    do {
        str = std::strpbrk(str, sep);
        std::cout << std::quoted(str) << '\n';
        if (str)
            str += std::strspn(str, sep);
        cnt++;

    } while(str && *str);


    std::cout << "std::strstr--------\n";

    const char *tgt = "This is message for strstr test!";
    const char *needl = "strstr";
    const char *result = std::strstr(tgt, needl);
    std::string tgt_s {tgt};

    std::cout << "Find at : " << result - tgt << " : " << std::strstr(tgt, needl) << '\n';
    std::cout << "sustring : " << tgt_s.substr(result - tgt) << '\n';



    return 0;
}
