
use std::rc::Rc;

fn main() {
    let s: Rc<String> = Rc::new("shirataki".to_string());
    let t: Rc<String> = s.clone();
    let u: Rc<String> = s.clone();

    println!("Rc: {}", Rc::strong_count(&s));

}
