
use std::{ffi::c_int, ops::Drop, marker::Sized, fmt::Display};

struct Appelation {
    name: String,
    nicknames: Vec<String>
}

impl Drop for Appelation {
    fn drop(&mut self) {
        print!("Dropping {}", self.name);
        if !self.nicknames.is_empty() {
            print!(" (AKA {})", self.nicknames.join(", "));
        }
        println!("");
    }
}

use libc;

struct FileDesc {
    fd: c_int
}

impl FileDesc {
    fn new() -> FileDesc {
        let path = std::ffi::CString::new("Cargo.toml").unwrap();
        let res = FileDesc{fd: unsafe {libc::open(path.as_ptr(), libc::O_RDONLY)}};
        res
    }
}

impl Drop for FileDesc {
    fn drop(&mut self) {
        unsafe {libc::close(self.fd)};
        println!("Close Cargo.toml");
    }
}

fn main() {
    println!("Chapter 13, special traits");

    {
        let mut a = Appelation {
            name: "Zeus".to_string(),
            nicknames: vec!["could collector".to_string(),
                            "king of the gods".to_string()] };
        println!("Before assignment");
        a = Appelation {name: "Hera".to_string(), nicknames: vec![]};
        println!("at end of block");
    };

    let p;
    {
        let q = Appelation {
            name: "Caramine hirsuta".to_string(),
            nicknames: vec!["shotweed".to_string(),
            "bittercress".to_string()]
        };
        if compilcated_condition() {
            p = q;
        }
    }
    println!("Sproing! What was that?");

    let mut f = FileDesc::new();

    println!("?Sized");

    let boxed_lunch: RcBox<String> = RcBox {
        ref_count: 1,
        value: "lunch".to_string()
    };

    let boxed_displayable: &RcBox<dyn Display> = &boxed_lunch;
    display(&boxed_lunch);

}

fn compilcated_condition() -> bool {
    true
}

struct RcBox<T: ?Sized> {
    ref_count: usize,
    value: T,
}

fn display(boxed: &RcBox<dyn Display>) {
    println!("For your enjoyment: {}", &boxed.value);
}




