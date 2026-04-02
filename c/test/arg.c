#include <stdio.h>
#include <stdarg.h>


void arg_print(int a, ...) {
  va_list li;
  va_start(li, a);

  char buf[4] = {0};

  int res = va_arg(li, char);
}
