use std::thread;

#[derive(Debug)]
struct City {
    name: String,
    population: i64,
    monster_attack_risk: f32
}

#[derive(Copy, Clone)]
struct Statistic {
    a: i64,
    b: i64
}

impl City {
    fn get_statistic(&self, stat: Statistic) -> i64 {
	stat.a + stat.b
    }
}

fn sort_cities(cities: &mut Vec<City>) {
    cities.sort_by_key(|city| -city.population);
}

fn sort_by_statistic(cities: &mut Vec<City>, stat: Statistic) {
    cities.sort_by_key(|city| -city.get_statistic(stat))
}

fn start_sorting_thread(mut cities: Vec<City>, stat: Statistic) -> std::thread::JoinHandle<Vec<City>> {
    let key_fn = move |city: &City| -> i64 {-city.get_statistic(stat)};

    thread::spawn(move || {
	cities.sort_by_key(key_fn);
	cities
    }) 
}
fn city_population_descending(city: &City) -> i64 {
    -city.population
}

fn city_monster_attack_risk_decending(city: &City) -> i64 {
    -1
}

fn sort_fn_example(cities: &mut Vec<City>) {
    let my_key_fn: fn(&City) -> i64 =
	if true {
	    city_population_descending
	} else {
	    city_monster_attack_risk_decending
	};

    cities.sort_by_key(my_key_fn);

    cities.sort_by_key(|city| if true {
	city_population_descending(city)} else {
	    city_monster_attack_risk_decending(city)
	}
    );
}

fn count_selected_cities<F>(cities: &Vec<City>, test_fn: F) -> usize
			    where F: Fn(&City) -> bool  {
    let mut count = 0;
    for city in cities {
	if test_fn(city) {
	    count += 1
	}
    }
    count
}

fn limit_fn(cities: &Vec<City>) {

    let limit: f32 = 0.7;
    let _n = count_selected_cities(cities, |city| city.monster_attack_risk > limit);
}

fn call_twice<F>(mut closure: F) where F: FnMut() {
    closure();
    closure();
}

fn call_twice_example() {
    let mut i = 0;
    let incr = || {
	i += 1;
	println!("Ding! i is now: {i}");
    };
    call_twice(incr);
}

fn main() {
    println!("Chapter 14, Closures");

    let mut cities = vec![City{name: "New York".to_string(), population: 23, monster_attack_risk: 0.7}, City{name: "Boston".to_string(), population: 83838383, monster_attack_risk: 1.1},
			  City{name: "New Jersy".to_string(), population: 888888, monster_attack_risk: 0.4}];

    println!("Before sorting");
    for c in &cities {
	println!("The sity: {:?}", c);
    }
    sort_cities(&mut cities);
    
    println!("After sorting");
    for c in &cities {
	println!("The sity: {:?}", c);
    }

    call_twice_example();
}
