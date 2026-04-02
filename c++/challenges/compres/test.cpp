#include <iostream>
#include <fstream>
#include <map>


#define FILE "./test.txt"

int main() {
    std::map<char, int> tree;
    std::fstream file(FILE);
    if (!file.is_open()) {
        std::cerr << "Can't open file: " << FILE << '\n';
        return 1;
    }

    file.seekg(0, std::ios::end);
    long file_size = file.tellg();
    file.seekg(0, std::ios::beg);

    char *buf = new char[file_size];
    file.read(buf, file_size);

    long total{};
    for(int i = 0; i < file_size; i++) {
        auto it = tree.find(buf[i]);
        if (it == tree.end()) {
            tree[buf[i]] = 1;
        } else {
            it->second += 1;
        }
        total++;
    }

    auto it = tree.begin();
    for( ; it != tree.end(); it++) {
        std::cout << "Char: " << it->first << ", value - " << it->second << '\n';
    }
    delete [] buf;

    return 0;
}
