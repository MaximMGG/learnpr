use std::io;

fn main() {

    let num: u32 = match "42".parse() {
        Ok(num) => num,
        Err(_) => 55,
    };

    println!("Num is: {num}");


    let tup = (500, 6.4, 1);

    println!("Tup is: {:?}", tup);

    let (x, y, z) = tup;
    println!("Y: {y}");
    _ = x;
    _ = z;
    println!("Tup(1): {}", tup.1);

    let arr = [1, 2, 3, 4, 5];
    println!("Arr is: {:?}", arr);
    println!("Arr len is: {}", arr.len());

    let a: [i32; 4] = [1, 2, 3, 4];
    println!("Arr of i32: {:?}", a);

    let b = [3; 5]; // 5 element each of them is 3
    _ = b;

    do_stuf();
	nasted_asigment();
	let y = get_num(123);
	println!("Get num is: {y}");

	let res = cond_res(false);
	println!("Cond res is: {res}");

	println!("Result from loop: {}", from_loop(12));
	loop_lables();
	in_element_for();
	for_range();
	println!("Fibonache of 7: {}", fibonache(14));
}

fn do_stuf() {
    let arr = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0];
	let x = 3;
	if x == 3 {
		return;
	}

    loop {
        let mut index = String::new();
        io::stdin().read_line(&mut index).expect("Failed to read line");

        if index.trim() == "exit" {
            break;
        }

        let i: usize = match index.trim().parse() {
            Ok(num) => num,
            Err(_) => 0,
        };
        if i > (arr.len() - 1) {
            println!("Try agane");
            continue;
        }
        println!("Element: [{}]", arr[i]);
    }
}


fn nasted_asigment() {
	let y = {
		let x = 3;
		x + 3
    };
	println!("y = {y}");
}

fn get_num(x: u32) -> u32 {
	x + 4
} 

fn cond_res(cond: bool) -> i32 {
	return if cond {123} else {999};
}

fn from_loop(count: u32) -> u32 {
	let mut i = 0;

	let res = loop {
		if i == count {
			break 10 + i;
		}
		i += 1;
	};
	return res;
}

fn loop_lables() {
	let mut count = 0;
	'counting_up: loop {
		println!("count = {count}");
		let mut remaining = 10;

		loop {
			println!("remaining = {remaining}");
			if remaining == 9 {
				break;
			}
			if count == 2 {
				break 'counting_up;
			}
			remaining -= 1;
		}
		count += 1;
	}
	println!("End count = {count}");
}

fn in_element_for() {
	let arr = [1, 2, 3, 4, 5, 6, 7, 99];

	for e in arr {
		println!("Element: {e}");
	}
}

fn for_range() {
	for i in 1..5 {
		println!("I: {i}");
	}
}

fn fibonache(num: u64) -> u64 {
	if num == 1 {
		return num;
	} else {
		return num * fibonache(num - 1);
	}
}
