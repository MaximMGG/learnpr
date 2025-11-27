#include <stdio.h>
#include <stdlib.h>
#include <time.h>





int main() {

  
  // struct timeval a;
  time_t t;
  time(&t);
  printf("%ld\n", t);
  struct tm tm_25 = {0};
  tm_25.tm_year = 2025 - 1900;
  tm_25.tm_hour = 20;
  tm_25.tm_min = 30;
  tm_25.tm_mon = 10;
  tm_25.tm_mday = 25;

  struct tm tm_27 = {0};
  tm_27.tm_year = 125;
  tm_27.tm_hour = 20;
  tm_27.tm_min = 30;
  tm_27.tm_mon = 10;
  tm_27.tm_mday = 27;

  time_t t_25 = timelocal(&tm_25);
  time_t t_27 = timelocal(&tm_27);

  printf("27.11.2025 20:30 %ld\n", t_27 * 1000);
  printf("25.11.2025 20:30 %ld\n", t_25 * 1000);
  printf("Time now %ld\n", t * 1000);

  return 0;
}
