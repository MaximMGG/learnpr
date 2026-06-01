use std::collections::HashMap;
use std::fmt::Debug;
use rand::random;
use std::iter::from_fn;
use num::Complex;
use std::iter::successors;

fn escape_time(c: Complex<f64>, limit: usize) -> Option<usize> {
    let zero = Complex{re: 0.0, im: 0.0};

    successors(Some(zero), |&z| {
	Some(z * z + c)
    }).take(limit).enumerate().find(|(_i, z)| z.norm_sqr() > 4.0).map(|(i, _z)| i)
}

fn successors_example() {
    let i: u32 = 0;

    let iterator = successors(Some(i), |n| {
	n.checked_add(500_000_000)
    });

    let v = iterator.collect::<Vec<u32>>();

    for i in &v {
	println!("{i}");
    }
    
}

fn from_fn_example() {
    let lengths: Vec<f64> = from_fn(|| Some((random::<f64>() - random::<f64>()).abs())).take(100).collect();

    (&lengths).iter().for_each(|v| println!("{v}"));

    let sum_vec: u64 = from_fn(|| Some(random::<u64>())).take(200).fold(0, |item, mul| item.overflowing_add(mul).0);

    println!("Sum of 200 u64 values is: {sum_vec}");
}

fn map_example() {
    let mut m: HashMap<i32, String> = HashMap::new();
    m.insert(0, String::from("Sumper str"));
    m.insert(1, String::from("Sumper duper str"));
    m.insert(2, String::from("Sumper str for insert: "));
    m.insert(3, String::from("Sumper str last"));

    println!("Map before change");

    m.iter().for_each(|(k, v)| println!("Key: {k}, Val: {v}"));

    (&mut m).iter_mut().for_each(|(k, v)| if *k == 2 {v.push_str("LOOPP")});
    //(&mut m).into_iter().for_each(|(k, v)| if *k == 2 {v.push_str("OOOO")});
    
    // for (k, v) in &mut m {
    // 	if *k == 2 {
    // 	    v.push_str("LOOPPP");
    // 	}
    // }
    
    println!("After map changed");
    
    m.iter().for_each(|(k, v)| println!("Key: {k}, Val: {v}"));
}


fn dump<T, U>(t: T)
where T: IntoIterator<Item=U>,
      U: Debug
{
    for u in t {
	println!("{:?}", u);
    }
}


fn reg_triangle(n: i32) -> i32 {
    let mut sum = 0;
    for i in 1..=n {
	sum += i
    }
    sum
}

fn renge_triangle(n: i32) -> i32 {
    (1..=n).fold(0, |sum, item| sum + item)
}

fn for_loop_example() {
    println!("There's :");
    let v = vec!["antimony", "aresenic", "aluminum", "selenium"];

    for element in &v {
	println!("{}", element);
    }
}

fn into_iter_example() {
    println!("There's :");
    let v = vec!["antimony", "aresenic", "aluminum", "selenium"];

    let mut it = (&v).into_iter();
    while let Some(el) = it.next() {
	println!("{}", el);
    }
}

fn iter_next() {
    let v = vec![4, 20, 16, 0, 3];

    let mut iterator = v.iter();

    assert_eq!(iterator.next(), Some(&4));
    assert_eq!(iterator.next(), Some(&20));
    assert_eq!(iterator.next(), Some(&16));
    assert_eq!(iterator.next(), Some(&0));
    assert_eq!(iterator.next(), Some(&3));
}

use std::ffi::OsStr;
use std::path::Path;

fn path_ter() {
    let path = Path::new("C:/Users/JimBo/Downloads/Fedora.iso");
    let mut iterator = path.iter();

    assert_eq!(iterator.next(), Some(OsStr::new("C:")));
    assert_eq!(iterator.next(), Some(OsStr::new("Users")));
    assert_eq!(iterator.next(), Some(OsStr::new("JimBo")));
    assert_eq!(iterator.next(), Some(OsStr::new("Downloads")));
    assert_eq!(iterator.next(), Some(OsStr::new("Fedora.iso")));

    dump(path);
}

fn main() {
    println!("Chapter 15, Iterators");

    println!("Triangle reg for loop: {}", reg_triangle(9));
    println!("Triangle range loop: {}", renge_triangle(9));

    
    for_loop_example();
    into_iter_example();
    iter_next();
    path_ter();
    map_example();
    from_fn_example();
    let c = Complex{re: 9.2, im: 8.1};
    let elapsed = escape_time(c, 100).expect("Actually velue");
    println!("Elapsed complex value: {:?} is: {elapsed}", c);
    successors_example();
}

