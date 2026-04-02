#include <stdio.h>
#include <cstdext/core.h>

i32 partition(i32 *arr, i32 lo, i32 hi) {
  i32 pivot = arr[hi];
  i32 idx = lo - 1;

  for (i32 i = lo; i < hi; i++) {
    if (arr[i] <= pivot) {
      idx++;
      i32 tmp = arr[idx];
      arr[idx] = arr[i];
      arr[i] = tmp;
    }
  }
  idx++;
  i32 tmp = arr[hi];
  arr[hi] = arr[idx];
  arr[idx] = tmp;

  return idx;
}

// 1, 5, 5, 6, 8
//4
//3
//5
void sort(i32 *arr, i32 lo, i32 hi) {
  if (lo >= hi) {
    return;
  }
  i32 pivot_index = partition(arr, lo, hi);
  sort(arr, lo, pivot_index - 1);
  sort(arr, pivot_index + 1, hi);
}

void quickSort(i32 *arr, i32 arr_len) {
  sort(arr, 0, arr_len - 1);
}

int main() {
  i32 arr[] = {8, 1, 2, 4, 3};

  quickSort(arr, 5);

  for(i32 i = 0; i < 5; i++) {
    printf("%d\n", arr[i]);
  }

  return 0;
}
