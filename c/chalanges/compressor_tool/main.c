#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <cstdext/io/logger.h>
#include <cstdext/container/list.h>

typedef struct Node {
    i8 val;
    u32 weight;
    bool leaf;
    struct Node *left;
    struct Node *right;

} Node;


Node *buildHaffmanTree(list *chars, list *weights) {
    Node *cur_node = make(Node);
    Node *left = make(Node);
    left->val = *(i8 *)list_get(chars, 0);
    left->weight = *(u32 *)list_get(weights, 0);
    left->leaf = true;
    left->left = null;
    left->right = null;
    Node *right = make(Node);
    right->val = *(i8 *)list_get(chars, 1);
    right->weight = *(u32 *)list_get(weights, 1);
    right->leaf = true;
    right->left = null;
    right->right = null;
    cur_node->leaf = false;
    cur_node->weight = right->weight + left->weight;
    cur_node->left = left;
    cur_node->right = right;

    u32 index = 2;
    while(index < chars->len) {
        u32 tmp_weight = *(u32 *)list_get(weights, index);
        if (cur_node->weight < tmp_weight) {
            left = cur_node;
            right = make(Node);
            right->weight = tmp_weight;
            right->val = *(i8 *)list_get(chars, index);
            right->leaf = true;
        } else {
            right = cur_node;
            left = make(Node);
            left->weight = tmp_weight;
            left->val = *(i8 *)list_get(chars, index);
            left->leaf = true;
        }
        cur_node = make(Node);
        cur_node->weight = left->weight + right->weight;
        cur_node->leaf = false;
        cur_node->left = left;
        cur_node->right = right;
        index++;
    }

    return cur_node;
}



void sort_lists(list *chars, list *weights) {

    u32 start = 0;
    u32 *data = (u32 *) weights->data;
    i8 *c_data = (i8 *) chars->data;


    while(start < weights->len) {
        u32 min_weights = UINT32_MAX;
        u32 index = 0;
        for(i32 i = start; i < weights->len; i++) {
            if (data[i] < min_weights) {
                min_weights = data[i];
                index = i;
            }
        }

        i8 tmp_char = c_data[start];
        u32 tmp_weight = data[start];
        c_data[start] = c_data[index];
        data[start] = data[index];
        c_data[index] = tmp_char;
        data[index] = tmp_weight;
        start += 1;
    }
}


i32 list_contain_index(list *chars, i8 c) {
    i8 *tmp = chars->data;
    for(i32 i = 0; i < chars->len; i++) {
        if (tmp[i] == c) {
            return i;
        }
    }
    return -1;
}

void print_tree(Node *head) {
    Node *leaf;
    while(head->left != null || head->right != null) {
        printf("Step weight: %d\n", head->weight);
        if (!head->leaf) {
            if (head->left->leaf) {
                leaf = head->left;
                head = head->right;
            } else if (head->right->leaf) {
                leaf = head->right;
                head = head->left;
            } else {
                return;
            }
        }
        printf("Leaf: %c - %d\n", leaf->val, leaf->weight);
    }
}


int main() {
    i32 fd = open("./test/test2.txt", O_RDONLY);
    if (fd < 0) {
        log(ERROR, "Cant read file");
        return 1;
    }

    struct stat st;
    fstat(fd, &st);

    i8 *buf = alloc(st.st_size + 1);
    i32 read_bytes = read(fd, buf, st.st_size);
    if (read_bytes != st.st_size) {
        log(ERROR, "Read bytes not equalse st.st_size %d - %d", read_bytes, st.st_size);
        close(fd);
        return 1;
    }

    list *chars = list_create(I8);
    list *weights = list_create(U32);

    for(i32 i = 0; i < read_bytes; i++) {
        i32 index = list_contain_index(chars, buf[i]);
        if (index == -1) {
            list_append(chars, &buf[i]);
            u32 tmp = 1;
            list_append(weights, &tmp);
        } else {
            u32 *tmp = list_get(weights, index);
            *tmp += 1;
        }
    }

    sort_lists(chars, weights);
    Node *head = buildHaffmanTree(chars, weights);
    print_tree(head);

    return 0;
}
