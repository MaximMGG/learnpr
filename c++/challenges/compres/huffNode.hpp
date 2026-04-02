#ifndef HUFFNODE_HPP
#define HUFFNODE_HPP

#include <vector>



class HuffNode {
public:
    char element;
    int waight;

    HuffNode();
    HuffNode(HuffNode *next);
    HuffNode(char el, int val);
    ~HuffNode();

    bool operator==(HuffNode &second);
    bool operator>(HuffNode &second);
    bool operator<(HuffNode &second);

private:
};

void sortNode(std::vector<HuffNode> *l);

class Node {
public:
    char element;
    int waight;
    Node *left;
    Node *right;
    bool is_leaf;

    Node(Node *left, Node *right, char element = 0, int waight = 0, bool is_leaf = false);
    ~Node();

};


class HuffTree {
public:
    std::vector<HuffNode> *tree;
    Node *root;

    HuffTree(std::vector<HuffNode> *tree);
    ~HuffTree();
    char *encode();
    char *decode();

    void print();
};
#endif //HUFFNODE_HPP
