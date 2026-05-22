
pub mod plant_structure;


fn main() {
    println!("Hello, world!");
    println!("Sum from lib: {}", 3);
    println!("Test msg");
    let s = plant_structure::stems::xylem::hello_from_xylem();
    println!("Message: {}", s);
}
