
#[derive(Copy, Clone, Debug, PartialEq)]
enum TimeUnit {
    Seconds,
    Minutes,
    Hours,
    Days,
    Months,
    Years
}

impl TimeUnit {
    fn plural(self) -> &'static str {
        match self {
            TimeUnit::Seconds => "seconds",
            TimeUnit::Minutes => "minutes",
            TimeUnit::Hours => "hours",
            TimeUnit::Days => "days",
            TimeUnit::Months => "month",
            TimeUnit::Years => "years",
        }
    }

    fn singular(self) -> &'static str {
        self.plural().trim_end_matches('s')
    }
}

#[derive(Copy, Clone, Debug, PartialEq)]
enum RoughTime {
    InThePast(TimeUnit, u32),
    JustNow,
    UnTheFuture(TimeUnit, u32),
}

struct Point3d (u32, u32, u32);

impl Point3d {
    const ORIGIN: Point3d = Point3d(1 as u32, 1 as u32, 1 as u32);
}

enum Shape {
    Sphere {center: Point3d, radius: f32},
    Cuboid {center1: Point3d, corner2: Point3d},
}

use std::collections::HashMap;

enum Json {
    Null,
    Boolean(bool),
    Number(f64),
    String(String),
    Array(Vec<Json>),
    Object(Box<HashMap<String, Json>>)
}

enum BinaryTree<T> {
    Empty,
    NonEmpty(Box<TreeNode<T>>)
}

struct TreeNode<T> {
    element: T,
    left: BinaryTree<T>,
    right: BinaryTree<T>
}

use std::cmp::Ord;

impl<T: Ord> BinaryTree<T> {
    fn add(&mut self, value: T) {
        match *self {
            BinaryTree::Empty => {
                *self = BinaryTree::NonEmpty(Box::new(TreeNode{
                    element: value,
                    left: BinaryTree::Empty,
                    right: BinaryTree::Empty,
                }))
            },
            BinaryTree::NonEmpty(ref mut node) => {
                if value > node.element {
                    node.right.add(value);
                } else {
                    node.left.add(value);
                }
            }
        }
    }
}



fn main() {
    let four_score_and_seven_years_ago = RoughTime::InThePast(TimeUnit::Years, 4 * 20 + 7);
    println!("Time: {:?}", four_score_and_seven_years_ago);

    let _unit_sphere = Shape::Sphere {center: Point3d::ORIGIN, radius: 1.0};
    process();

    let nobody: &[&str] = &[];
    let one = &["Billy"];
    let two = &["Billy", "Misha"];
    let many = &["Billy", "Misha", "Jesika", "John"];
    greet_people(nobody);
    greet_people(one);
    greet_people(two);
    greet_people(many);

    let res = matchasisimo(Some(2 as u32), 2 as u32);
    println!("Match res: {res}");


}

use std::cmp::Ordering::*;

fn describe_point(x: i32, y: i32) -> &'static str {
    match (x.cmp(&0), y.cmp(&0)) {
        (Equal, Equal) => "at the origin",
        (_, Equal) => "on the x axis",
        (Equal, _) => "on the y axis",
        (Greater, Greater) => "in the first quadrant",
        (Less, Greater) => "in the second quadrant",
        _ => "somewhere else",
    }
}

struct Account {
    name: String,
    language: String,
    id: u32,
    status: String,
    address: String,
    birthday: String,
}

fn get_accont() -> Option<Account> {
    Some(Account {
        name: "Misha".to_string(),
        language: "en".to_string(),
        id: 1 as u32,
        status: "ijij".to_string(),
        address: "ijij".to_string(),
        birthday: "ijij".to_string(),
    })
}

fn process() {
    match get_accont() {
        Some(Account {name, language, ..}) => {
            println!("{name}: {language}");
        },
        None => {
            println!("Doesn't have an account");
        }
    }

}


fn hsl_to_rgb(hsl: [u8; 3]) -> [u8; 3] {
    match hsl {
        [_, _, 0] => [0, 0, 0],
        [_, _, 255] => [255, 255, 255],
        _ => [1, 1, 1]
    }
}

fn greet_people(names: &[&str]) {
    match names {
        [] => {println!("Hello, nobody!")},
        [a] => {println!("Hello, {a}.")},
        [a, b] => {println!("Hello, {a} and {b}.")},
        [a, .., b] => println!("Hello, everyone from {a} to {b}.")
    }
}

fn matchasisimo(i: Option<u32>, x: u32) -> u32{
    match i {
        Some(val) if val == x => {
            0
        }
        None => {
            999
        }
        Some(val) => {
            val * 3
        }
    }
}


