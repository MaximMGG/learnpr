import os;
import std;


fn main() {
  var out: u8[>..] = [];
  read_file("./total.txt", out);

  let trim_out = trim_end(out);

  let total, ok = parse_int(trim_out);
  if !ok {
    print("Can't parse this int: ", out, " ", total);
    return;
  }
  var sum: u64 = 0;
  for i: u64 in total as u64 {
    sum += i * 2 + (3 as f32) as u64;
  }

  print("Sum is: ", sum);
}
