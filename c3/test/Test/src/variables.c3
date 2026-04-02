module test;


struct AStruct {
  int a;
}

fn void variables() {
  int x;
  int y @noinit;

  AStruct foo;
  AStruct bar = {};
  AStruct boz @noinit;
}
