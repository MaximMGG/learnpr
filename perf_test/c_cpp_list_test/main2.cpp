#include <vector>
#include <stdio.h>

#define COUNT 2000000000

int main() {

  std::vector<int> l;


  for(int i = 0; i < COUNT; i++) {
    l.push_back(i);
  }

  printf("Len: %lu, last item: %d\n", l.size(), l[COUNT - 1]);

}
