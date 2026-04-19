

fn increase_key(key: &mut String) -> Option<String> {
    let key = key.as_str();

    let mut part: Vec<char> = key.chars().collect();
    let mut i: usize = part.len() - 1;

    loop {
        if part[3] == '9' {
            break;
        }
        if part[i] == '9' {
            part[i] = '0';
            i -= 1;
        } else {
            part[i] = ((part[i] as u8) + 1) as char;
            return Some(part.into_iter().collect::<String>())
        }
    }

    None
    
}

fn increase_key2(key: &mut [u8]) -> bool {
    let mut i: usize = key.len() - 1;

    loop {
        if key[3] == '9' as u8 {
            break;
        }

        if key[i] == '9' as u8 {
            key[i] = '0' as u8;
            i -= 1;
        } else {
            key[i] = key[i] + 1;
            return true;
        }
    }

    false
}


fn increase_key3(key: &mut Vec<u8>) -> bool {
    let mut i: usize = key.len() - 1;

    loop {
        if key[3] == b'9' {
            break;
        }
        if key[i] == b'9' {
            key[i] = b'0';
            i -= 1;
        } else {
            key[i] = key[i] + 1;
            return true;
        }
    }

    false
}


fn main() {
    let key = String::from("Key000000");

    //let mut key_vec = key.into_bytes();
    let mut key_vec: Vec<u8> = Vec::from(key);
    loop {
        if increase_key3(&mut key_vec) == false {
            break;
        }
    }

    let s: String = key_vec.iter().map(|&x| x as char ).collect();
    println!("Key -> {s}");


    // unsafe {
    //     let mut key_u8 = key.as_mut_str().as_bytes_mut();
    //     loop {
    //         if increase_key2(&mut key_u8) == false {
    //             break;
    //         }
    //         println!("Key -> ");
    //     }
    //
    //     let res = key_u8.iter().map(|c| *c as char).collect::<String>();
    //
    //     println!("{}", res);
    //
    // }


    // loop {
    //     key = increase_key(&mut key).unwrap();
    //
    //     println!("Key -> {key}");
    // }

}
