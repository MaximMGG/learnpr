

#[derive(Debug)]
enum IpAddr {
    V4(u8, u8, u8, u8),
    V6(String),
}

enum Message {
    Quit,
    Move {x: u32, y: u32},
    Write(String),
    ChangeColor(i32, i32, i32),
}

impl Message {
    fn call(&self) {

    }
}

fn main() {
    let home = IpAddr::V4(127, 0, 0, 1);
    let loopbak = IpAddr::V6(String::from("::1"));

    println!("home: {home:?}");
    println!("loopback: {loopbak:?}");

    let m = Message::Write(String::from("write"));

    m.call();
	main2();
	main3();
	main4();
	main5();
	main6();
	main7();
}

fn main2() {
	let _some_number = Some(5);
	let _some_char = Some('e');

	let _absent_number: Option<i32> = None;
}

#[derive(Debug)]
enum UsState {
	Alabama,
	Alaska,
}

impl UsState {
	fn existed_in(&self, year: u16) -> bool {
		match self {
			UsState::Alabama => year >= 1819,
			UsState::Alaska => year >= 1959,
		}
	}
}

enum Coin {
	Penny,
	Nickel,
	Dime,
	Quarter(UsState),
}

fn value_in_cents(coin: Coin) -> u8 {
	match coin {
		Coin::Penny => {
			println!("Lacky penny");
			1
		}
		Coin::Nickel => 5,
		Coin::Dime => 10,
		Coin::Quarter(state) => {
			println!("State quarter from {state:?}");
			25
		}
	}
}

fn main3() {
	let c = Coin::Penny;

	println!("coin is: {}", value_in_cents(c));

	let c = Coin::Quarter(UsState::Alabama);

	println!("coin 2 is : {}", value_in_cents(c));
}

fn plus_five(x: Option<i32>) -> Option<i32> {
	match x {
		None => None,
		Some(i) => Some(i + 1) 
	}
}


fn main4() {
	let five = Some(5);
	let six = plus_five(five);
	let none = plus_five(None);
	println!("six: {six:?}");
	println!("none: {none:?}");
}

fn add_fancy_hat(){}
fn remove_fancy_hat(){}
fn reroll(){}


fn main5() {
	//catch all patterns and the _ placeholder

	let dice_roll = 9;
	match dice_roll {
		3 => add_fancy_hat(),
		5 => remove_fancy_hat(),
		_ => reroll(),
		//_ => (), or it could be liki that
	}
}


fn main6() {
	println!("main6: concise control flow with if let and let...else");

	let config_max = Some(3u8);

	match config_max {
		Some(max) => println!("The maximum is configured to be {max}"),
		_ => (),
	}

	if let Some(max) = config_max {
		println!("in If statement the maximum is configured to be {max}");
	}
}


fn describe_state_quarter(coin: Coin) -> Option<String> {
	if let Coin::Quarter(state) = coin {
		if state.existed_in(1900) {
			Some(format!("{state:?} is pretty old, for America!"))
		} else {
			Some(format!("{state:?} is relatively new"))
		}
	} else {
		None
	}
}

fn describe_state_quarter2(coin: Coin) -> Option<String> {
	let state = if let Coin::Quarter(state) = coin {
		state
	} else {
		return None
	};

	if state.existed_in(1900) {
		Some(format!("{state:?} is pretty old, for America!"))
	} else {
		Some(format!("{state:?} is relatively new."))
	}
}

fn describe_state_quarter3(coin: Coin) -> Option<String> {
	let Coin::Quarter(state) = coin else {
		return None
	};

	if state.existed_in(1900) {
		Some(format!("{state:?} is pretty old, for America!"))
	} else {
		Some(format!("{state:?} is relatively new."))
	}
}

fn main7() {
	let c = Coin::Quarter(UsState::Alabama);
	let some = describe_state_quarter(c);

	match some {
		Some(t) => println!("Describe state: {t}"),
		None => println!("Descibtion doesn't exists"),
	}
}

