#include <stdio.h>
#include <stdarg.h>

void print_num(int a);

void arg_print(int a, ...) {
  va_list li;
  va_start(li, a);  

  int res = (int)va_arg(li, int);
  print_num(res);
  va_end(li);
}

void print_num(int a) {
  printf("%d", a);
}
