use std::{ffi::c_int, ops::Drop, marker::Sized, fmt::Display};
use std::ops::{Deref, DerefMut};
use std::collections::HashSet;
use std::convert::AsRef;
use glium;

struct Appelation { name: String,
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

    let mut s = Selector{elements: vec!['x', 'y', 'z'], current: 2};

    assert_eq!(*s, 'z');

    assert!(s.is_alphabetic());

    *s = 'w';

    assert_eq!(s.elements, ['x', 'y', 'w']);

    let s2 = Selector {elements: vec!["good", "bad", "ugly"], current: 2};

    show_it(&s2);
    show_it_generic(&s2 as &str);
    //show_it_generic(&*s2); the same

    let squares = [4, 9, 16, 15, 36, 49, 64];
    let (powers_of_two, impure): (HashSet<i32>, HashSet<i32>) =
            squares.iter().partition(|&n| n & (n-1) == 0);

    assert_eq!(powers_of_two.len(), 3);
    assert_eq!(impure.len(), 4);

    let (upper, lower): (String, String) =
            "Great Teacher Onizuka".chars().partition(|&c| c.is_uppercase());

    assert_eq!(upper, "GTO");
    assert_eq!(lower, "reat eacher nizuka");

    let params = glium::DrawParameters{
        line_width: Some(0.02),
        point_size: Some(0.02),
        .. Default::default()
    };
    println!("{:?}", params);
    try_into_test();
}


fn show_it_generic<T: Display>(thing: T) {
    println!("{}", thing);
}

fn show_it(thing: &str) {
    println!("{}", thing);
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

struct Selector<T> {
    elements: Vec<T>,
    current: usize
}


impl<T> Deref for Selector<T> {
    type Target = T;
    fn deref(&self) -> &T {
        &self.elements[self.current]
    }
}

impl<T> DerefMut for Selector<T> {
    fn deref_mut(&mut self) -> &mut T {
        &mut self.elements[self.current]
    }
}


// impl<'a, T, U> AsRef<U> for &'a T
// where T: AsRef<U>,
//       T: ?Sized, U: ?Sized
// {
//     fn as_ref(&self) -> &U {
//         (*self).as_ref()
//     }
// }

fn try_into_test() {
    let huge = 2_000_000_000;
    let smaller = huge.try_into().unwrap_or_else(|_| {
        if huge >= 0 {
            i32::MAX
        } else {
            i32::MIN
        }
    });
    println!("{smaller}");
}

use std::borrow::Cow;
use std::error::Error;

fn decribe(error: &Error) -> Cow<'static, str> {
    match *error {
	Error::OutOfMemory => "out of memory".into(),
	Error::StackOverflow => "out of memory".into(),
	Error::MachineOnFire => "out of memory".into(),
	Error::Unfathomable => "out of memory".into(),
	Error::FileNotFound(ref path) => {
	    format!("file not found: {}", path.display()).into()
	}
    }
}





