#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

int str_len_1(char *msg) {
  int i = 0;
  for (; msg[i] != 0; i++);
  return i;
}

int str_len_2(char *msg) {
  int i = 0;
  while((*msg)++ != 0) i++;

  return i;
}

int str_len_3(char *msg) {
  char *tmp = msg;
  while(*tmp != 0) tmp++;

  return tmp - msg;
}

int main() {
  char buf[128] = {0};
  int read_bytes = read(STDIN_FILENO, buf, 128);
  buf[read_bytes - 1] = 0;
  
  int length = (int)atol(buf);
  printf("Length is: %d\n", length);

  char *msg = malloc(length + 1);
  
  memset(msg, 0, length + 1);
  memset(msg, 46, length / 2);

  clock_t beg;
  clock_t end;

  beg = clock();
  int len_1 = str_len_1(msg);
  end = clock();
  printf("Len 1: %d, time: %ld\n", len_1, end - beg);
  beg = clock();
  int len_2 = str_len_2(msg);
  end = clock();
  printf("Len 2: %d, time: %ld\n", len_1, end - beg);
  beg = clock();
  int len_3 = str_len_3(msg);
  end = clock();
  printf("Len 3: %d, time: %ld\n", len_1, end - beg);
  beg = clock();
  int len_4 = strlen(msg);
  end = clock();
  printf("Len 4: %d, time: %ld\n", len_1, end - beg);

  free(msg);

  return 0;
}
