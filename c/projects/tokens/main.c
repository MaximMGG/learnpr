#include <stdio.h>
#include "token.h"



int main() {
  Token *t = tokenCreate("BTCUSDT");

  i32 iter = 20;
  while(iter > 0) {
    tokenRequest(t);
    str s = tokenToString(t);
    printf("%s\n", s);
    dealloc(s);
    iter--;
  }

  tokenDestroy(t);
  return 0;
}
