#include "huffNode.hpp"
#include <iostream>

HuffNode::HuffNode() {}

HuffNode::HuffNode(char el, int val) : element(el), waight(val){}
HuffNode::HuffNode(HuffNode *next) {
    this->element = next->element;
    this->waight = next->waight;
}

HuffNode::~HuffNode() {}
bool HuffNode::operator==(HuffNode &second) {
    if (this->waight == second.waight) {
        return true;
    } else {
        return false;
    }
}

bool HuffNode::operator>(HuffNode &second){
    if (this->waight > second.waight) {
        return true;
    } else {
        return false;
    }
}

bool HuffNode::operator<(HuffNode &second){
    if (this->waight < second.waight) {
        return true;
    } else {
        return false;
    }
}


Node::Node(Node *left, Node *right, char element, int waight, bool is_leaf) {
    this->left = left;
    this->right = right;
    this->element = element;
    this->waight = waight;
    this->is_leaf = is_leaf;
}

Node::~Node(){}

void sortNode(std::vector<HuffNode> *l) {
    for(int i = 0; i < l->size(); i++) {
        HuffNode tmp = (*l)[i];
        int index = i;
        for(int j = i + 1; j < l->size(); j++) {
            if ((*l)[j] < tmp) {
                tmp = (*l)[j];
                index = j;
            }
        }
        (*l)[index] = (*l)[i];
        (*l)[i] = tmp;
    }
}

HuffTree::HuffTree(std::vector<HuffNode> *tree) {
    this->tree = tree;
    sortNode(this->tree);
}

HuffTree::~HuffTree() {}

void HuffTree::print() {
    for(int i = 0; i < this->tree->size(); i++) {
        std::cout << "Char: " << (*tree)[i].element << ", waight: " << (*tree)[i].waight << '\n';
    }
}

char *HuffTree::encode() {

    return NULL;
}
char *HuffTree::decode() {

    return NULL;
}
