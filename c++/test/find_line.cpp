#include <stdio.h>
#include <mh/core.hpp>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>




i32 main(i32 argc, i8 **argv) {
  if (argc <= 1) {
    fprintf(stderr, "Usage <app> [char_number] [file]");
  }

  i32 fd = open(argv[2], O_RDONLY);
  if (fd <= 0) {
    fprintf(stderr, "Can't open file, check file name %s\n", argv[2]);
    return 1;
  }

  u64 file_size = lseek(fd, 0, SEEK_END);
  lseek(fd, 0, SEEK_SET);

  i8 *file_cont = new i8 [file_size + 1];

  u64 read_bytes = read(fd, file_cont, file_size);
  close(fd);
  if (read_bytes != file_size) {
    fprintf(stderr, "Internal error read syscall read_bytes %ld, file_size %ld", read_bytes, file_size);
    delete [] file_cont;
  }
  file_cont[read_bytes] = '\0';
  
  printf("File size is: %ld\n", file_size);


  u64 char_to_find = atol(argv[1]);
  if (char_to_find > file_size) {
    fprintf(stderr, "File less that char number: %ld", char_to_find);
    delete [] file_cont;
    return 1;
  }

  u32 line_cont = 1;

  i8 *line = new i8 [file_size];
  ZERO(line, file_size);
  u32 I = 0;

  u64 i = 0;
  while(i < file_size) {
    line[I++] = file_cont[i];
    if (file_cont[i] == '\n') {
      line_cont++;
      I = 0;
      ZERO(line, file_size);
      i++;
      continue;
    }
    if (i == char_to_find) {
      // while(file_cont[i] != '\n') {
      //   line[I++] = file_cont[i];
      //   i++;
      // }
      printf("Char %ld found at line %d: \n%s", char_to_find, line_cont, line);
      delete [] line;
      break;
    }
    i++;
  }

  //defer
  delete [] file_cont;

  return 0;
}
