
use std::cell::RefCell;


#[derive(Debug)]
enum List<T> {
    Cons(Rc<RefCell<T>>, Rc<List<T>>),
    Nil,
}


use crate::List::{Cons, Nil};
use std::rc::Rc;

fn main() {
    let value = Rc::new(RefCell::new(5));

    let a = Rc::new(Cons(Rc::clone(&value), Rc::new(Nil)));

    let b = Cons(Rc::new(RefCell::new(3)), Rc::clone(&a));

    let c = Cons(Rc::new(RefCell::new(4)), Rc::clone(&a));


    *value.borrow_mut() += 10;

    println!("a after = {a:?}");
    println!("a after = {b:?}");
    println!("a after = {c:?}");
}
