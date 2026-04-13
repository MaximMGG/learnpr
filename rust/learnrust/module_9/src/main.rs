use std::{fs, fs::File, io::Read};
use std::io::ErrorKind;
use std::io;
use std::error::Error;


fn main() -> Result<(), Box<dyn Error>> {
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
    Ok(())
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
    shortcuts_for_panic_on_error();
    let username = match read_username_from_file() {
        Ok(name) => name,
        Err(_) => String::from("Can't read name"),
    };
    println!("User name is: {username}");
    let username_2 = read_username_from_file2().unwrap();
    println!("User name 2 is: {username_2}");
    let username_3 = read_username_from_file3();
    println!("{}", username_3.unwrap());
}

fn _main_test() -> Result<String, io::Error> {
    let name = read_username_from_file3()?;
    Ok(name)
}


fn shortcuts_for_panic_on_error() {
    let greeting_file = File::open("hello.txt").unwrap();
    _ = greeting_file;

    let file = File::open("hello.txt").expect("file should be included in project");
    _ = file;
}

fn read_username_from_file() -> Result<String, io::Error> {
   let user_file_result = File::open("hello.txt");

   let mut username_file = match user_file_result {
       Ok(file) => file,
       Err(e) => return Err(e),
   };

   let mut username = String::new();

   match username_file.read_to_string(&mut username) {
       Ok(_) => Ok(username),
       Err(e) => Err(e),
   }
}

fn read_username_from_file2() -> Result<String, io::Error> {
    let mut username = String::new();

    _ = File::open("hello.txt").unwrap().read_to_string(&mut username);
    //let username = fs::read_to_string("hello.txt")?; //just one line

    return Ok(username)
}

fn read_username_from_file3() -> Result<String, io::Error> {
    let mut username_file = File::open("hello.txt")?;
    let mut username = String::new();
    username_file.read_to_string(&mut username)?;
    Ok(username)
}
