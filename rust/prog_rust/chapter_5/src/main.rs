
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

fn lifetime() {
    let r;
    {
        let x = 1;
        r = &x;
        assert_eq!(*r, 1);
    }
    let v = vec![1, 2, 3];
    let a = &v[0];
    assert_eq!(*a, 1);
}

fn call_smallest() {
    let res;
    {
        let arr = [3, 8, 9, 0, 1, 2, -3];
        res = smallest(&arr);
        assert_eq!(*res, -3);
    }
    // assert_eq!(*res, -3); bad code, arr doesnt alive here
}

fn smallest<'a>(arr: &'a[i32]) -> &'a i32 {
    let mut b = &arr[0];
    for r in &arr[0..] {
        if *r < *b {
            b = r;
        }
    }
    b
}

struct S {
    r: &'static i32, // it is mians the 'r' should live all till the end of programm
}

struct B<'a> {
    r: &'a i32, //it has the same lifetime as 'r'
}


struct StringTable { 
    elements: Vec<String>,
}

impl StringTable {
    fn find_by_prefix(&self, prefix: &str) -> Option<&String> {
        for i in &self.elements {
            if i.starts_with(prefix) {
                return Some(i);
            }
        }
        None
    }
}
