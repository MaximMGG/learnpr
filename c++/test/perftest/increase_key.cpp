#include <iostream>




bool increase_key(std::string &key) {

    int i = key.size() - 1;

    while(true) {

        if (key[3] == '9') {
            break;
        }

        if (key[i] == '9') {
            key[i] = '0';
            i--;
            continue;
        } else {
            key[i]++;
            return true;
        }
    }
    return false;
}



int main() {

    std::string key = "Key000000";

    while(increase_key(key)) {
        std::cout << "Key -> " << key << '\n';
    }

}
