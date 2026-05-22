
use to_lib::{Fern, run_simulation};

fn main() {
    let mut f = Fern{size: 1.0, growth_rate: 0.001};
    run_simulation(&mut f, 1000);
    println!("Final fern size: {}", f.size);
}
