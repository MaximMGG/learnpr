#include <stdio.h>
#include <stdlib.h>
#include <string.h>



const char *test_str = "host: ardr\r\nName: misha\r\nLost: yes\r\n\r\n";
const char *pattern = " ";

int main() {
  int count = 0;
  int beg = 0;
  int end = 0;
  int test_len = strlen(test_str);
  int pattern_len = strlen(pattern);

  char buf[64] = {0};

  char *find = strstr(test_str, pattern);

  while(find != NULL) {
	beg = end;
	end = find - test_str;
	memcpy(buf, test_str + beg, end - beg);
	printf("%s\n", buf);
	count++;
	memset(buf, 0, 64);
	end += pattern_len;
	find = strstr(test_str + end, pattern);
  }

  memcpy(buf, test_str + end, test_len - end);

  printf("%s\n", buf);
  count++;

  printf("Find %d patterns\n", count);
  
  return 0;
}
