
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

    let v1 = (0..1000).collect::<Vec<i32>>();
    top_ten(&v1);
    let sum_10: i32 = v1[0..10].iter().sum();
    println!("Sum of first 10 elements from v1 is: {sum_10}");

    assert_eq!('$'.is_emoji(), false);

    //let o = a.clone();
    let line = "It is the line of some text";

    let words: Vec<String> = 
        //line.split_whitespace().map(<str as ToString>::to_string).collect();
        //line.split_whitespace().map(ToString::to_string).collect();
        line.split_whitespace().map(|x| x.to_string()).collect();
    //all under the the same
    
    for word in words {
        println!("{word}");
    }


    println!("Test Trait Iterator");
    test_cycles();
}

use std::hash::Hash;
use std::fmt::Debug;
//use std::ops::Add;
use std::ops::AddAssign;

fn top_ten<T: Debug + Hash + Eq + AddAssign + Copy>(values: &Vec<T>) {
    if values.len() < 10 {
        return;
    }

    let mut sum: T = values[0];
    for i in 1..10 {
        sum += values[i];
    }

    println!("Sum of first 10 elements: {:?}", sum);

}

fn min<T: std::cmp::Ord>(value1: T, value2: T) -> T {
    if value1 <= value2 {
        value1
    } else {
        value2
    }
}

use std::io::{Result};

pub struct Sink;

impl Write for Sink {
    fn write(&mut self, buf: &[u8]) -> Result<usize> {
        Ok(buf.len())
    }
    fn flush(&mut self) -> Result<()> {
        Ok(())
    }
}

trait IsEmoji {
    fn is_emoji(&self) -> bool;
}

impl IsEmoji for char {
    fn is_emoji(&self) -> bool {
        false
    }
}

struct HtmlDocument;

trait WriteHtml {
    fn write_html(&mut self, html: &HtmlDocument) -> Result<()>;
}

impl<W: Write> WriteHtml for W {
    fn write_html(&mut self, html: &HtmlDocument) -> Result<()> {
        _ = html;
        Ok(())
    }
}

use std::iter;
use std::vec::IntoIter;

fn cyclical_zyp(v: Vec<u8>, u: Vec<u8>) -> iter::Cycle<iter::Chain<IntoIter<u8>, IntoIter<u8>>> {
    v.into_iter().chain(u.into_iter()).cycle()
}

fn cyclical_zip(v: Vec<u8>, u: Vec<u8>) -> Box<dyn Iterator<Item=u8>> {
    Box::new(v.into_iter().chain(u.into_iter()).cycle())
}

fn cyclical_zip_2(v: Vec<u8>, u: Vec<u8>) -> impl Iterator<Item=u8> {
    v.into_iter().chain(u.into_iter()).cycle()
}


fn test_cycles() {
    let a1: Vec<u8> = vec![1, 2, 3, 4, 7];
    let a2: Vec<u8> = vec![9, 7, 3, 1, 0];

    let mut it = cyclical_zip(a1, a2);

    while let Some(val) = it.next() {
        println!("{val}");
    }

}

use std::fmt::Display;

fn print<T: Display>(val: T) {
    println!("{}", val);
}

fn print_2(val: impl Display) {
    println!("{}", val);
}

fn print_3(val: &dyn Display) {
    println!("{}", val);
}

use std::ops::Add;
use std::ops::Mul;

fn dot<N>(v1: &[N], v2: &[N]) -> N 
    where N: Add<Output=N> + Mul<Output=N> + Default + Copy {
        let mut total = N::default();

        for i in 0..v1.len() {
            total = total + v1[i] * v2[i];
        }
        total
}

#[test]
fn test_dot() {
    assert_eq!(dot(&[1, 2, 3, 4], &[1, 1, 1, 1]), 10);
    assert_eq!(dot(&[53.0, 7.0], &[1.0, 5.0]), 88.0);
}




