module test;

import std::io;

struct SFoo {
  int a;
  double b;
}


fn void show_var(int *x) {
  io::printn(*x);
}

fn void test1(SFoo x) {
  io::printn(x);
}


fn void slice_print(int[] arr) {
  foreach (int i : arr) {
    io::printn(i);
  }

  // for (int i = 0; i < arr.len; i++) {
  //   io::printn(arr[i]);
  // }
}


fn void pointer_arr(int[3] *z) {

}

fn void pointer_arr2(int *z) {

}

fn void expression() {
  show_var(&&7);
  test1((SFoo){1, 2.0});

  int[*] arr = {1, 2, 3, 4, 5};
  slice_print(&arr);
  slice_print(&&(int[3]){1, 2, 3});
  slice_print(((int[3]){1, 2, 3})[..]);
  slice_print((int[]){1, 2, 8});
  slice_print({2, 3, 4});

  pointer_arr(&&(int[3]){1, 2, 3});
  pointer_arr2(&&(int[3]){1, 2, 3});
}
