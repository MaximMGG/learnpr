module file_test;

import std::collections;
import std::io;
import std::io::path;


fn void main() {
  Path dir = path::cwd(mem)!!;
  defer dir.free();
  PathList? p = path::ls(mem, dir);
  defer p.free()!!;
  File *f = io::stdout();
  defer f.close()!!;

  if (try f.write("Hello\n")) {
    
  }
  io::printn(p)!!;
}
