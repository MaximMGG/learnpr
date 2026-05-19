


pub mod lib {
    pub fn add_two(t: u32, v: u32) -> u32 {
        t + v
    }
}


#[cfg(test)]
pub mod tests {

    use super::*;

    #[test]
    fn add_two_test() {
        let res = lib::add_two(3, 5);
        assert_eq!(res, 8);
    }
}
