
use std::io;

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
