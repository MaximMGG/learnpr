
import std;


fn main() {
  for round in 3 {
    var scratch: u8[>..] = [];
    for i in 1000000 {
      scratch.push((i % 256) as! u8);
    }
    print("round ", round, ": ", scratch.len, " bytes");
  }
  main2();
}

struct Item {id: i32, weight: f32}
fn main2() {
  var items: Item[>..] = [];
  let first .= items.push(Item {1, 0.5});
  for i: i32 in 2..1000001 {
    items.push(Item{i, 0.0});
  }
  let second .= items[1];
  first.weight = 99.5;
  print(items.len, " items, first is ", items[0]);
  second.id = 9999;
  print("Seoncd: ", items[1]);
}
