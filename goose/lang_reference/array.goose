fn main() {
  var fixed: i32[4] = [1, 2, 3, 4];
  let zeros: f64[8] = [0.0; 8];
  let frozen: i64[] = [7, 8, 9];

  var grow: i64[>..] = [];
  for i in 5 {
    grow.push(i * i);
  }
  print("Arr size: ", grow.len);

  var stack: i64[>..<] = [];

  stack.push(1); stack.push(2); stack.push(3);

  let to = stack.pop();
  stack.pop_n(2);

  var small: u8[..8] = [];
  small.push('h');
  small.push('i');
}
