

use std::thread;
use std::time::Duration;

#[derive(Debug, PartialEq, Copy, Clone)]
enum ShirtColor {
    Red,
    Blue,
}

struct Inventory {
    shirts: Vec<ShirtColor>,
}

impl Inventory {
    fn giveaway(&self, user_preference: Option<ShirtColor>) -> ShirtColor {
        user_preference.unwrap_or_else(|| self.most_stocked())
    }

    fn most_stocked(&self) -> ShirtColor {
        let mut num_red = 0;
        let mut num_blue = 0;

        for color in &self.shirts {
            match color {
                ShirtColor::Red => num_red += 1,
                ShirtColor::Blue => num_blue += 1,
            }
        }

        if num_red > num_blue {
            ShirtColor::Red
        } else {
            ShirtColor::Blue
        }
    }
}

fn main() {
    let store = Inventory {
        shirts: vec![ShirtColor::Blue, ShirtColor::Red, ShirtColor::Blue]
    };

    let user_pref1 = Some(ShirtColor::Red);
    let giveaway1 = store.giveaway(user_pref1);

    println!("The user with preference {:?} gets {:?}", user_pref1, giveaway1);

    let user_pref2 = None;
    let giveaway2 = store.giveaway(user_pref2);
    println!("The user with preference {:?} gets {:?}", user_pref2, giveaway2);
    capturing_references();
    sorting_example();
}

fn closure_example() {
    let expensive_closure = |num: u32| -> u32 {
        println!("Calculating slowly...");
        thread::sleep(Duration::from_secs(2));
        num
    };
    let a = expensive_closure(3);
    println!("{a}");
}

fn add_one_v1(x: u32) -> u32 { x + 1 }

fn call_add_one() {
    let add_one_v2 = |x: u32| -> u32 { x + 1};
}

fn capturing_references() {
    let list = vec![1, 2, 3];
    println!("Before defining closure: {list:?}");

    let only_borrows = || println!("From closure: {list:?}");

    println!("Before calling closure: {list:?}");
    only_borrows();
    println!("After calling closure: {list:?}");
}

fn move_ownership() { 

    let list = vec![1, 2, 3];

    println!("Before defining closure: {list:?}");

    thread::spawn(move || println!("From thread: {list:?}")).join().unwrap();

}


enum Option2<T> {
    Some2(T),
    None2,
}

impl<T> Option2<T> {
    pub fn unwrap_or_else<F>(self, f: F) -> T
    where F: FnOnce() -> T {
        match self {
            Option2::Some2(x) => x,
            Option2::None2 => f(),
        }
    }
}


#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}


fn sorting_example() {
    let mut list = [
        Rectangle {width: 10, height: 1},
        Rectangle {width: 3, height: 5},
        Rectangle {width: 7, height: 12},
    ];

    let mut sort_operation = 0;

    list.sort_by_key(|r| {
        sort_operation += 1;
        r.width
    });
    println!("Sorted in {sort_operation} operations, \n{list:#?}");

}


