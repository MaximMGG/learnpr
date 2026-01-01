#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <mcheck.h>

#define MAX_ALLOCS 1000000

int main(int argc, char **argv) {
  //setenv("MALLOC_TRACE", "/home/maxim/learnpr/linuxapi/chapter7/malloc_trace.txt", 1);
  mtrace();

  char *ptr[MAX_ALLOCS];
  int freeStep, freeMin, freeMax, blockSize, numAllocs, j;


  if (argc < 3 || strcmp(argv[1], "--help") == 0) {
    fprintf(stderr, "%s num-allocs block-size [step [min [max]]]\n", argv[0]);
    return 0;
  }

  numAllocs = atol(argv[1]);
  if (numAllocs > MAX_ALLOCS) {
    fprintf(stderr, "num-allocs > %d\n", MAX_ALLOCS);
    return 1;
  }
  blockSize = atol(argv[2]);
  freeStep = (argc > 3) ? atol(argv[3]) : 1;
  freeMin = (argc > 4) ? atol(argv[4]) : 1;
  freeMax = (argc > 5) ? atol(argv[5]) : numAllocs;

  if (freeMax > numAllocs) {
    fprintf(stderr, "free-max > num-allocs\n");
    return 1;
  }

  printf("Initial program break:      %10p\n", sbrk(0));
  printf("Allocation %d*%d bytes\n", numAllocs, blockSize);
  for(j = 0; j < numAllocs; j++) {
    ptr[j] = malloc(blockSize);
    if (ptr[j] == NULL) {
      fprintf(stderr, "Malloc error\n");
      return 1;
    }
  }
  printf("Program break is now:         %10p\n", sbrk(0));
  printf("Freeing blocks from %d to %d in steps of %d\n", freeMin, freeMax, freeStep);
  for(j = freeMin - 1; j < freeMax; j += freeStep) {
    free(ptr[j]);
  }
  printf("After free(), program brek is:    %10p\n", sbrk(0));

  muntrace();
  exit(EXIT_SUCCESS);

}
