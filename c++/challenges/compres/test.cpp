#include <fstream>
#include <iostream>
#include <map>
#include <string>

#define FILE "test.txt"

int main() {
    std::map<char, int> tree;
    std::ifstream file(FILE);
    if (!file.is_open()) {
        std::cerr << "Can't open file: " << FILE << '\n';
        return 1;
    }
    std::string line;
    long total{};

    file.seekg(0, std::ios::end);
    long file_size = file.tellg();
    file.seekg(0, std::ios::beg);

    char *buf = new char[file_size];

    file.read(buf, file_size);

    for(int i = 0; i < file_size; i++) {
        auto it = tree.find(buf[i]);
        if (it == tree.end()) {
            tree[buf[i]] = 1;
        } else {
            it->second += 1;
        }
        total++;
    }

    delete [] buf;

    auto it = tree.begin();
    for( ; it != tree.end(); it++) {
        std::cout << "Char: " << it->first << " - Number: " << it->second << '\n';
    }
    std::cout << "Total length: " << total << '\n';

    return 0;
}
