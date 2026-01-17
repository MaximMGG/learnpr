#include <cstdext/core.h>
#include <cstdext/io/reader.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>


byte delimeter = '\t';
u32 fields[10];
u32 fields_count = 0;
void (*def_func)(reader *);

//f0 f1 f2 f3 f4
//   c  
str next_field(str line, u32 *field_len, bool set_len) {
  str content;
  if (!set_len) {
    if (*(line + *field_len) != delimeter) {
      return null;
    }
    content = line + *field_len + 1;
    line += *field_len + 1;
  } else {
    content = line;
  }

  while(*line != delimeter) {
    if (*line == '\n' || *line == '\0') {
      break;
    }
    line++;
  }
  *field_len = line - content;
  return content;
}


void print_fields(reader *r) {
  str tmp;
  while((tmp = reader_read_str(r)) != null) {
    u32 current_field = 1;
    u32 fields_printed = 1;
    byte buf[128] = {0};
    u32 field_len = 0;
    str field = next_field(tmp, &field_len, true);
    while(true) {
      if (field == null) {
        break;
      }
      memset(buf, 0, 128);
      for(i32 i = 0; i < fields_count; i++) {
        if (current_field == fields[i]) {
          strncpy(buf, field, field_len);
          if (fields_printed == fields_count) {
            printf("%s\n", buf);
          } else {
            printf("%s%c", buf, delimeter);
          }
          fields_printed++;
          break;
        }
      }
      field = next_field(field, &field_len, false);
      current_field++;
    }
  }
}

int main(i32 argc, str *argv) {
  if (argc <= 2) {
    fprintf(stderr, "Usage: Cut [flags...] [file_name]\n");
    return 1;
  }

  for(i32 i = 0; i < argc; i++) {
    if (argv[i][1] == 'f') {
      for(i32 j = 2; j < strlen(argv[i]); j++) {
        fields[fields_count++] = argv[i][j] - 48;
        j++;
      }
      def_func = print_fields;
    }

    if (argv[i][1] == 'd') {
      delimeter = argv[i][2];
    }
  }

  reader *r;

  if (strlen(argv[argc - 1]) == 1) {
    if (argv[argc - 1][0] == '-') {
      r = reader_create_from_fd(STDIN_FILENO);
    }
  } else {
    r = reader_create_from_file(argv[argc - 1]);
  }
#ifdef DEBUG
    printf("%s\n", r->buf);
#endif

  if (fields_count == 0) {
    printf("%s\n", r->buf);
  }
  def_func(r);
  reader_destroy(r);
  return 0;
}
