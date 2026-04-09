

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
}
