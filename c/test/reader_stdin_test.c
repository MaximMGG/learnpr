#include <cstdext/io/reader.h>
#include <unistd.h>
#include <stdio.h>

int main() {
  reader *r = reader_create_from_fd(STDIN_FILENO);

  str tmp;
  while((tmp = reader_read_str(r)) != null) {
    printf("%s\n", tmp);
  }

  reader_destroy(r);
  return 0;
}
