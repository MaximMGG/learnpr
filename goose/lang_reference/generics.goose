import std;


fn twice(x) {x + x}
fn span<T>(a: T, b: T) -> T {
  if a > b {
    a - b
  } else {
    b - a
  }
}

fn zero<T>() -> T {default<T>()}

fn discribe(x: i64) -> u8[>..] {str("int: ", x)}
fn discribe(x: f64) -> u8[>..] {str("double: ", x)}
fn discribe(xs: i64[:]) -> u8[>..] {str(xs.len, " length, first: ", xs[0])}


fn each_pair<T, F>(xs: T[:]) {
  for i in 0..xs.len - 1 {
    F(xs[i], xs[i + 1]) 
  }
}

fn main() {
  print(twice(2));
  print(span(34, 77));

  let a = zero<f64>() + 0.5;
  print(a);

  let x: i64 = 333;
  let y: f64 = 41584.9;
  let z: i64[] = [3, 8, 7, 9];

  print(discribe(x));
  print(y.discribe());
  print(discribe(z));

  let xs = [8, 11, 431, 983, 123, 99, 10];

  var gaps: i64[>..] = [];
  each_pair(xs) {
    a, b => gaps.push(a - b)
  }

  print(gaps);

}
