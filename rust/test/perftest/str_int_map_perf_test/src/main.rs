

use std::collections::HashMap;



fn increase_key(key: &mut Vec<u8>) -> bool {

    let mut i: usize = key.len() - 1;
    loop {

        if key[3] == b'9' {
            break;
        }

        if key[i] == b'9' {
            key[i] = b'0';
            i -= 1;
        } else {
            key[i] += 1;
            return true;
        }
    }
    false
}



fn main() {

    let key_str = String::from("Key000000");
    let mut key = key_str.into_bytes();

    let mut map: HashMap<String, i32> = HashMap::new();
    let mut val: i32 = 0;

    println!("Start inserting into map");
    loop {
        if increase_key(&mut key) == false {
            break;
        }

        let k = key.iter().map(|&c| c as char).collect::<String>();

        map.insert(k, val);
        val += 1;
    }
    println!("Finish inserting");
    println!("Map len is: {}", map.len());
}
