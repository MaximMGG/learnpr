use std::io;

fn main() {

    let num: u32 = match "42".parse() {
        Ok(num) => num,
        Err(_) => 55,
    };

    println!("Num is: {num}");


    let tup = (500, 6.4, 1);

    println!("Tup is: {:?}", tup);

    let (x, y, z) = tup;
    println!("Y: {y}");
    _ = x;
    _ = z;
    println!("Tup(1): {}", tup.1);

    let arr = [1, 2, 3, 4, 5];
    println!("Arr is: {:?}", arr);
    println!("Arr len is: {}", arr.len());

    let a: [i32; 4] = [1, 2, 3, 4];
    println!("Arr of i32: {:?}", a);

    let b = [3; 5]; // 5 element each of them is 3
    _ = b;

    do_stuf();

}

fn do_stuf() {

    let arr = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0];


    loop {
        let mut index = String::new();
        io::stdin().read_line(&mut index).expect("Failed to read line");

        if index.trim() == "exit" {
            break;
        }

        let i: usize = match index.trim().parse() {
            Ok(num) => num,
            Err(_) => 0,
        };
        if i > (arr.len() - 1) {
            println!("Try agane");
            continue;
        }
        println!("Element: [{}]", arr[i]);
    }
}
