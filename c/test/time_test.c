#include <stdio.h>
#include <time.h>
#include <fcntl.h>
#include <unistd.h>


#define COUNT 10000000



#define PER_SEC 1000
#define PER_MIN 60000
#define PER_HOUR 3600000


int main() {
  clock_t start = clock();
  
  int fd = open("hole.txt", O_CREAT | O_WRONLY, 0666);

  if (fd < 0) {
    fprintf(stderr, "Can't open hole.txt\n");
    return 1;    
  } 

  long sum = 0;
  char *msg = "a";  

  for (int i = 0; i < COUNT; i++) {
    write(fd, msg, 1);
  }

  close(fd);  
  clock_t end = clock();
  clock_t res = end - start;
  printf("clock time - %ld\n", res);  
  
  res /= 1000;

  long hour = res / PER_HOUR;
  res %= PER_HOUR;
  long min = res / PER_MIN;
  res %= PER_MIN;
  long sec = res / PER_SEC;
  res %= PER_SEC;  
  long ms = res;


  printf("Sum is - %ld\n", sum);
  printf("hour - %ld\nmin - %ld\nsec - %ld\nms - %ld\n", hour, min, sec, ms);  

  return 0;
}


