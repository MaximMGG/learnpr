#include <cstdext/core.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <string.h>
#include <locale.h>
#include <dirent.h>



i32 main() {
  
  struct stat st;

  stat("./fild.c", &st);
  time_t t = st.st_mtim.tv_sec;

  struct tm *mt = gmtime(&t);

  printf("Last modify: %d:%d:%d-%d:%d:%d\n", mt->tm_year + 1900, mt->tm_mon,
         mt->tm_mday, mt->tm_hour, mt->tm_min, mt->tm_sec);


  i8 mod_buf[sizeof(t) + 1] = {0};
  memcpy(mod_buf, &t, sizeof(t));
  mod_buf[sizeof(t)] = '\0';

  printf("Mod_buf: %s\n", mod_buf);

  time_t nt;

  memcpy(&nt, mod_buf, sizeof(nt));

  mt = gmtime(&nt);

  printf("Last modify after reload: %d:%d:%d-%d:%d:%d\n", mt->tm_year + 1900, mt->tm_mon,
         mt->tm_mday, mt->tm_hour, mt->tm_min, mt->tm_sec);


  time_t now = time(NULL);

  i8 dir_name[64] = {0};

  i8 dir[] = ".cbuild_cache-";
  
  memcpy(&dir_name[0], dir, sizeof(dir));
  memcpy(&dir_name[sizeof(dir) - 1], &now, sizeof(now));

  printf("Dir name: %s\n", dir_name);

  mkdir(dir_name, S_IRUSR | S_IWUSR | S_IXUSR);


  DIR *cur = opendir(".");

  struct dirent *d;

  while((d = readdir(cur)) != null) {
    if ((d->d_type & DT_DIR) > 0) {
      str c_build_dir = strstr(d->d_name, dir);
      if (c_build_dir != null) {
        time_t dir_create_time;

        printf("%ld\n", sizeof(dir));
        memcpy(&dir_create_time, &d->d_name[14],
               7);

        mt = gmtime(&dir_create_time);
        if (mt != null) {
          printf("Dir create time: %d:%d:%d-%d:%d:%d\n", mt->tm_year + 1900,
               mt->tm_mon, mt->tm_mday, mt->tm_hour, mt->tm_min, mt->tm_sec);  
        } else {
          printf("mt == null\n");
        }
      }
    }
  }

  closedir(cur);
  
  
  return 0;
}
