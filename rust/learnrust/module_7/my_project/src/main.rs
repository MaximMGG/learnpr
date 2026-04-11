
use std::collections::HashMap;

fn main() {
    println!("Module 7, packages, crates and Modules");

    let mut map = HashMap::new();

    map.insert(1, 2);



    for (k, v) in map.iter() {
        println!("{k} -> {v}");
    }

}


// use std::fmt::Result;
// use std::io::Result as IoResult;

// use std::{fmt, io};
// use std::io::{self, Write};
// use std::collections::*;
// fn func1() -> Result {
//
// }
//
// fn func2() -> IoResult<()> {}


