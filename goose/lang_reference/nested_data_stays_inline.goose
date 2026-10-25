import std;

struct Item {
  sku: u8[varint],
  qty: varint,
  cents: varint
}

struct Order {
  id: varint,
  customer: u8[varint],
  items: Item[varint]
}

fn parse_items(field: u8[:]) -> Item[>..] {
  var items: Item[>..] = [];
  each_split(field, ';') {
    let p = split(it, ':');
    let qty, ok1 = parse_int(p[1]);
    let cents, ok2 = parse_int(p[2]);
    assert(ok1 && ok2);
    items.push(Item{p[0], qty, cents});
  }
  items
}


fn main() {
  var book: Order[>..] = [];
  book.push(Order{1001, "alice", parse_items("SKU-441:2:1999;SKU-7:1:500")});


  for o in book {
    var t = 0;
    for it in o.items {
      t += it.qty * it.cents;
    }
    print(o.customer, " owes ", t, " cents over ", o.items.len, " items");
  }

}
