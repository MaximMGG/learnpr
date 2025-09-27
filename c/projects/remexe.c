#include <stdio.h>
#include <dirent.h>
#include <sys/stat.h>

#include <cstdext/core.h>
#include <cstdext/io/logger.h>

const i32 extensions_size = 1;
const str extensions[] = {"sh"};

const i32 files_size = 1;
const str files[] = {"remexe"};


bool check_exception(str file_name) {
  str dot = strstr(file_name, ".");
  if (dot != null) {
    dot++;
    for(i32 i = 0; i < extensions_size; i++) {
      if (strcmp(dot, extensions[i]) == 0) {
	return false;
      }
    }
  }

  for(i32 i = 0; i < files_size; i++) {
    if (strcmp(file_name, files[i]) == 0) {
      return false;
    }
  }
  
  return true;
}


void print_level(i32 level) {
  for(i32 i = 0; i < level; i++) {
    printf("  ");
  }
}

void check_dir(str dir_name, i32 level) {
  DIR *dir = opendir(dir_name);
  if (dir == null) {
    log(FATAL, "Cant open dir %s", dir_name);
    exit(1);
  }
  print_level(level);
  printf("Check dir %s...\n", dir_name);
  struct dirent *d;
  struct stat st;
  
  while((d = readdir(dir)) != null) {
    if (d->d_type == DT_DIR) {
      if (d->d_name[0] == '.') continue;
      str new_name = str_create_fmt("%s/%s", dir_name, d->d_name);
      check_dir(new_name, level + 1);
      dealloc(new_name);
      continue;
    } else if (d->d_type == DT_REG) {
      str file_name = str_create_fmt("%s/%s", dir_name, d->d_name);
      stat(file_name, &st);
      if ((st.st_mode & S_IXUSR) > 0) {
	if (check_exception(file_name)) {
	  print_level(level);
	  printf("Removing file %s\n", file_name);
	  remove(file_name);
	}
      }
      dealloc(file_name);
    }
  }
  closedir(dir);
}


int main() {
  check_dir(".", 0);
  return 0;
}
