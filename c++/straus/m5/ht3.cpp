#include <iostream>
#include <vector>

#define BUL 2
bool gues = false;

bool not_contain(int& a, std::vector<int> &v) {
    for(int i = 0; i < v.size(); i++) {
        if (a == v[i])
            return false;
    }

    return true;
}

std::vector<int> get_rand_vector() {
    srand(time(NULL));
    std::vector<int> rand_v;

    for(int i = 0; i < 4; i++) {
        int r = rand() % 10;
        if (not_contain(r, rand_v)) {
            rand_v.push_back(r);
        }
    }
    gues = false;
    return rand_v;
}

std::vector<int> rand_v;

int random_func() {
    if (gues) {
        rand_v = get_rand_vector();
    } 

    std::cout << "We guesed some numer XXXX conteins inly four unque numbers\n";
    std::cout << "Try to gess it\n";
    int num {};
    std::cin >> num;
    if (num == 0 || num < 1000) {
        std::cerr << "Incorect number, try agane\n";
        return 0;
    }
    std::vector<int> u_numb {};

    u_numb.push_back(num / 1000);
    num %= 1000;
    u_numb.push_back(num / 100);
    num %= 100;
    u_numb.push_back(num / 10);
    num %= 10;
    u_numb.push_back(num);
    int bul {};
    int caw {};

    for(int i = 0; i < rand_v.size(); i++) {
        for(int j = 0; j < u_numb.size(); j++) {
            if (u_numb[i] == rand_v[j] && j == i) {
                bul++;
            } else if (u_numb[i] == rand_v[j]) {
                caw++;
            }
        }
    }
    std::cout << bul << " bul and " << caw << " cow\n";
    if (bul == 4) {
        return BUL;
    }

    return 1;
}

int main() {
    gues = true;
    while(1) {
        int r_f = random_func();
        if (r_f == 0) {
            random_func();
        } else {
            if (r_f == BUL) {
                int answer {};
                std::cout << "Do you want play agane? 1 - yes, 0 - no\n";
                std::cin >> answer;
                if (answer == 1) {
                    gues = false;
                    continue;
                } else {
                    break;
                }

            } else if (r_f == 1) {
                std::cout << "You so close, continue\n";
                continue;
            }
        }
    }

    return 0;
}
