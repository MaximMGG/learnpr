

type Id = u32;
type Names = u8[..16][>..];
fn main4() {
  let a: Id = 7;
  let b: u32 = a;
  var ns: Names = [];
  ns.push("goose");
  print(a + b, " ", ns);
}

let SIZE = 16;
let HALF = SIZE / 2;
var grid: u8[SIZE] = [0; SIZE];
fn main3() {
  let b: u8 = SIZE;
  let wide = SIZE * 1000000000;
  grid[HALF] = 1;
  print(b, " ", wide, " ", grid.len, " ", match 8 {HALF => "half", _ => "other"});
}

fn main2() {
  let n: i64;
  let ready = true;
  if ready {n = 1;} else {n = 2;}
  print(n);
}

fn main() {
  let a = 3;
  let v = (if a > 2 {1} else {2}) + 3;
  if a > 2 {print("big");}
  let w = if a > 2 {10} else {20};
  print(v, " ", w);

  let answer = 42;
  var count: i32 = 0;
  const limits = [10, 20, 30];
  count += 1;
  count++;

  let xs = [1, 2, 3];
  xs[0] = 9;
  const ys = [1, 2, 3];
  //ys[0] = 9;
  var s: const u8[:] = "text";
  s = s[1..];
  print(xs, " ", ys, " ", s);
  main2();
  main3();
  main4();
}
