
use std::io;
use std::path::Path;
use std::fs;

fn main() {
    let r = std::ops::Range{start: 1, end: 20};
    for i in r.rev() {
        println!("Pirate share: {}", pirate_share(20, i));
    }

    // let my_city_weather = get_weather("New York".to_string()).expect("Expect actually whether");
    let my_city_weather = match get_weather("New York".to_string()) {
        Ok(weather) => weather,
        Err(err) => {
            println!("Error querying the weather: {}", err);
            panic!();
        },
    };
    get_weather("e".to_string()).unwrap_or_else(|_e| get_weather("i".to_string()).unwrap());
    println!("{}", my_city_weather.text);
}


fn pirate_share(total: u64, crew_size: usize) -> u64 {
    let half = total / 2;
    half / crew_size as u64
}
struct WeatherReport {
    text: String,
}

fn get_weather(location: String) -> Result<WeatherReport, io::Error> {
    Ok(WeatherReport{text: format!("Weather in {} cool", location)})
}


fn move_all(src: &Path, dst: &Path) -> io::Result<()> {
    for entry_result in src.read_dir()? {
        let entry = entry_result?;
        let dst_file = dst.join(entry.file_name());
        fs::rename(entry.path(), dst_file)?;
    }
    Ok(())
}


use thiserror::Error; // but for this i should use crate thiserror [cargo add thiserror]
//custom errors
#[derive(Error, Debug)]
//#[error("{message:} ({line:}, {column})")]
struct JsonError {
    pub message: String,
    pub line: usize,
    pub column: usize,
}

impl std::fmt::Display for JsonError {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> Result<(), std::fmt::Error> {
        write!(f, "{} ({}:{})", self.message, self.line, self.column)
    }
}

impl std::error::Error for JsonError {}

