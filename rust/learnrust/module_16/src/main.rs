use std::thread;
use std::time::Duration;


fn main() {

    let arr = vec![1, 2, 3];
    
    let handle = thread::spawn(move || {
        println!("Here's a vector: {:?}", arr);
    });

    handle.join().unwrap();
}
