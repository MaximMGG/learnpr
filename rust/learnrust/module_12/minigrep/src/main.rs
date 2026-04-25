

use std::env;
use std::fs;
use std::error::Error;
use minigrep::search;
use minigrep::search_case_insensitive;

fn main() {

    // let args: Vec<String> = env::args().collect();
    //
    // let config = Config::build(&args).unwrap_or_else(|err| {
    //     eprintln!("Problem parseing arguments: {err}");
    //     std::process::exit(1);
    // });

    let config = Config::build(env::args()).unwrap_or_else(|err| {
        eprintln!("Problem parseing arguments: {err}");
        std::process::exit(1);
    });

    println!("Searching for {}", config.query);
    println!("In file {}", config.file_path);

    if let Err(e) = run(config) {
        eprintln!("Application error: {e}");
        std::process::exit(1);
    }
}


fn run(config: Config) -> Result<(), Box<dyn Error>>{
    let contents = fs::read_to_string(config.file_path)?;


    let result = if config.ignore_case {
        search_case_insensitive(&config.query, &contents)
    } else {
        search(&config.query, &contents)
    };

    for res in &result {
        println!("{res}");
    }

    Ok(())
}

struct Config {
    query: String,
    file_path: String,
    ignore_case: bool,
}

impl Config {

    fn build(mut args: impl Iterator<Item = String>) -> Result<Config, &'static str> {
        args.next();

        let query = match args.next() {
            Some(arg) => arg,
            None => return Err("Didn't get a query string"),
        };

        let file_path = match args.next() {
            Some(arg) => arg,
            None => return Err("Didn't get a file path"),
        };

        let ignore_case = env::var("IGNORE_CASE").is_ok();

        Ok(Config {
            query,
            file_path,
            ignore_case,
        })
    }
}

