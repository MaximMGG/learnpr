
module embed_test;

import std::io;
import std::os;


char[]? test_file = $embed("mai.c3");

fn void main() {
  if (test_file == os::FILE_NOT_FOUND) {
    io::printn("File not found");
  }
  io::printn((String)test_file);
}
