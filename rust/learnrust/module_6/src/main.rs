

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
}

fn main2() {
	let _some_number = Some(5);
	let _some_char = Some('e');

	let _absent_number: Option<i32> = None;
}

enum Coin {
	Penny,
	Nickel,
	Dime,
	Quarter,
}

fn value_in_cents(coin: Coin) -> u8 {
	match coin {
		Coin::Penny => {
			println!("Lacky penny");
			1
		}
		Coin::Nickel => 5,
		Coin::Dime => 10,
		Coin::Quarter => 25,
	}
}

fn main3() {
	let c = Coin::Penny;

	println!("coin is: {}", value_in_cents(c));
}


