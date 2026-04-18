

#[derive(Debug, PartialEq)]
struct Rectangle {
    width: u32,
    height: u32,
}

pub struct Guess {
    value: i32
}

impl Guess {
    pub fn new(value: i32) -> Guess {

        if value < 1 {
            panic!("Guess value must be greater than or equal to 1, got {value}");
        } else if value > 100 {
            panic!("Guess value must be less than or equal to 100, got {value}");
        }
        Guess{value}
    }
}


impl Rectangle {
    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }
}

pub fn add(left: u64, right: u64) -> u64 {
    left + right
}

pub fn shure_faild() {
    panic!("Control panic");
}

pub fn greeting(name: &str) -> String {
    format!("Hello {name}")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn exploration() {
        let result = add(4, 2);
        assert_eq!(result, 6);
    }

    #[test]
    #[should_panic]
    fn another() {
        panic!("Make this test fail");
    }

    #[test]
    fn larger_can_hold_smaller() {
        let larger = Rectangle {
            width: 8,
            height: 7,
        };

        let smaller = Rectangle {
            width: 4,
            height: 2,
        };

        assert!(larger.can_hold(&smaller));
    }

    #[test]
    fn smaller_cannot_hold_larger() {
        let larger = Rectangle {
            width: 8,
            height: 7,
        };
        let smaller = Rectangle {
            width: 4,
            height: 2,
        };

        assert!(!smaller.can_hold(&larger));
    }

    #[test]
    fn equalse_rects() {
        let r1 = Rectangle {width: 3, height: 3};
        let r2 = Rectangle {width: 3, height: 3};

        assert_eq!(r1, r2);
    }

    #[test]
    fn greeting_contains_name() {
        let res = greeting("Carol");

        assert!(res.contains("Carol"), "Greeting did not contain name, vlaue was '{res}'");
    }

    #[test]
    #[should_panic(expected = "less than or equal to 100")]
    fn greater_than_100() {
        let g = Guess::new(200);
    }

    #[test]
    fn it_works() -> Result<(), String> {
        let result = add(2, 2);
        if result == 4 {
            Ok(())
        } else {
            Err(String::from("two plus two does not equal four"))
        }
    }
}
