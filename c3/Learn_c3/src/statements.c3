module statements;

import std::io;

fn void test(int i)
{
  if FOO: (i > 0)
  {
    while(1)
    {
      io::printfn("%d", i);
      if (i++ > 10) break FOO;
    }
  }
}

fn void test2(int i) {
  do {
    if (!i) break;
    io::printf("Hello ");
  };
  io::printf("World!\n");
}

fn void test3(int i) {
  switch(i) {
    case 1:
      io::printf("i: 1\n");
      nextcase;
    case 2:
      io::printf("i: 2\n");
  }
  
}


fn void test4(int i) {
  switch MAIN: {
    case FOO:
      switch(i) {
        case 1:
          io::printf("1\n");
          nextcase 3;
        case 2:
          io::printf("2\n");
        case 3:
          io::printf("3\n");
        default:
          io::printf("Ended\n");
          nextcase MAIN: BAR;
      }
    case BAR:
      io::printn("BAR");
    default:
      break;
  }

}

fn void main() {
  test(2);
  test2(0);
  test3(1);
  test4(1);
}
