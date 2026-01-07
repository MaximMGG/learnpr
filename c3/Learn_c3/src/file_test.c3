module file_test;

import std::io;
import std::io::path;


fn void main() {
  Path dir = path::cwd(mem)!!;
  defer free(dir);
  PathList? p = path::ls(mem, dir);
  File *f = io::stdout();
  defer f.close()!!;

  if (try f.write("Hello\n")) {
    
  }
  io::printn(p)!!;
}
