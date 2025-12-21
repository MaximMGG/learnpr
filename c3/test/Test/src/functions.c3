module test;


import std::io::os;
import std::io;

fn int test_with_defaults(int foo = 1) {
  return foo;
}

fn void functions_main() {
  io::printn(test_with_defaults());
  io::printn(test_with_defaults(100));
}
