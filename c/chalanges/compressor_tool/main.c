#include <stdio.h>
#include <cstdext/core.h>
#include <cstdext/io/reader.h>
#include <cstdext/io/logger.h>
#include <cstdext/container/map.h>
#include <cstdext/container/priority_queue.h>

typedef struct {
  i8 letter;
  u32 freq;
  bool is_leaf;
  struct Node *left;
  struct Node *right;
} Node;


bool less(ptr _l, ptr _r) {
  Node *l = (Node *)_l;
  Node *r = (Node *)_r;

  if (l->freq < r->freq) {
    return true;
  } else if (l->freq > r->freq) {
    return false;
  }
  if (l->freq == r->freq) {
    if (l->letter < r->letter) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}



i8 *read_file(str file_name) {
  reader *r = reader_create_from_file(file_name);
  i8 *buf = (i8 *)str_copy(r->buf);
  reader_destroy(r);

  return buf;
}


map *build_frequanse(i8 *text) {
  map *m = map_create(U8, U32, null, null);
  u32 text_len = strlen(text);
  for(i32 i = 0; i < text_len; i++) {
    if (map_contain(m, &text[i])) {
      KV kv = map_get(m, &text[i]);
      (*(u32 *)kv.val)++;
    } else {
      u32 tmp_num = 1;
      map_put(m, &text[i], &tmp_num);
    }
  }

  return m;
}

Node *build_huffman_tree(priority_queue *pq) {

  while(pq->len > 1) {
    Node *l = priority_queue_pop(pq);
    Node *r = priority_queue_pop(pq);
    Node *new = make(Node);
    new->is_leaf = false;
    new->left = (struct Node *)l;
    new->right = (struct Node *)r;
    new->letter = 0;
    new->freq = l->freq + r->freq;
    priority_queue_push(pq, new);
  }

  return priority_queue_pop(pq);
}

void wolk_huffman_tree(Node *base, u32 level) {
  if (base->is_leaf) {
    printf("Char: %c, freq: %u, LAYER: %d\n", base->letter, base->freq, level);
  } else {
    if (base->left != null) {
      printf("LAYER: %d, going left, ferq: %u", level, base->freq);
      wolk_huffman_tree((Node *)base->left, level + 1);
    }
    if (base->right != null) {
      printf("LAYER: %d, going right, ferq: %u", level, base->freq);
      wolk_huffman_tree((Node *)base->right, level + 1);
    }
  }
}

void destroy_huffman_tree(Node *base) {
  if (base->left != null) {
    destroy_huffman_tree((Node *)base->left);
  }
  if (base->right != null) {
    destroy_huffman_tree((Node *)base->right);
  }
  dealloc(base);
}

void process_decrypting(str file_name) {
  (void)file_name;
}

void process_encrypting(str file_name) {
  i8 *text = read_file(file_name);
  map *freq = build_frequanse(text);
  priority_queue *pq = priority_queue_create(STRUCT, less);

  iterator *it = map_iterator(freq);

  while(map_it_next(it)) {
    Node *new = make(Node);
    new->letter = *(i8 *)it->key;
    new->freq = *(u32 *)it->val;
    new->is_leaf = true;
    new->left = null;
    new->right = null;
    priority_queue_push(pq, new);
  }
  Node *base = build_huffman_tree(pq);

  wolk_huffman_tree(base, 0);

  destroy_huffman_tree(base);
  priority_queue_destroy(pq);
  map_destroy(freq);
  dealloc(text);
}

int main(i32 argc, str *argv) {
  if (argc == 2) {
    process_encrypting(argv[1]);
  } else if (argc == 3) {
    if (streql(argv[1], "-e")) {
      process_decrypting(argv[2]);
    } else {
      fprintf(stderr, "Usage: compress -e [file_name]");
    }
  }

  return 0;
}
