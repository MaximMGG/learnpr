


struct User {
	active: bool,
	username: String,
	email: String,
	sign_in_count: u64,
}


#[derive(Debug)]
struct Vector(f32, f32, f32);
 
fn main() {
	let mut user1 = User{
		active: true,
		username: String::from("Misha"),
		email: String::from("misha@gmail.com"),
		sign_in_count: 1,
	};

	user1.email = String::from("misha2@gmail.com");
	println!("Hello");

	let user2 = build_user(String::from("Louar@gmail.com"), String::from("Loar"));
	_ = user2;

	let user3 = User {
		username: String::from("Bob"),
		..user1
	};
	_ = user3;


	let v1 = Vector(1.1, 3.3, 3.1);
	println!("{v1:?}");
	_ = v1;
  main2();
  main3();
  main4();
  main5();
}

fn build_user(email: String, username: String) -> User {
	User { 
		active: true,
		username,
		email,
		sign_in_count: 1,
	}
}

#[derive(Debug)]
struct Rectengle {
    width: u32,
    height: u32,
}

impl Rectengle {
    fn area(&self) -> u32 {
        self.width * self.height
    }

    fn can_hold(&self, other: &Rectengle) -> bool {
        self.width > other.width && self.height > other.height
    }

    fn square(size: u32) -> Self {
        Self {
            width: size,
            height: size,
        }
    }
}

fn main2() {
    let rect1 = Rectengle{width: 30, height: 50};
    println!("Rect is {rect1:#?}");
    println!("The area of the rectengle {} square pixels", area(&rect1));

}

fn area(rect: &Rectengle) -> u32 {
    rect.width * rect.height 
}

fn main3() {
    println!("main3");
    let scale = 2;
    let rect1 = Rectengle{
        width: dbg!(30 * scale),
        height: 50,
    };
    dbg!(&rect1);
}

fn main4() {
    println!("main4");
    let rect1 = Rectengle {
        width: 30,
        height: 50,
    };
    println!("The area of the rectengle {} square pixels", rect1.area());
}

fn main5() {
    println!("main5");

    let rect1 = Rectengle{
        width: 30,
        height: 50,
    };

    let rect2 = Rectengle {
        width: 10,
        height: 40,
    };

    let rect3 = Rectengle {
        width: 40,
        height: 45,
    };

    println!("Can rect1 hold rect2? {}", rect1.can_hold(&rect2));
    println!("Can rect1 hold rect3? {}", rect1.can_hold(&rect3));

    println!("Squared rect {:?}", Rectengle::square(40))
}
