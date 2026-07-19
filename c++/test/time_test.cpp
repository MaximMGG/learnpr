#include <time.h>
#include <stdio.h>

long count() {
  long sum = 0;
  for(int i = 0; i < 1000000; i++) {
    sum += i * 2 + 1 -3 + 7;
  }
  return sum;
}


int main() {

  unsigned long start = clock();

  long res = count();
  printf("Res: %ld\n", res);
  unsigned long finish = clock();
  double ms = ((double)finish - (double)start) / (double)1000000;

  printf("Total time: %ld\n", finish - start);
  printf("%.3lf s\n", ms);

  return 0;
}
