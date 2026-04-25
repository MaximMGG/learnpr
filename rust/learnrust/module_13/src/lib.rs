


#[derive(PartialEq, Debug)]
struct Shoe {
    size: u32,
    style: String,
}

fn shoes_in_size(shoes: Vec<Shoe>, shoe_size: u32) -> Vec<Shoe> {
    shoes.into_iter().filter(|x| x.size == shoe_size).collect()
}



fn lazy_iter() {
    let v1 = vec![1, 2, 3];

    let v1_iter = v1.iter();

    for i in v1_iter {
        println!("{i}");
    }

}

fn filter_iterator() {
    let v1 = vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    let v2: Vec<i32> = v1.into_iter().filter(|&x| (x % 2) == 0).collect();

    for i in &v2 {
        println!("{i}");
    }
}

fn map_iterator() {
    let v1 = vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    
    let v2: Vec<i32>  = v1.iter().map(|x| if x % 2 == 0 {x * 2} else {x + 1}).collect();

    for i in 0..=v1.len() - 1 {
        println!("V1 val: {}\nV2 val: {}", v1[i], v2[i]);
    }
}

fn sum_iterator() {
    let v1 = vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    let total: i32 = v1.iter().sum();
    println!("Total sum of v1: {total}");
}



pub fn iter_examples() {
    println!("Iterators\n");
    lazy_iter();
    filter_iterator();
    map_iterator();
    sum_iterator();
}




#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn iterator_demonstration() {
        let v1 = vec![1, 2, 3];

        let mut v1_iter = v1.iter();

        assert_eq!(v1_iter.next(), Some(&1));
        assert_eq!(v1_iter.next(), Some(&2));
        assert_eq!(v1_iter.next(), Some(&3));
        assert_eq!(v1_iter.next(), None);
    }


    #[test]
    fn filters_by_size() {
        let shoe = vec![
            Shoe{size: 10, style: String::from("sneaker")},
            Shoe{size: 13, style: String::from("sandal")},
            Shoe{size: 10, style: String::from("boot")},
        ];

        let in_my_size = shoes_in_size(shoe, 10);

        assert_eq!(in_my_size, vec![
            Shoe{size: 10, style: String::from("sneaker")},
            Shoe{size: 10, style: String::from("boot")},
        ]);
    }
}
