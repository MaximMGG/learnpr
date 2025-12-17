module test;

import std::io;


fn void statement_test(int i) {
  io::printn("Statement tests");
  if FOO: (i > 0) {
    while(1) {
      io::printfn("%d", i);
      if (i++ > 10) break FOO;
    }
  }
}

fn void statement_test2(int x) {
  do {
    if (!x) break;
    io::printf("Hello ");
  };
  io::printn("World!");
}

fn void statement_test3(int i) {
  switch(i) {
    case 1:
      //...
      nextcase;
    case 2:
      //...
  }
}

fn void statement_test4(int i) {

}



fn void statement_main() {
  statement_test(2);
  statement_test2(0);



}
