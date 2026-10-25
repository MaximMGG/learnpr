import std;

fn main() {
  let a: u32 = 7;
  let b: i32 = 3;

  //let c = a + b; this is error
  let c = a as i64 + b;
  let d: u8 = 200;
  let e = d + 100;
  print(c, " ", e);
  print(-7 % 3, " ", 7 % -3, " ", 7 / 3);

  print(-7 / 3, " ", rem(-7, 3));
  print(div_euclid(-7, 3), " ", -7 % 3);
  print(div_euclid(-1, 10), " ", -1 % 10);


  var h: u64 = 14695981039346656037;
  for c in "goose" {
    h = (h ^ c) * 1099511628211;
  }
  print(h);
  main2();
  main3();
  main4();
  main5();
  main6();
}

let PI = 3.14592643589793;
fn area32(r: f32) -> f32 { PI * r * r }

fn main2() {
  let n = 3;
  let h = n * 0.5;
  let r: f32 = 2;
  print(h, " ", area32(r), " ", PI);
}

fn main3() {
  let big = 300;
  let n: u8 = big as! u8;
  let f = 2.75;
  let i = f as i64;
  let back = i as f64 / 4;
  let neg = -1;
  let u = neg as! u32;
  print(n, " ", i, " ", back, " ", u);
}

fn main4() {
  let h: u64 = 1981249812419284;
  var xs: i64[>..] = [1, 2, 3];
  let n = xs.len;
  print(h > 5, " ", xs.len, " ", h > n);
}


struct V3 {x: f32, y: f32, z: f32}
fn main5() {
  print("Arithmetic on strucs and fixed arrays");
  let a = V3{1, 2, 3};
  let b = V3{0.5, 0.5, 0.5};
  var c = a + b;
  c *= 2;
  print(c, " ", -a, " ", a / 2.0, " ", 2.0 / a);
  let sum = [1, 2, 3] + [10, 20, 30];
  print("Sum is: ", sum);
}

fn main6() {
  print("Bitwise operators");
  var flags: u8 = 0;
  let F_ROAD: u8 = 4;
  flags |= F_ROAD;
  flags |= 1 << 1;
  flags &= ~F_ROAD;
  let k = 40;
  let m: u64 = 1 << k;
  print(flags, " ", m, " ", flags & 2 != 0);
}

