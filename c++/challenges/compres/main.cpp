#include <algorithm>
#include <cstdint>
#include <iostream>
#include <fstream>


struct Node {
    char value = 0;
    std::uint32_t weight = 0;
    bool leaf = false;
    Node *left = nullptr;
    Node *right = nullptr;

    Node();
    Node(char value, std::uint32_t weight, bool leaf) : value(value), weight(weight), leaf(leaf) {}
    ~Node(){}
};

struct Huffman {
    Node *head{};

    Huffman(const char *text) {

    }
    ~Huffman();
private:

    Node *buildHuffmanTree(const char *text) {

        return NULL;
    }
};




int main() {

    return 0;
}
