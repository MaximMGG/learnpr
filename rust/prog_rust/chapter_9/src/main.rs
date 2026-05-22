
use std::rc::Rc;

#[derive(Debug)]
struct Grayscale {
    pixels: Vec<u8>,
    size: (usize, usize),
}

fn new_map(size: (usize, usize), pixels: Vec<u8>) -> Grayscale {
    assert_eq!(size.0 * size.1, pixels.len());
    Grayscale{pixels, size}
}

struct Broom {
    name: String,
    height: u32,
    health: u32,
    position: (f32, f32, f32),
    intent: BroomIntent
}

#[derive(Clone, Copy)]
enum BroomIntent {
    FetchWater, DumpWater
}

fn chop(b: Broom) -> (Broom, Broom) {
    let mut broom1 = Broom{height: b.height / 2, .. b};

    let mut broom2 = Broom{name: broom1.name.clone(), .. broom1};
    broom1.name.push_str(" I");
    broom2.name.push_str(" II");

    (broom1, broom2)
}

#[derive(Debug)]
struct Bounds(usize, usize);

fn main() {

    let width = 1024 as usize;
    let height = 720 as usize;
    let pixels: Vec<u8> = vec![0; width * height];
    let _map = new_map((width, height), pixels);

    //println!("{:?}", map);

    let hokey = Broom {
        name: "Hokey".to_string(),
        height: 60,
        health: 100,
        position: (100.0, 200.0, 0.0),
        intent: BroomIntent::FetchWater,
    };

    let (hokey1, hokey2) = chop(hokey);

    assert_eq!(hokey1.name, "Hokey I");
    assert_eq!(hokey1.height, 30);
    assert_eq!(hokey1.health, 100);

    assert_eq!(hokey2.name, "Hokey II");
    assert_eq!(hokey2.height, 30);
    assert_eq!(hokey2.health, 100);

    let image_bounds = Bounds(1024, 768);
    assert_eq!(image_bounds.0 * image_bounds.1, 786432);
    println!("image bounds: {:?}", image_bounds);

    let mut q = Queue{older: Vec::new(), younger: Vec::new()};

    q.push('0');
    q.push('1');
    assert_eq!(q.pop(), Some('0'));

    q.push('*');

    assert_eq!(q.pop(), Some('1'));
    assert_eq!(q.pop(), Some('*'));
    assert_eq!(q.pop(), None);

    assert!(q.is_empty());
    q.push('!');
    assert!(!q.is_empty());
    _ = q.pop();

    q.push('P');
    q.push('D');
    assert_eq!(q.pop(), Some('P'));
    q.push('X');
    
    let (older, younger) = q.split();

    assert_eq!(older, vec!['D']);
    assert_eq!(younger, vec!['X']);

    let mut bq = Box::new(Queue::new());
    bq.push('Q');
    assert!(!bq.is_empty());

    let mut parent = Node::new("parent node");
    let shader_node = Rc::new(Node::new("first"));
    shader_node.append_to(&mut parent);
}


struct Node {
    tag: String,
    childer: Vec<Rc<Node>>
}

impl Node {
    fn new(tag: &str) -> Node {
        Node {
            tag: tag.to_string(),
            childer: vec![]
        }
    }

    fn append_to(self: Rc<Self>, parent: &mut Node) {
        parent.childer.push(self);
    }
}


pub struct Queue {
    older: Vec<char>,
    younger: Vec<char>
}

impl Queue {
    pub fn push(&mut self, c: char) {
        self.younger.push(c);
    }

    pub fn new() -> Queue {
        Queue{older: Vec::new(), younger: Vec::new()}
    }

    pub fn pop(&mut self) -> Option<char> {
        if self.older.is_empty() {
            if self.younger.is_empty() {
                return None;
            }
            use std::mem::swap;
            swap(&mut self.older, &mut self.younger);
            self.older.reverse();
        }
        self.older.pop()
    }

    pub fn is_empty(&self) -> bool {
        self.older.is_empty() && self.younger.is_empty()
    }

    pub fn split(self) -> (Vec<char>, Vec<char>) {
        (self.older, self.younger)
    }
}


