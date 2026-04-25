
fn main() {
    println!("Box<T>");

    let a = Box::new(5);

    println!("a = {a}");

    let mut arr = Box::<[i32]>::new_zeroed_slice(3);
}
