module variable;

import std::io;

struct Foo {
  int a;
  double b;
}

fn void print_foo(Foo f) {
  io::printn(f);
}

fn void main() {
  int a @noinit;
  Foo foo @noinit;

  io::printn(a);
  io::printn(foo);
  print_foo((Foo){123, 33.4});
}
