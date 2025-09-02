#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <cstdext/io/reader.h>
#include <cstdext/core.h>


int main() {
  int fd = open("struct_read_write.c", O_RDWR | O_CREAT, 0666);
  reader *r = reader_create(fd, null, 0);

  while(!r->end_of_read) {
    str res = reader_read_str(r);
    printf("%s\n", res);
    dealloc(res);
  }
  close(fd);
  reader_destroy(r);
  return 0;
}
