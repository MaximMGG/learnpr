

struct Item {
  id: u32,
  val: f32,
}

reusable var pool: Item[>..] = [];

fn main() {
  let o1 = pool.alloc_index(Item{20, 1.5});
  let o2 = pool.alloc_index(Item{33, 3.3});
  pool.free(o1);

  let o3 = pool.alloc_index(Item{44, 9.9});

  for i in pool.len {
    print(i, " item -> ", pool[i]);
  }

  let r1 .= pool.alloc_ref(Item{777, 1.0});
  r1.val = 777.777;

  print("After alloc ref");

  for i in pool.len {
    print(i, " item -> ", pool[i]);
  }
}
