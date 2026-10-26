

struct Node {
  word: u8[..24],
  count: i32,
  left: Node&<u32>?,
  right: Node&<u32>?,
}

var index: Node[>..] = [];


fn main() {

  index.push(Node{word: "Dog", count: 123, left: null, right: null});
  let l .= index[0];
  index.push(Node{word: "Cat", count: 3, left: l, right: null});
  index.push(Node{word: "Perple", count: 2, left: null, right: null});
  index.push(Node{word: "With", count: 1, left: null, right: null});

  var image: u8[>..] = index.to_bytes();
  var loaded, ok = from_bytes<Node[>..]>(image);

  print("Image: ", image);
  print("Loaded: ", loaded);
}




