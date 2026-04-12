use std::{fs::File, io::Read};
use std::io::ErrorKind;


fn main() {
    println!("==========module_9 error hendling============");



    // let greeting_file_result = File::open("hello.txt");
    // let greeting_file = match greeting_file_result {
    //     Ok(file) => file,
    //     Err(e) => panic!("{e}"),
    // };
    
    // let greeting_file = match File::open("hello.txt") {
    //     Ok(file) => file,
    //     Err(_) => match File::create("hello.txt") {
    //         Ok(file) => file,
    //         Err(_) => panic!("File::create error"),
    //     }
    // };
    //
    // for b in greeting_file.bytes() {
    //     let c = if let Ok(ch) = b {ch as char} else {'0'};
    //     print!("{c}");
    // }
    // _ = greeting_file;
    

    let greeting_file = match File::open("hello.txt") {
        Ok(file) => file,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create("hello.txt") {
                Ok(fc) => fc,
                Err(e) => panic!("Problem creating the file: {e:?}"),
            },
            _ => {
                panic!("Problem opening the file: {error:?}");
            }

        }
    };
    _ = greeting_file;
    main2();
}

fn main2() { 
    let greeting_file = File::open("hello.txt").unwrap_or_else(|error| {
        if error.kind() == ErrorKind::NotFound {
            File::create("hello.txt").unwrap_or_else(|error| {
                panic!("Problem creating the file: {error:?}");
            })
        } else {
            panic!("Problem opening the file: {error:?}");
        }
    });
    _ = greeting_file;
}
