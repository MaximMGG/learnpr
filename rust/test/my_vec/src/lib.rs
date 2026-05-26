

use std::alloc;
use std::ptr::NonNull;

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
            let layout = alloc::Layout::array::<T>(self.capacity << 1).expect("Could create layout");
            let ptr = unsafe {alloc::alloc(layout)} as *mut T;
            let ptr = NonNull::new(ptr).expect("Could alloca some memory");
            unsafe {ptr.as_ptr().swap(self.ptr.as_ptr());}
            self.ptr = ptr;
            unsafe {self.ptr.as_ptr().wrapping_add(self.len).write(val)}
            self.capacity <<= 1;
            self.len += 1;
        } else {
            unsafe {self.ptr.as_ptr().wrapping_add(self.len).write(val)}
            self.len += 1;
        }    
    }
}

use std::ops::Index;


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_runs() {

        let a: Vec<usize> = vec![1];
        let _b = a.index(3);

        let mut s = MyVec::<i32>::new();
        s.push(3);
        s.push(2);
        s.push(3);
        s.push(4);
        s.push(5);

        assert_eq!(s.len(), 5);
        assert_eq!(s.capacity(), 8);

    }
}
