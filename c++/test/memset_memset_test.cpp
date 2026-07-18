#include <string.h>

#define SIZE 10240000

int main() {

  int *arr = new int [SIZE];
  memset(arr, 1, 4 * SIZE);

  memset(arr, 0, 4 * SIZE);

  delete [] arr;
  return 0;
}
