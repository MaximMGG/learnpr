



#[derive(Debug)]
enum List<T> {
    Cons(T, Rc<List<T>>),
    Nil,
}


use crate::List::{Cons, Nil};
use std::rc::Rc;

fn main() {
    println!("Rc<T> -> Reference-Counted Smart Pointer");

    let a = Rc::new(Cons(5, Rc::new(Cons(10, Rc::new(Nil)))));
    println!("Count after creating a = {}", Rc::strong_count(&a));
    let b = Cons(3, Rc::clone(&a));
    println!("Count after creating b = {}", Rc::strong_count(&a));
    {
        let c = Rc::new(Cons(2, Rc::clone(&a)));
        println!("Count after creating c = {}", Rc::strong_count(&a));

        let d = Cons(1, Rc::clone(&c));

        println!("Count after creating d = {}", Rc::strong_count(&a));

    }
    println!("Count after c goes out of scope = {}", Rc::strong_count(&a));
}
