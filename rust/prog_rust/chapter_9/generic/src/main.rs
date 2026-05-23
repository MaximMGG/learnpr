

pub struct Queue<T> {
    older: Vec<T>,
    younger: Vec<T>
}

impl<T> Queue<T> {

    pub fn new() -> Self {
        Queue{older: Vec::new(), younger: Vec::new()}
    }

    pub fn push(&mut self, data: T) {
        self.younger.push(data);
    }

    pub fn pop(&mut self) -> Option<T> {
        if self.older.is_empty() {
            if self.younger.is_empty() {
                return None;
            }
            std::mem::swap(&mut self.older, &mut self.younger);
            self.older.reverse();
        }
        self.older.pop()
    }

    pub fn is_empty(&self) -> bool {
        self.older.is_empty() && self.younger.is_empty()
    }
}


struct Extrema<'elt> {
    greatest: &'elt i32,
    least: &'elt i32,
}

fn find_extrema<'s>(slice: &'s [i32]) -> Extrema<'s> {
    let mut greatest = &slice[0];
    let mut least = &slice[0];

    for i in 1..slice.len() {
        if slice[i] < *least {
            least = &slice[i];
        }
        if slice[i] > *greatest {
            greatest = &slice[i];
        }
    }
    Extrema{greatest, least}
}


fn main() {

    let mut q = Queue::new();
    //let mut q = Queue::<u32>::new(); is the same as previous
    q.push(21 as u32);
    q.push(11 as u32);
    while !q.is_empty() {
        println!("Val is: {}", q.pop().unwrap());
    }

    q.push(1 as u32);
    q.push(2 as u32);

    while !q.is_empty() {
        println!("Val is: {}", q.pop().unwrap());
    }


    let a = [0, -3, 0, 15, 48];
    let e = find_extrema(&a);
    assert_eq!(*e.least, -3);
    assert_eq!(*e.greatest, 48);



}
