import std;


fn total(xs: i64[:]) -> i64 {
  var t = 0;
  for x in xs {
    t += x;
  }
  t
}

fn main() {
  let a: i64[4] = [1, 2, 3, 4];
  let b: i64[>..] = [1, 2, 3, 4, 5];

  print("i64[4] ", total(a));
  print("i64[>..] ", total(b));
  print("i64[1..4] ", total(b[1..4]));
  print("i64[^2..] ", total(b[^2..]));
  main2();
  main3();
}


fn main2() {
  var fixed: i64[5] = [1, 2, 3, 4, 5];
  let view: const i64[:] = fixed;
  fixed[0] = 99;
  print(view[0]);
}

fn iter<F>(arr: i32[:]) {
  for i in arr {
    F(i);
  }
}


fn main3() {
  let text = "the quick brown fox jumbps over the lazy dog the fox";
  //var counts = dictionary<const u8[:], i32>{};
  each_split(text, ' ') {
    print(it);
  }

  let arr: i32[] = [1, 2, 3, 4, 5];

  iter(arr) {
    print(it);
  }
}
