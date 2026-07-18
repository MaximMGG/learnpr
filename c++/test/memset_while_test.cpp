#include <string.h>

#define SIZE 10240000

template <typename T>
void ZERO(T *t, int size) {
  if (((sizeof(*t) * size) % 8) == 0) {
    long *arr = (long *)t;
    unsigned int len = ((sizeof(*t) * size) / 8);
    unsigned int len_i = len - 1;
    while((len--) > 0) *(arr++) = 0;
    // for(unsigned int i = 0; i < len / 2; i++) {
    //   arr[0] = 0;
    //   arr[len_i - i] = 0;
    // }
  } else if (((sizeof(*t) * size) % 4) == 0) {
    int *arr = (int *)t;
    unsigned int len = ((sizeof(*t) * size) / 4);
    while((len--) > 0) *(arr++) = 0;
  } else {
    char *arr = (char *)t;
    unsigned int len = ((sizeof(*t) * size));
    while((len--) > 0) *(arr++) = 0;
  }
}


int main() {

  int *arr = new int [SIZE];
  memset(arr, 1, 4 * SIZE);

  ZERO(arr, SIZE);

  delete [] arr;

  return 0;
}
