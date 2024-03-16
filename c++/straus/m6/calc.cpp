#include <iostream>
#include <vector>

class Token {
    public:
        char kind;
        double value;

};

std::vector<Token> tok;

Token get_token() {
    bool f = false;
    char buf[32]{0};
    int i {0};
    char type;

    char t;
    while(std::cin) {
        std::cin >> t;
        if (t >= '0' && t < '9') {
            buf[i] = t;
            continue;
        }
        if (t == ' ') {
            break;
        }
        switch (t) {
            case '+': 
                type = '+';
                break;
            case '-':
                type = '-';
                break;
            case '*':
                type = '*';
                break;
            case '/':
                type = '/';
                break;
        }

    }
    Token a {type, buf[0] == 0 ? 0 : atof(buf)};
    return a;
}

//   -- 23 + 483 / 11 + (4 + 2) * 7 -- 
//   -- 14 + 7 * 2 - 4 / 4

int main() {
    while(std::cin) {
        Token t = get_token();
        tok.push_back(t);
    }
    return 0;
}


