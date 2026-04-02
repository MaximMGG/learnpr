module learn_c3;
import std::io;

fn void string_example() {
  String a = "Hello wrold!";
  io::printn(a);
  String mul_string = `
Multy
string"a"
`;
  io::printn(mul_string);
}

fn int main(String[] args) {

  int[3] abc = {1, 2, 3};
  int[] sl = &abc;

  io::printn(sl);


  int[<*>] a = {1, 2, 3};
  int[<3>] b = {3, 3, 3};
  int[<*>] c = a * b;
  int[<3>] d = {.xy = 777, .z = 1};

  io::printn(c);
  io::printn(d);
  io::printfn("Vector print %s", d);
  io::printn("String examples");
  string_example();
  io::printn("Printing values");
  printing_values();
  
  return 0;
}

enum Foo {
  ABC, BCD, EFG, 
}


fn void printing_values() {
  int a = 1234;
  ulong b = 0xFFAABBCCDDEEFF;
  double d = 13.03e-04;
  char[*] hex = x"4865 6c6c 6f20 776f 726c 6421";
  io::printfn("a was: %d", a);
  io::printfn("b in hex is 0x%X", b);
  io::printfn("d in scientific notation is %e", d);
  io::printfn("Bytes as string: %s", (String)&hex);

  uint128 bb = 0xFFEEDDCC_BBAA9988_77665544_33221100;
  Foo foo = BCD;
  io::printfn("a: %s, b: %d, foo: %s", a, b, foo);
}
