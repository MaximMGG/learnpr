#include <cstdext/container/map.h>
#include <stdbool.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <cstdext/io/logger.h>


int main() {
  i32 fd = open("./test/test.txt", O_RDONLY);
  struct stat st;
  fstat(fd, &st);
  byte *buf = alloc(st.st_size);
  map *m = map_create(U8, U32, null, null);
  log(INFO, "Map_create");  

  i32 byte_read = read(fd, buf, st.st_size);
  if (byte_read != st.st_size) {
    fprintf(stderr, "byte_read %d != st.st_size %ld\n", byte_read, st.st_size);
  }
  log(INFO, "read %d bytes", byte_read);
  for (i32 i = 0; i < byte_read; i++) {
    if (!map_contain(m, &buf[i])) {
      u32 val = 0;
      map_put(m, &buf[i], &val);
    } else {
      KV kv = map_get(m, &buf[i]);
      u32 *val = kv.val;
      (*val)++;
    }
  }

  iterator *it = map_iterator(m);
  KV tmp;
  log(INFO, "Start iterationg");  
  while (true) {
    tmp = map_it_next(it);
    if (tmp.key == null)
      break;
    
    printf("Key %c, val %d\n", *(u8 *)tmp.key, *(u32 *)tmp.val);
  }
  log(INFO, "End");
  close(fd);
  dealloc(buf);
  map_it_destroy(it);
  map_destroy(m);
  
  return 0;  
}
