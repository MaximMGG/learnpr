#include <stdio.h>
#include <fcntl.h>
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
      printf("LAYER: %d, going left, ferq: %u\n", level, base->freq);
      wolk_huffman_tree((Node *)base->left, level + 1);
    }
    if (base->right != null) {
      printf("LAYER: %d, going right, ferq: %u\n", level, base->freq);
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

void build_lookup_table_help(Node *base, u32 *path, u32 path_len, map *lookup) {
  if (base->is_leaf) {
    u32 *tmp = da_create_from_arr(path, path_len);
    map_put(lookup, &base->letter, tmp);
  } else {
    if (base->left != null) {
      path[path_len] = 0;
      build_lookup_table_help((Node *)base->left, path, path_len + 1, lookup);
    }
    if (base->right != null) {
      path[path_len] = 1;
      build_lookup_table_help((Node *)base->right, path, path_len + 1, lookup);
    }
  }
}

map *build_lookup_table(Node *base) {
  map *lookup = map_create(U8, PTR, null, null);
  u32 *path = make_many(u32, 1024);
  build_lookup_table_help(base, path, 0, lookup);
  dealloc(path);
  return lookup;
}

void destroy_lookup_table(map *lookup) {
  iterator *it = map_iterator(lookup);

  while(map_it_next(it)) {
    da_destroy(it->val);
  }
  map_it_destroy(it);
  map_destroy(lookup);
}

str encrypt(str text, map *lookup, u32 *encrypt_len) {
  u32 text_len = strlen(text);
  strbuf *sb = strbuf_create();
  i8 b = 0;
  u32 offset = 0;

  for(i32 i = 0; i < text_len; i++) {
    KV kv = map_get(lookup, &text[i]);

    if (kv.key == null) {
      fprintf(stderr, "Lookup table broken!!!\n");
      exit(1);
    }

    u32 *path = kv.val;
    for(i32 j = 0; j < DA_LEN(path); j++) {
      if (path[j] == 0) {
        b |= 0;
      } else {
        b |= 1;
      }
      if (offset == 7) {
        strbuf_append_byte(sb, b);
        offset = 0;
        b = 0;
      } else {
        b <<= 1;
        offset++;
      }
    }
  }

  str res = alloc(sb->len + 1);
  *encrypt_len = sb->len;
  memset(res, 0, sb->len + 1);
  strncpy(res, sb->data, sb->len);
  strbuf_destroy(sb);

  return res;
}

str build_header(map *freq) {
  strbuf *sb = strbuf_create();
  iterator *it = map_iterator(freq);
  while(map_it_next(it)) {
    strbuf_append_byte(sb, *(i8 *)it->key);
    strbuf_append_byte(sb, ',');
    strbuf_append_format(sb, "%u", *(u32 *)it->val);
    strbuf_append_byte(sb, ',');
  }
  strbuf_append_byte(sb, (i8)254);

  map_it_destroy(it);
  str header = str_copy(sb->data);
  strbuf_destroy(sb);
  return header;
}

str create_encrypt_file(str file_name) {
  i32 index = str_find(file_name, ".");
  if (index == -1) {
    fprintf(stderr, "Cant find '.' in file name\n");
    exit(1);
  }

  i8 buf[128] = {0};
  strncpy(buf, file_name, index);

  str new_file_name = str_create_fmt("%s.hf", buf);
  return new_file_name;
}

void write_to_encrypt_file(str file_name, str header, str text, u32 encrypt_len) {
  i32 fd = open(file_name, O_CREAT | O_TRUNC | O_RDWR, 0o666);
  if (fd <= 0) {
    fprintf(stderr, "Can't create file: %s\n", file_name);
    exit(1);
  }

  i32 write_bytes = write(fd, header, strlen(header));
  if (write_bytes != strlen(header)) {
    fprintf(stderr, "Write bytes: %d != header len: %lu\n", write_bytes, strlen(header));
    exit(1);
  }
  write_bytes = write(fd, text, encrypt_len);
  if (write_bytes != encrypt_len) {
    fprintf(stderr, "Write bytes: %d != text len: %u\n", write_bytes, encrypt_len);
    exit(1);
  }
  close(fd);
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
  map_it_destroy(it);

  Node *base = build_huffman_tree(pq);

  map *lookup = build_lookup_table(base);
  it = map_iterator(lookup);
  while(map_it_next(it)) {
    u32 *path = it->val;
    printf("Char: %c -> [", *(i8 *)it->key);
    for(i32 i = 0; i < DA_LEN(path); i++) {
      printf("%d ", path[i]);
    }
    printf("]\n");
  }
  map_it_destroy(it);

  u32 encrypt_len = 0;
  str encrypt_text = encrypt(text, lookup, &encrypt_len);
  str header = build_header(freq);
  str new_file_name = create_encrypt_file(file_name);
  write_to_encrypt_file(new_file_name, header, encrypt_text, encrypt_len);


  destroy_huffman_tree(base);
  priority_queue_destroy(pq);
  map_destroy(freq);
  destroy_lookup_table(lookup);
  dealloc(text);
  dealloc(encrypt_text);
  dealloc(new_file_name);
  dealloc(header);
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
