


struct Node {
  key: i32,
  count: i32 = 1,
  left: Node&<u32>?,
  right: Node&<u32>?
}


fn insert(pool: Node[>..]&, key: i32) {
  if pool.len == 0 {
    pool.push(Node{key: key});
    return;
  }
  var cur .= pool[0]; // binds the element; = would copy it
  loop {
    if key == cur.key {
      cur.count += 1;
      return;
    }
    if key < cur.key {
      let l = cur.left;
      if l {
        cur .= l; continue;
      }
      cur.left .= pool.push(Node{key: key});
      return;
    }
    let r = cur.right;
    if r {
      cur .= r; continue;
    }
    cur.right .= pool.push(Node{key: key});
    return;
  }
}

struct Node2 {
  val: i64, prev: Node2&<u32 in pool>, next: Node2&<u32 in pool>
}

reusable var pool: Node2[>..] = [];
let head = pool.alloc_index(Node2{val: 0, prev: self, next: self});

fn insert_after(p: Node2&, v: i64) -> Node2& {
  let n .= pool.alloc_ref(Node2{val: v, prev: p, next: p.next});
  n.next.prev .= n;
  p.next .= n;
  return n;
}

fn remove(n: Node2&) {
  n.prev.next .= n.next;
  n.next.prev .= n.prev;
  pool.free(pool.index_of(n));
}

fn is_end(n: Node2&) -> bool {n .== pool[head]}

enum Mark {
  Circle {r: f64},
  Rect {w: f64, h: f64},
  Label {text: u8[varint]},
  Dot
}

var marks: Mark..[>..] = [];
var mark_at: (Mark..&<u32 in marks>)[>..] = [];

fn main() {
  mark_at.push(marks.push(Mark.Label{text: "Hello, goose"}));
  mark_at.push(marks.push(Mark.Circle {r: 1.5}));
  mark_at.push(marks.push(Mark.Dot));
  mark_at.push(marks.push(Mark.Rect {w: 2.0, h: 3.0}));
  mark_at.push(marks.push(Mark.Label {text: "x"}));

  var j = 0;
  
  for m in marks {
    match m {
      Circle c => print(j, ": circle ", c.r),
      Rect r => print(j, ": rect ", r.w, " by ", r.h),
      Label l => print(j, ": label \"", l.text, "\""),
      Dot => print(j, ": dot")
    }
    j += 1;
  }

  for i in [3, 0, 4, 1, 2] {
    match mark_at[i] {
      Circle c => print(i, ": circle ", c.r),
      Rect r => print(i, ": rect ", r.w, " by ", r.h),
      Label l => print(i, ": label \"", l.text, "\""),
      Dot => print(i, ": dot")
    }
  }
}
