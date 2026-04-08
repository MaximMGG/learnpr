


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
}

fn build_user(email: String, username: String) -> User {
	User { 
		active: true,
		username,
		email,
		sign_in_count: 1,
	}
}
