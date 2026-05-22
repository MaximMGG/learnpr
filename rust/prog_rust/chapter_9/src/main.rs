

#[derive(Debug)]
struct Grayscale {
    pixels: Vec<u8>,
    size: (usize, usize),
}

fn new_map(size: (usize, usize), pixels: Vec<u8>) -> Grayscale {
    assert_eq!(size.0 * size.1, pixels.len());
    Grayscale{pixels, size}
}

struct Broom {
    name: String,
    height: u32,
    health: u32,
    position: (f32, f32, f32),
    intent: BroomIntent
}

#[derive(Clone, Copy)]
enum BroomIntent {
    FetchWater, DumpWater
}

fn chop(b: Broom) -> (Broom, Broom) {
    let mut broom1 = Broom{height: b.height / 2, .. b};

    let mut broom2 = Broom{name: broom1.name.clone(), .. broom1};
    broom1.name.push_str(" I");
    broom2.name.push_str(" II");

    (broom1, broom2)
}


fn main() {

    let width = 1024 as usize;
    let height = 720 as usize;
    let pixels: Vec<u8> = vec![0; width * height];
    let _map = new_map((width, height), pixels);

    //println!("{:?}", map);

    let hokey = Broom {
        name: "Hokey".to_string(),
        height: 60,
        health: 100,
        position: (100.0, 200.0, 0.0),
        intent: BroomIntent::FetchWater,
    };

    let (hokey1, hokey2) = chop(hokey);

    assert_eq!(hokey1.name, "Hokey I");
    assert_eq!(hokey1.height, 30);
    assert_eq!(hokey1.health, 100);

    assert_eq!(hokey2.name, "Hokey II");
    assert_eq!(hokey2.height, 30);
    assert_eq!(hokey2.health, 100);
}


