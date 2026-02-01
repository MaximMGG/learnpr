#include <cstdext/core.h>
#include <stdio.h>
#include <cstdext/container/list.h>
#include <string.h>

typedef enum {
  NUM, MUL, SUB, DIV, ADD, BRACKET_OPEN, BRACKET_CLOSE
} TokenType;

typedef struct {
  TokenType type;
  f64 val;
} Token;

u32 calcExpression(List *l, u32 start, u32 end);
u32 calcCheckBracket(List *l, u32 start, u32 end);
u32 calcCheckPriority(List *l, u32 start, u32 end);

u32 calcCheckPriority(List *l, u32 start, u32 end) {
  u32 tokens_remove = 0;
  u32 find_priority = 0;
  Token *t;
  for(u32 i = start; i < end; i++) {
    t = listGet(l, i);
    if (t->type == MUL || t->type == DIV) {
      if (i == 0) {
	fprintf(stderr, "Brocket expression\n");
	exit(1);
      }
      if (i == l->len - 1) {
	fprintf(stderr, "Brocket expression\n");
	exit(1);
      }
      
      Token *a = listGet(l, i - 1);
      Token *b = listGet(l, i + 1);
      if (t->type == MUL) {
	a->val *= b->val;
      } else {
	a->val /= b->val;
      }
      listRemove(l, i + 1);
      listRemove(l, i);
      tokens_remove += 2;

      DEALLOC(l->allocator, t);
      DEALLOC(l->allocator, b);
      end -= 2;
      i--;
    }
  }
  return tokens_remove;
}

u32 calcExpression(List *l, u32 start, u32 end) {
  end -= calcCheckBracket(l, start, end);
  end -= calcCheckPriority(l, start, end);
  u32 token_remove = 0;
  Token *t;
  u32 i = start;
  while(l->len != 1) {
    t = listGet(l, i);
    if (t->type == ADD || t->type == SUB) {
      if (i == 0) {
	fprintf(stderr, "Broken epression\n");
	exit(1);
      }
      if (i == l->len - 1) {
	fprintf(stderr, "Broken epression\n");
	exit(1);
      }
      Token *a = listGet(l, i - 1);
      Token *b = listGet(l, i + 1);
      if (t->type == ADD) {
	a->val += b->val;
      } else {
	a->val -= b->val;
      }
      listRemove(l, i + 1);
      listRemove(l, i);
      token_remove -= 2;

      DEALLOC(l->allocator, t);
      DEALLOC(l->allocator, b);
      end -= 2;
      continue;
    } else {
      i++;
    }
    if (i >= l->len) {
      break;
    }
  }
  return token_remove;
}
//  "(3 + 2) * 2"
u32 calcCheckBracket(List *l, u32 start, u32 end) {
  Token *t;
  u32 bracket_find_open = 0;
  u32 bracket_find_close = 0;
  u32 bracket_count = 0;
  u32 token_remove = 0;

  u32 i = start;
  while (i != end) {
    t = listGet(l, i);
    if (t->type == BRACKET_OPEN) {
      bracket_find_open = i;
      bracket_count = 1;
      i++;
      break;
    }
    i++;
  }
  if (bracket_count == 0) {
    return 0;
  }
  while (true) {
    if (i > l->len) {
      fprintf(stderr, "Broken expression\n");
      exit(1);        
    }
    t = listGet(l, i);
    if (t->type == BRACKET_OPEN) {
      bracket_count++;
      i++;
      continue;
    }
    if (t->type != BRACKET_CLOSE) {
      i++;
      continue;
    } else {
      if (bracket_count != 1) {
	bracket_count--;
	i++;
	continue;
      } else {
	bracket_find_close = i;
	goto FOUND_CLOSE_BRACKET;
      }
    }
  }
  
FOUND_CLOSE_BRACKET:  
  if (bracket_count == 0) {
    return false;
  } else {
    Token *t = listGet(l, bracket_find_open);
    DEALLOC(l->allocator, t);
    t = listGet(l, bracket_find_close);
    DEALLOC(l->allocator, t);
    listRemove(l, bracket_find_open);
    listRemove(l, bracket_find_close);
    token_remove -= 2;
    end -= calcExpression(l, bracket_find_open, bracket_find_close - 2);
  }
  return token_remove;
}

void tokenezeInput(List *l, str input) {
  u32 input_len = strlen(input);
  byte buf[64] = {0};
  u32 buf_i = 0;
  for(u32 i = 0; i < input_len; ) {
    if (input[i] == ' ') {
      i++;
      continue; 
    }
    while(input[i] >= '0' && input[i] <= '9') {
      buf[buf_i++] = input[i++];
      if (i == input_len) {
	break;
      }
    }
    if (buf_i != 0) {
      Token *t = MAKE(l->allocator, Token);
      t->type = NUM;
      t->val = atof(buf);
      memset(buf, 0, 64);
      buf_i = 0;
      listAppend(l, t);
      continue;
    }
    if (input[i] == '+') {
      Token *t = MAKE(l->allocator, Token);
      t->type = ADD;
      listAppend(l, t);
    } else if (input[i] == '-') {
      Token *t = MAKE(l->allocator, Token);
      t->type = SUB;
      listAppend(l, t);
    } else if (input[i] == '*') {
      Token *t = MAKE(l->allocator, Token);
      t->type = MUL;
      listAppend(l, t);
    } else if (input[i] == '/') {
      Token *t = MAKE(l->allocator, Token);
      t->type = DIV;
      listAppend(l, t);
    } else if (input[i] == '(') {
      Token *t = MAKE(l->allocator, Token);
      t->type = BRACKET_OPEN;
      listAppend(l, t);
    } else if (input[i] == ')') {
      Token *t = MAKE(l->allocator, Token);
      t->type = BRACKET_CLOSE;
      listAppend(l, t);
    } else {
      fprintf(stderr, "Broken expression");
    }
    i++;
  }
}

void tokenDestroy(List *l) {
  for(u32 i = 0; l->len; i++) {
    DEALLOC(l->allocator, listGet(l, i));
  }
}

#define CASE_COUNT 7

str test_case[] = {
  "2 + 3",
  "2 - 3",
  "2 * 3",
  "2 / 3",
  "2 * 3 + 1",
  "3 / 2 - 1",
  "(3 + 2) * 2",
  "3 + 2 * 2",
  "2 * (3 + 3 * (1 + 7)) - 6"};


int main(i32 argc, str *argv) {
  /* if (argc > 2) { */
  /*   fprintf(stderr, "Usage calc [expression]\n"); */
  /*   return 1; */
  /* } */

  for (i32 i = 0; i < CASE_COUNT; i++) {
    List *l = listCreate(heap_allocator, PTR);
  
    tokenezeInput(l, test_case[i]);
    calcExpression(l, 0, l->len);

    Token *res = listGet(l, 0);
    printf("Result of expression %s -> %lf\n", test_case[i], res->val);
    listDestroy(l);
  }
  return 0;
}
