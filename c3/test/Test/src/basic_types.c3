module test;

import std::io;
import std::core::string;

fn void basic_variables() {
  ichar ic; // 8 bit
  short is; // 16 bit
  int ii; // 32 bit
  long il; // 64 bit
  int128 i128; // 128 bit
  iptr ip; // pointer
  isz iz; // 64 bit ? 

  char uc; // 8 bit
  ushort us; // 16 bit
  uint ui; // 32 bit
  ulong ul; // 64 bit
  uint128 u128; // 128 bit

  uptr up; // pointer
  usz uz; //64 bit?

  bool b;

  float f1; // 32 bit
  double f2; // 64 bit


  int[3] arr1 = {1, 2, 3};
  int[*] arr2 = {1, 2, 3};
  io::printn(arr1);
  io::printn(arr2);

  //slice
  int[] ss = &arr1;
  io::printn(ss);

  //vectors
  int[<*>] vv = {1, 2};
  io::printn(vv);

  int[<2>] v1 = {1, 4};
  int[<2>] v2 = {8, 4};

  io::printn(v1 * v2);

  int[<3>] v3 = {.xy = 13, .z = 8};
  io::printn(v3);
  io::printn("Strings");

  String three_lines = 
  `multi
  line
  string
  `;

  String foo = `C:\foo\bar.dll`;
  String bar = `"Say ``hello``"`;

  String foo2 = "C:\\foo\\bar.dll";
  String bar2 = "\"Say `hello`\"";

  io::printn(foo);
  io::printn(bar);
  io::printn(foo2);
  io::printn(bar2);

}

enum Foo {
  ABC, BCD, EFG,
}


fn void printing_values() {
  int a = 123123;
  ulong b = 0xFFAABBCCDDEEFF;
  double d = 13.03e-04;
  char[*] hex = x"4865 6c6c 6f20 776f 726c 6421";
  io::printn(a);
  io::printn(b);
  io::printn(d);
  io::printn((String)(&hex));

  Foo f = BCD;

  io::printfn("a: %s, b: %d, foo: %s", a, b, f);

}

