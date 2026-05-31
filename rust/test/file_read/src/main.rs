
fn main() {

    let st = std::fs::read_to_string("src/test.html").unwrap();

    let new_str = st.replace("{s}", "Hello");
    println!("Final result is: {new_str}");

}
