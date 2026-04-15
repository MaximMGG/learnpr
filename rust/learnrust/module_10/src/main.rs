
use module_10::*;
use module_10::utils::helper;


#[derive(Debug)]
struct Point<T, U> {
    x: T,
    y: U,
}

impl<T, U> Point<T, U> {
    fn x(&self) -> &T {
        &self.x
    }

    fn mixup<A, B>(self, other: Point<A, B>) -> Point<T, B> {
        Point {
            x: self.x,
            y: other.y,
        }
    }
}

impl Point<f32, i32> {
    fn distance_from_origin(&self) -> f32 {
        (self.x.powi(2) + self.y.pow(2) as f32).sqrt()
    }
}

fn main() {
    println!("============MODULE_10=============");

    let number_list = vec![34, 50, 25, 100, 65];

    let biggest = largest(&number_list);

    println!("Biggest number from list is: {biggest}");

    let char_list = vec!['a', 'Z', 'i', 'w'];

    let biggest_char = largest(&char_list);
    println!("Biggest char: {biggest_char}");


    let x = Point{x: 10, y: 34};
    let y = Point{x: 1.1, y: 9.8};
    let z = Point{x: 8.3 as f32, y: 123 as i32};
    println!("x: {x:?}, {}, y: {y:?}", x.x());
    println!("Distance: {}", z.distance_from_origin());
    let new_x = x.mixup(y);
    println!("new_x: {new_x:?}");

    main2();
    helper();
    main3();
}


fn largest<T: std::cmp::PartialOrd>(list: &[T]) -> &T {
    let mut largest = &list[0];

    for num in list {
        if num > largest {
            largest = num;
        }
    }
    largest
}

fn main2() {
    let post = SocialPost{
        username: String::from("horse_ebooks"),
        content: String::from("of course, as you probably already know, people"),
        reply: false,
        repost: false,
    };

    println!("1 new post: {}", post.summarize());
    notify(&post);
    notify2(&post);
}

fn main3() {
    let string1 = String::from("abcd");
    let string2 = "abc";

    let result = longest(string1.as_str(), string2);
    println!("The longest string is {}", result);


    let result2 = longest2(string1.as_str(), string2);
    println!("Longest 2: {}", result2);
} 

fn longest(a: &str, b: &str) -> String {
    if a.len() > b.len() {
        return String::from(a)
    } else {
        return String::from(b)
    }
}

fn longest2<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        return x
    } else {
        return y
    }
}


