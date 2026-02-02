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


u32 calcCheckBracket(List *l, u32 start, u32 end) {
  u32 bracket_find_open = 0;
  u32 bracket_find_close = 0;
  u32 bracket_count = 0;
  u32 token_remove = 0;
  Token *t = null;
  u32 i = 0;

  while(i < l->len) {
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
  while(i < l->len) {
	t = listGet(l, i);
	if (t->type == BRACKET_OPEN) {
	  bracket_count++;
	  i++;
	  continue;
	}
	if (t->type == BRACKET_CLOSE) {
	  if (bracket_count == 1) {
		bracket_find_close = i;
		Token *open_bracket = listGet(l, bracket_find_open);
		Token *close_bracket = listGet(l, bracket_find_close);
		listRemove(l, bracket_find_close);
		listRemove(l, bracket_find_open);
		token_remove += 2;
		DEALLOC(l->allocator, open_bracket);
		DEALLOC(l->allocator, close_bracket);
		//token_remove += calcExpression(l, bracket_find_open, bracket_find_close - 2);
	  } else {
		bracket_count--;
		i++;
		continue;
	  }
	}
	i++;
  }
  
  if (bracket_find_close == 0) {
	fprintf(stderr, "Broken expression\n");
	return 0;
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
  for(u32 i = 0; i < l->len; i++) {
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


void delete_token_test(List *l) {
  for(u32 i = 0; i < l->len; i++) {
	Token *t = listGet(l, i);
	if (t->type == BRACKET_OPEN || t->type == BRACKET_CLOSE) {
	  printf("Remove bracket\n");
	  listRemove(l, i);
	  DEALLOC(l->allocator, t);
	  i--;
	}
  }
}

int main(i32 argc, str *argv) {
  /* if (argc > 2) { */
  /*   fprintf(stderr, "Usage calc [expression]\n"); */
  /*   return 1; */
  /* } */

  List *l = listCreate(heap_allocator, PTR);
  
  str test = test_case[8];
  tokenezeInput(l, test);
  //delete_token_test(l);
  calcCheckBracket(l, 0, l->len);
  tokenDestroy(l);

  listDestroy(l);
  
  return 0;
}
