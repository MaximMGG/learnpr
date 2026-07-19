
#include <stdarg.h>
#include <stdio.h>

void one() {
  printf("One");
}
void two() {
  printf("Two");
}
void tree() {
  printf("Tree");
}
void four() {
  printf("Four");
}


void super_foo(const char *names, ...) {
  printf("Funcs %s\n", names);
  va_list li;
  va_start(li, names);

  void (*p)();
  while(true) {
    p = (void (*)())va_arg(li, void *);
    if (p == nullptr) {
      break;
    }
    printf("Func -> %p\n", p);
    p();
  }
}

#define TEST_LIST(...)                                                         \
  int main() { super_foo(#__VA_ARGS__, __VA_ARGS__, nullptr); return 0; }

TEST_LIST(one, two, tree, four);
