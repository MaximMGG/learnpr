


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
    println!("String collection");
    let data = "initial contents";

    let d: u32 = 123;
    let s = data.to_string();
    let d_string = d.to_string();
    assert_eq!("123", d_string);

    println!("{s}");

}


