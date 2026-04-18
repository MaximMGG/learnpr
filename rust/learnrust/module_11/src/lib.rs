

#[derive(Debug, PartialEq)]
struct Rectangle {
    width: u32,
    height: u32,
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
}
