use std::thread;
use std::sync::mpsc;
use std::time::Duration;
use std::sync::Mutex;


fn main() {

    let arr = vec![1, 2, 3];
    
    let handle = thread::spawn(move || {
        println!("Here's a vector: {:?}", arr);
    });


    handle.join().unwrap();
    //channel_example();
    chared_state_concurrency();
}

fn channel_example() {
    let (tx1, rx) = mpsc::channel();

    let tx2 = tx1.clone();
    thread::spawn(move || {
        let vals = vec![
            String::from("hi"),
            String::from("from"),
            String::from("the"),
            String::from("thread"),
        ];

        for val in vals {
            tx1.send(val).unwrap();
            thread::sleep(Duration::from_secs(1));
        }
    });

    thread::spawn(move || {
        let vals = vec![
            String::from("more"),
            String::from("messages"),
            String::from("for"),
            String::from("you"),
        ];

        for val in vals {
            tx2.send(val).unwrap();
            thread::sleep(Duration::from_secs(1));
        }
    });

    for received in rx {
        println!("Got: {received}");
    }
}

use std::sync::Arc;

fn race_cond() {
    let m = Mutex::new(0 as i32);
    let a = Arc::new(m);
    let b = Arc::clone(&a);

    let handle = thread::spawn(move || {
        for _ in 0..100 {
            let mut num = b.lock().unwrap();
            *num += 1;
        }
    });

    for _ in 0..100 {
        *a.lock().unwrap() += 1;
    }

    handle.join().unwrap();

    println!("val is {}", a.lock().unwrap());

}


fn chared_state_concurrency() {
    println!("Race cond");
    race_cond(); 
    let m = Mutex::new(5);

    {
        let mut num = m.lock().unwrap();
        *num = 7;
    }

    println!("m = {m:?}");
    chared_state_concurrency_2();

}
fn chared_state_concurrency_2() {
    let counter = Arc::new(Mutex::new(0));
    let mut handles = vec![];

    for _ in 0..10 {
        let counter = Arc::clone(&counter);
        let handle = thread::spawn(move || {
            let mut num = counter.lock().unwrap();
            *num += 1;
        });
        handles.push(handle);
    }

    for h in handles {
        h.join().unwrap();
    }

    println!("Val is {}", *counter.lock().unwrap());

}
