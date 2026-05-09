
#[derive(Debug)]
struct Dog {
    name: String,
    age: u32,
}



fn main() {
    assert_eq!(10_i8 as u16, 10_u16); // in range
    assert_eq!(2525_u16 as i16, 2525_i16); // in range

    assert_eq!(-1_i16 as i32, -1_i32); //sign-extended
    assert_eq!(65353_u16 as i32, 65353_i32); //zero-extended

    assert_eq!(1000_i16 as u8, 232_u8);
    assert_eq!(65535_u32 as i16, -1_i16);

    assert_eq!(-1_i8 as u8, 255_u8);
    assert_eq!(255_u8 as i8, -1_i8);

    //standard library provides some operations as methods
    
    assert_eq!(2_u16.pow(4), 16);
    assert_eq!((-4_i32).abs(), 4);
    assert_eq!(0b101101_u8.count_ones(), 4);

    println!("{}", (-4_i32).abs());
    println!("{}", i32::abs(-4));


    //its panic in debug builds!
    // let mut i = 0;
    // loop {
    //     i *= 10;
    // }

    // let mut i: i32 = 1;
    // loop {
    //     i = i.checked_mul(10).expect("muliplication overflowed");
    // }

    assert_eq!(10_u8.checked_add(20), Some(30));
    assert_eq!(100_u8.checked_add(200), None);
    assert_eq!((-128_i8).checked_div(-1), None);

    //;Wrapping operations return the value equivalent to
    //the mathematically correct module the range
    //of the value:
    assert_eq!(100_u16.wrapping_mul(200), 20000);
    assert_eq!(500_u16.wrapping_mul(500), 53392);

    assert_eq!(500_i16.wrapping_mul(500), -12144);

    assert_eq!(5_i16.wrapping_shl(17), 10);


    //Saturating operations return the representable
    //value that is closest to the mathematically correct 
    //result. In other words, the result is "clamped" to the maximum and minimum
    //values the type can represent:
    assert_eq!(32760_i16.saturating_add(10), 32767);
    assert_eq!((-32760_i16).saturating_sub(10), -32768);

    //Overflowing operations return a tuple (result, overflowed)
    //where result is what the wrapping version of the
    //functions would return, and overflowed is a bool
    //indication whether an overflow occurred:
    assert_eq!(255_u8.overflowing_sub(2), (253, false));
    assert_eq!(255_u8.overflowing_add(2), (1, true));

    //A shift of 17 bits os too large for 'u16', and 17 module 16 is 1
    assert_eq!(5_u16.overflowing_shl(17), (10, true));


    //The operation names that follow the checked_, wrapping_,
    //saturating_, or overflowing_ prefix are shown bellow
    //
    //
    //Multiplication  mul
    //Division  dib
    //Remainder  rem
    //Negation  neg
    //Absolute value  abs
    //Exponentiation  pow
    //Bitwise left shift  shl
    //Bitwise right shift  shr


    println!("Floating-Point Types");

    assert!((-1. / f32::INFINITY).is_sign_negative());
    assert_eq!(-f32::MIN, f32::MAX);

    assert_eq!(5f32.sqrt() * 5f32.sqrt(), 5.);
    assert_eq!((-1.01f64).floor(), -2.0);

    println!("{}", (2.0_f64).sqrt());
    println!("{}", f64::sqrt(2.0));

    println!("The bool type");

    assert_eq!(false as i32, 0);
    assert_eq!(true as i32, 1);

    println!("Characters");

    assert_eq!('*' as i32, 42);
    println!("{}", match std::char::from_digit(0xca0, 35) {
        Some(val) => val,
        None => '0',
    });
    assert_eq!('*'.is_alphabetic(), false);

    assert_eq!('8'.to_digit(10), Some(8));
    assert_eq!(std::char::from_digit(2, 10), Some('2'));

    println!("Tuples");

    let text = "I see the eigenvalue in thine eye";
    let (head, tail) = text.split_at(21);
    assert_eq!(head, "I see the eigenvalue ");
    assert_eq!(tail, "in thine eye");


    println!("Pointer Types");

    let mut d = Dog{name: String::from("Billy"), age: 3};
    set_age(&mut d); //&mut T example

    println!("{:?}", d);

    let t = (12, "eggs");
    let b = Box::new(t);

    print_tuple(b);

    println!("Arrays, Vectors and Slices");

    let lazy_catere: [u32; 6] = [1 ,2, 4, 7, 11, 16];
    let taxonomy = ["Animalia", "Arthropoda", "Insecta"];

    assert_eq!(lazy_catere[3], 7);
    assert_eq!(taxonomy.len(), 3);

    let mut sieve = [true; 10000];
    for i in 2..100 {
        if sieve[i] {
            let mut j = i * i;
            while j < 10000 {
                sieve[j] = false;
                j += i;
            }
        }
    }
    assert!(sieve[211]);
    assert!(!sieve[9876]);

    let mut chaos = [3, 5, 4, 1, 2];
    chaos.sort();
    assert_eq!(chaos, [1, 2, 3, 4, 5]);


    let mut primes = vec![2, 3, 5, 7];
    assert_eq!(primes.iter().product::<i32>(), 210);

    primes.push(11);
    primes.push(13);
    assert_eq!(primes.iter().product::<i32>(), 30030);

    let mut pal = Vec::new();

    pal.push("step");
    pal.push("on");
    pal.push("no");
    pal.push("pets");

    assert_eq!(pal, vec!["step", "on", "no", "pets"]);

    let mut palindrome = vec!["a man", "a plan", "a canal", "panama"];

    palindrome.reverse();

    assert_eq!(palindrome, vec!["panama", "a canal", "a plan", "a man"]);

    let mut v = Vec::with_capacity(2);

    assert_eq!(v.len(), 0);
    assert_eq!(v.capacity(), 2);

    v.push(1);
    v.push(2);

    assert_eq!(v.len(), 2);
    assert_eq!(v.capacity(), 2);

    v.push(3);
    assert_eq!(v.len(), 3);
    println!("capacity is now {}", v.capacity());

    let mut v = vec![10, 20, 30, 40, 50];

    v.insert(3, 35);
    assert_eq!(v, [10, 20, 30, 35, 40, 50]);

    v.remove(1);

    assert_eq!(v, [10, 30, 35, 40, 50]);

    let mut v = vec!["Snow Puff", "Glass Gem"];
    assert_eq!(v.pop(), Some("Glass Gem"));
    assert_eq!(v.pop(), Some("Snow Puff"));
    assert_eq!(v.pop(), None);

    //let languages: Vec<String> = std::env::args().skip(1).collect();
    let languages: Vec<String> = vec!["a", "Lisp", "C", "C++", "Fortran"].iter().map(|x| x.to_string()).skip(1).collect();

    for l in languages {
        println!("{}: {}", l, if l.len() % 2 == 0 {
            "functional"
        } else {
            "imperative"
        })
    }

    let v: Vec<f64> = vec![0.0, 0.707, 1.0, 0.707];
    let a: [f64; 4] = [0.0, 0.707, 1.0, 0.707];

    print(&v);
    print(&a);
    let sv: &[f64] = &v;
    let sa: &[f64] = &a;
    print(sv);
    print(sa);
    let v2 = v.clone();

    let handle = std::thread::spawn(move || {
        print(&v2);
    });

    handle.join().unwrap();

    print(&v[0..1]);
    
    println!("String types");

    println!(r###"
    This raw string started wiht 'r###'.
    Therefore it does not end until we reach a quote mark ('"')
    follwed immediately by three pound signs ('###'):
    "###);

    println!("Byte string");

    let method = b"GET";
    assert_eq!(method, &[b'G', b'E', b'T']);
    println!("{:?}", method);

    assert_eq!(format!("{}C{:02}`{:02}``N", 24, 5, 23), "24C05`23``N".to_string());

    let bits = vec!["veni", "vidi", "vici"];

    assert_eq!(bits.concat(), "venividivici");
    assert_eq!(bits.join(", "), "veni, vidi, vici");

    for word in "veni, vidi, vici".split(", ") {
        assert!(word.starts_with("v"));
    }

    println!("Type Aliases");

}

type Bytes = Vec<u8>;


fn decode(data: &Bytes) {
    for b in data {
        println!("{b}");
    }
}

fn print(n: &[f64]) {
    for el in n {
        println!("{}", el);
    }
}

fn new_pixel_buffer(rows: usize, cols: usize) -> Vec<u8> {
    vec![0; rows * cols]
}

fn set_age(d: &mut Dog) {
    d.age += 1
}

fn print_tuple(t: Box<(u32, &str)>) {
    println!("{} - {}", t.0, t.1)
}




