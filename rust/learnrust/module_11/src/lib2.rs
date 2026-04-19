


fn prints_and_resturns_10(a: i32) -> i32 {
    println!("I got the value {a}");
    10
}

#[cfg(test)]
mod tests {

    use super::*;


    #[test]
    fn this_test_will_pass() {
        let value = prints_and_resturns_10(3);
        assert_eq!(value, 10);
    }

    #[test]
    fn this_test_will_fail() {
        let value = prints_and_resturns_10(8);
        assert_ne!(value, 5);
    }

    #[test]
    fn only_one() {
        let val = prints_and_resturns_10(1);
        assert_eq!(val, 10);
    }

}


