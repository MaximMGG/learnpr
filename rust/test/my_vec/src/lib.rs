

use std::alloc;
use std::ptr::NonNull;
use std::ops::Drop;

pub struct MyVec<T> {
    ptr: NonNull<T>,
    len: usize,
    capacity: usize
}

impl <T> MyVec<T> {
    pub fn new() -> Self {
        Self {
            ptr: std::ptr::NonNull::<T>::dangling(),
            len: 0,
            capacity: 0
        }
    }

    pub fn capacity(&self) -> usize {
        self.capacity
    }
    pub fn len(&self) -> usize {
        self.len
    }

    pub fn push(&mut self, val: T) {
        assert_ne!(std::mem::size_of::<T>(), 0, "No zero sized types");
        if self.capacity == 0 {
            let layout = alloc::Layout::array::<T>(4).expect("Could be ok");
            let ptr = unsafe { alloc::alloc(layout)} as *mut T;
            let ptr = NonNull::new(ptr).expect("Could not allocate memory");
            unsafe {
                ptr.as_ptr().write(val);
                // *ptr.as_ptr() = val;
            }
            self.ptr = ptr;
            self.capacity = 4;
            self.len = 1;
        } else if self.len == self.capacity {
            let layout = alloc::Layout::from_size_align(self.capacity << 1, std::mem::align_of::<T>()).expect("layout ok");
            let p = unsafe {alloc::realloc(self.ptr.as_ptr() as *mut u8, layout, self.capacity << 1) as *mut T};
            self.ptr = NonNull::new(p).expect("Could realloc memory");
            unsafe {self.ptr.as_ptr().add(self.len()).write(val)};
            self.len += 1;
            self.capacity <<= 1;
        } else {
            let offset = self.len.checked_mul(std::mem::size_of::<T>()).expect("Cannot reach memory location");
            assert!(offset < isize::MAX as usize, "Wrapped isize");
            unsafe {self.ptr.as_ptr().add(self.len()).write(val)};
            self.len += 1;
        }    
    }
    pub fn get(&self, index: usize) -> Option<&T> {
        if index >= self.len {
            return None
        }
        Some (unsafe {
            &(*self.ptr.as_ptr().add(index))
        })
    }
}

impl<T> Drop for MyVec<T> {
    fn drop(&mut self) {
        unsafe {
            std::ptr::drop_in_place(std::slice::from_raw_parts_mut(self.ptr.as_ptr(), self.capacity()));
            let layout = alloc::Layout::array::<T>(self.capacity).expect("Layout error");
            alloc::dealloc(self.ptr.as_ptr() as *mut u8, layout);
        }
    }
}





#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_runs() {

        //let a: Vec<usize> = vec![1];
        //let _b = a.index(3);

        let mut s = MyVec::<i32>::new();
        s.push(3);
        s.push(2);
        s.push(3);
        s.push(4);
        s.push(5);


        for i in 0..s.len() {
            println!("Val if index: {i} -> {}", match s.get(i) {
                Some(t) => *t,
                None => 0
            });
        }


        assert_eq!(s.len(), 5);
        assert_eq!(s.capacity(), 8);

    }
}
