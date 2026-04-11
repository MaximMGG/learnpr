


fn main() {
    println!("Module 8, common collections");
    println!("!Vector!");

    let mut v: Vec<i32> = Vec::new();

    let v2: Vec<i32> = vec![1, 2, 3, 4, 5];

    v.push(5);
    v.push(6);
    v.push(7);
    v.push(8);
    v.push(9);

    for (i, x) in v.iter().enumerate() {
        println!("{i} -> {x}");
    }

    let third: &i32 = &v[2];

    println!("The third element is {third}");

    let third: Option<&i32> = v2.get(2);

    let t: &i32 = if let Some(t) = v2.get(9) {t} else {&0};
    println!("Nines element is {t}");

    match third {
        Some(third) => println!("The third lement is {third}"),
        None => println!("There is no third element"),
    }
    main2();
    main3();
    main4();
    main_string();
    hash_map_main();
}


fn main2() {
    let mut v = vec![1, 2, 3, 4, 5];

    let first = &v[0];

    v.push(6);
    //println!("The first element is: {first}");

}

fn main3() {
    let mut v = vec![1, 2, 3, 4, 5, 6];

    let a = &mut v[0];
    *a += 1;

    println!("first element after mut");

    for i in &v {
        println!("{i}");
    }

    for i in &mut v {
        *i += 50;
    }

    for i in &v {
        println!("{i}");
    }
}

#[derive(Debug)]
enum SpreadsheetCell {
    Int(i32),
    Float(f32),
    Text(String),
}

fn main4() {
    let row = vec![ SpreadsheetCell::Int(3),
                    SpreadsheetCell::Float(10.10),
                    SpreadsheetCell::Text(String::from("Super text"))
    ];
    let c = &row[0];

    println!("{c:?}");

    for x in &row {
        println!("{x:?}");
    }
}

fn main_string() {
    println!("=============String collection============");
    let data = "initial contents";

    let d: u32 = 123;
    let s = data.to_string();
    let d_string = d.to_string();
    assert_eq!("123", d_string);

    println!("{s}");

    push_to_string();
    concatenate_str();
    iterating_through_str();
}

fn push_to_string() {
    let mut s1 = String::from("foo");
    let s2 = String::from(" bar");
    s1.push_str(" bar");
    s1.push_str(s2.as_str());
    s1.push('l');
    println!("s1: {s1}, s2: {s2}");

    s1 += &s2;
    // let s3 = s1 + &s2; after the s1 will be borrowed
    println!("s1 += &s2 => {s1}");
}

fn concatenate_str() {
    let s1 = String::from("tic");
    let s2 = String::from("tac");
    let s3 = String::from("toe");

    //let s = s1 + "-" + &s2 + "-" + &s3;
    let s = format!("{s1}-{s2}-{s3}");

    println!("{s}");
}

fn iterating_through_str() {
    let mut s1 = String::from("String for iteration");
    s1 = s1.replace("for", "the");

    for i in s1.chars() {
        println!("{i}");
    }
}

use std::collections::HashMap;

fn hash_map_main() {
    let mut scores = HashMap::new();

    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Yellow"), 15);

    let team_name = String::from("Blue");
    let score = scores.get(&team_name).copied().unwrap_or(0);
    println!("Score blue team is: {score}");


    for (k, v) in &scores {
        println!("{k} -> {v}");
    }

    borrowed_keys();
}

fn borrowed_keys() {
    
    let one = String::from("One");
    let two = String::from("Two");


    let mut vals = HashMap::new();

    vals.insert(one, two); // here 'one' and 'two' borrowed to hashmap

    for (k, v) in &vals {
        println!("{k} -> {v}");
    }
    // println!("{one}"); 
}


