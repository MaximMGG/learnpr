

use List::{Cons, Nil};

fn main() {
    println!("Box<T>");

    let a = Box::new(5);

    println!("a = {a}");

    let list = Cons(1, Box::new(Cons(2, Box::new(Cons(3, Box::new(Nil))))));

    println!("{:?}", list);

    let mut l = &list;
    loop {
        match l {
            Cons(i, e) => {
                println!("{i}");
                l = e;
            },
            Nil => {break;}
        }
    }

    treating_smart_pointer();
}

#[derive(Debug)]
enum List {
    Cons(i32, Box<List>),
    Nil,
}


fn treating_smart_pointer() {
    let x = 5;
    let y = MyBox::new(x);

    assert_eq!(5, x);
    assert_eq!(5, *y);
}

struct MyBox<T>(T);

impl<T> MyBox<T> {
    fn new(x: T) -> MyBox<T> {
        MyBox(x)
    }
}

use std::ops::Deref;

impl<T> Deref for MyBox<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}
