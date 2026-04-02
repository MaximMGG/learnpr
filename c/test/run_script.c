#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

void exe_script(int tmp, ...) {
  va_list li;
  va_start(li, tmp);

  for(;;) {
    char *line = va_arg(li, char *);
    if (line == NULL) {
      break;
    }
    system(line);
  }

  va_end(li);
}

#define script(...) exe_script(0, __VA_ARGS__, NULL) 


int main() {
  script("echo \"Hello world\"",
	 "touch __super_file.txt",
	 "sudo cp __super_file.txt /usr/include",
	 "sudo rm /usr/include/__super_file.txt");

  return 0;
}
