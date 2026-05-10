
fn print_padovan(padovan: &mut Vec<i32>) {
    for i in 3..10 {
        let next = padovan[i - 3] + padovan[i-2];
        padovan.push(next);
    }
    println!("P(1..10) = {:?}", padovan);
}



fn increase(mut _i: &Box<i32>) {
    
}

fn main() {
    let mut padovan = vec![1, 1, 1];
    print_padovan(&mut padovan);


    let i = Box::new(0 as i32);
    increase(&i);

    println!("{i}");



    let mut v = Vec::new();

    for i in 101..106 {
        v.push(i.to_string());
    }

    let third = v[2].clone();
    let fours = v[3].clone();

    println!("{third} - {fours}");

    let fifth = v.pop().expect("Vector empty!");

    assert_eq!(fifth, "105");
    let second = v.swap_remove(1);
    assert_eq!(second, "102");
    let third = std::mem::replace(&mut v[2], "substitute".to_string());
    assert_eq!(third, "103");
    assert_eq!(v, vec!["101", "104", "substitute"]);
    some_struct();
}

struct Person {
    name: Option<String>,
    birth: i32,
}


fn some_struct() {

    let mut composer = Vec::new();
    composer.push(Person{name: Some("Palestrina".to_string()), birth: 1525});

    let first_name = std::mem::replace(&mut composer[0].name, None);
    assert_eq!(first_name, Some("Palestrina".to_string()));
    assert_eq!(composer[0].name, None);
}

#[derive(Copy, Clone)]
struct Label {
    number: u32
}

fn print(l: Label) {
    println!("STAMP: {}", l.number)
}

fn copy_trait() {
    let l = Label{number: 3};
    print(l);
    println!("My label nu8mber is: {}", l.number);

}

