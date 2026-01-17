#include <cstdext/core.h>
#include <cstdext/io/reader.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>


byte delimeter = '\t';
u32 fields_count = 1;
void (*def_func)(reader *);


void print_fields(reader *r) {
  if (fields_count == 0) {
    fields_count = 1;
  }
  str tmp;
  while((tmp = reader_read_str(r)) != null) {
    u32 skip_field = 0;
    byte buf[128] = {0};
    i32 i = 0;
    while(true) {
      if (skip_field == fields_count - 1) {
        i32 j = i;
        while(tmp[j] != delimeter) j++;
        strncpy(buf, tmp + i, j - i);
        break;
      }
      while(tmp[i] != delimeter) i++;
      skip_field++;
      i++;
    }
    printf("%s\n", buf);
  }
}

int main(i32 argc, str *argv) {
  if (argc <= 2) {
    fprintf(stderr, "Usage: Cut [flags...] [file_name]\n");
    return 1;
  }

  for(i32 i = 0; i < argc; i++) {
    if (argv[i][1] == 'f') {
      fields_count = argv[i][2] - 48;
      def_func = print_fields;
    }

    if (argv[i][1] == 'd') {
      delimeter = argv[i][2];
    }
  }

  reader *r = reader_create_from_file(argv[argc - 1]);
  def_func(r);
  reader_destroy(r);
  return 0;
}
