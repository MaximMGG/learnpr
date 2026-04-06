

fn main() {
    {
        let mut s = String::from("Hello"); // create string on heap

        s.push_str(", world!"); // done one more allocation

        println!("{s}!");

        let mut s2 = String::from("Bye"); // create string on heap

        s2.push_str(" world!"); // done one more allocation

        println!("{s2}!");
        //drop(s2);
        let s3 = s2.clone(); // clone string on heap

        println!("S3 {s3}");

        let s4 = s3; // s3 no longer ivalable

        println!("S4 {s4}");
    }
    
    let mut b: i32 = 123;

    ptr_int(&mut b);
    println!("After ptr_int: {b}");

    main2();
    main3();
    main4();
    main5();
    main6();
    main7();
    main8();
    main9();
}

fn ptr_int(a: *mut i32) {
	unsafe {
		*a += 1;		
	}
}


fn main2() {
	let s = String::from("Hello");

	takes_ownership(s);

	let x = 5;
	makes_copy(x);

	//println!("{s}");
	println!("{x}");
}

fn takes_ownership(some_string: String) {
	println!("{some_string}");
}

fn makes_copy(some_integer: i32) {
	println!("{some_integer}");
}

fn main3() {
	let _s1 = gives_ownership();

	let s2 = String::from("hello");

	let _s3 = takes_and_gives_back(s2);
}

fn gives_ownership() -> String {
	let some_string = String::from("yours");
	some_string
}

fn takes_and_gives_back(a_string: String) -> String {
	a_string
}

fn main4() {
	let s1 = String::from("hello");

	let (s2, len) = calculate_length(s1);

	println!("The length of '{s2}' is {len}");
}

fn calculate_length(s: String) -> (String, usize) {
	let length = s.len();

	(s, length)
}

fn main5() {
	let s1 = String::from("Hello");

	let len = calculate_length2(&s1);

	println!("The length of '{s1}' is {len}");
}

fn calculate_length2(s: &String) -> usize {
	let len = s.len();
	len
}

fn main6() {
    println!("Main6");
    let mut s = String::from("Hello");
    change(&mut s);
    println!("{s}");
}

fn change(s: &mut String) {
    s.push_str(" ,world!");
}

fn main7() {
    println!("main7");
    let mut s = String::from("hello");

    let s1 = &mut s; //here would be a problem
    // let s2 = &mut s; //here would be a problem


    // println!("{s1} {s2}");
    println!("{s1}");

}

fn main8() {
    println!("main8");
    let mut s = String::from("hello");

    let s1 = &s; //here is not a problem
    let s2 = &s;

    // let s3 = &mut s; //and here become a problem

    println!("{s1} {s2}");

    let s3 = &mut s;

    println!("{s3}");

}

fn main9() {
    println!("main9");
    let s = dagle();
    println!("{s}");
}

fn dagle() -> String {
    let s = String::from("Hello");
    s
}

