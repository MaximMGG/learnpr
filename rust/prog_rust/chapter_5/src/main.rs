
use std::collections::HashMap;

type Table = HashMap<String, Vec<String>>;

fn show(table: &Table) {
    for (artist, works) in table {
        println!("Works by {}:", artist);
        for work in works {
            println!("  {}", work);
        }
    }
}

fn sort_works(table: &mut Table) {
    for (_artist, works) in table {
        works.sort();
    }
}

fn increase(x: &mut Box<i32>) {
    (*x.as_mut()) += 1
    //*a += 1
}

struct Anime {
    name: &'static str,
    bechdel_pass: bool
}


struct Point{
    x: i32, y: i32
}

fn main() {

    let mut table = Table::new();
    table.insert("Gesualdo".to_string(), 
        vec!["many madrigalsl".to_string(), "Teneblrae Responsoria".to_string()]);
    table.insert("Caravaggio".to_string(), vec![
        "The Musivians".to_string(),
        "The Calling of St. Matthew".to_string()]);
    table.insert("Cellini".to_string(), 
        vec!["Perseus with the head of Medusa".to_string(),
        "a salt cellar".to_string()]);

    show(&table);
    sort_works(&mut table);
    show(&table);

    let mut a = Box::new(0 as i32);

    *a += 1;

    increase(&mut a);

    println!("{}", a);


    let x = 10;
    let r = &x;
    assert!(*r == 10);

    let mut y = 32;
    let m = &mut y;
    *m += 32;
    assert!(*m == 64);

    let aria = Anime{name: "Aria: The Animation", bechdel_pass: true};
    let anime_ref = &aria;

    assert_eq!(anime_ref.name, "Aria: The Animation");
    assert_eq!((*anime_ref).name, "Aria: The Animation");

    //the same
    let mut v = vec![1973, 1968];
    v.sort();
    (&mut v).sort();


    //dot (.) dereference as many & as need to find value
    let point = Point{x: 1000, y: 729};
    let r: &Point = &point;
    let rr: &&Point = &r;
    let rrr: &&&Point = &rr;
    assert_eq!(rrr.y, 729);
}
