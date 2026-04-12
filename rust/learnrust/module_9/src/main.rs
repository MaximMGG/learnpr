use std::{fs::File, io::Read};


fn main() {
    println!("==========module_9 error hendling============");



    // let greeting_file_result = File::open("hello.txt");
    // let greeting_file = match greeting_file_result {
    //     Ok(file) => file,
    //     Err(e) => panic!("{e}"),
    // };
    
    let greeting_file = match File::open("hello.txt") {
        Ok(file) => file,
        Err(_) => match File::create("hello.txt") {
            Ok(file) => file,
            Err(_) => panic!("File::create error"),
        }
    };

    for b in greeting_file.bytes() {
        let c = if let Ok(ch) = b {ch as char} else {'0'};
        print!("{c}");
    }
    _ = greeting_file;
}

