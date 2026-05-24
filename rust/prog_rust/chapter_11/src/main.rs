
use std::fs::File;
use std::io::{self, Write};


fn say_hello(out: &mut dyn Write) -> io::Result<()> {
    out.write_all(b"Hello world\n")?;
    out.flush()
}
 
fn main() {
    println!("Chapter 11. Traits and Generics");

    let mut f = File::create("Sumper_file.txt").unwrap();

    _ = say_hello(&mut f).unwrap();

    let mut bytes = vec![];
    say_hello(&mut bytes).unwrap();
    assert_eq!(bytes, b"Hello world\n");

    let (a, b) = (3, 9);

    let res = min(a, b);
    println!("Res min() is -> {res}");

    let mut buf: Vec<u8> = vec![];
    let writer: &mut dyn Write = &mut buf;
    match writer.write(b"ijij") {
        Ok(val) => {
            println!("Write {val} bytes");
        },
        Err(e) => {
            println!("{e}");
        }
    }
}

fn min<T: std::cmp::Ord>(value1: T, value2: T) -> T {
    if value1 <= value2 {
        value1
    } else {
        value2
    }
}
