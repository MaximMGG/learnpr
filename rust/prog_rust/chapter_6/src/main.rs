fn main() -> std::io::Result<()>{
    let range = std::ops::Range{start: 0, end: 20};

    for i in range {
        println!("{i}");
    }

    let mut lines = vec!["iei".to_string(), "aaa".to_string()];

    for s in &mut lines {
        s.push('\n');
        println!("String {:?} is at address {:p}", *s, s);
    }

    println!("Len is {}", lines.len());

    let answer = loop {
        if let Some(line) = next_line() {
            if line.starts_with("answer: ") {
                break line;
            }
        } else {
            break "answer: nothing".to_string();
        }
    };
    println!("Answer {answer}");


    'search:
    for r in 0..5 {
        if r == 3 {
            break 'search;
        }
    }

    let f = create_file()?;
    println!("{:?}", f.metadata());
    return Ok(())
}


fn create_file() -> Result<std::fs::File, std::io::Error> {
    std::fs::File::create("test.txt")
}

fn next_line() -> Option<String> {
    Some("answer: hello".to_string())
}
