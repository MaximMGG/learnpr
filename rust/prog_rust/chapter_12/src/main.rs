
//Unary operator
use std::ops::Neg; // -x
use std::ops::Not; // !x

//Arithmetic operators
use std::ops::Add; // x + y
use std::ops::Sub; // x - y
use std::ops::Mul; // x * y
use std::ops::Div; // x / y
use std::ops::Rem; // x % y

//Bitwise operators
use std::ops::BitAnd; // x & y
use std::ops::BitOr;  // x | y
use std::ops::BitXor; // x ^ y
use std::ops::Shl;    // x << y
use std::ops::Shr;    // x >> y

//Compound assignment arithmetic oprators
use std::ops::AddAssign; // x += y
use std::ops::SubAssign; // x -= y
use std::ops::MulAssign; // x *= y
use std::ops::DivAssign; // x /= y
use std::ops::RemAssign; // x %= y

//Compound assignment bitwise operators
use std::ops::BitAndAssign; // x &= y
use std::ops::BitOrAssign;  // x |= y
use std::ops::BitXorAssign; // x ^= y
use std::ops::ShlAssign;    // x <<= y
use std::ops::ShrAssign;    // x >>= y

//Comparison
use std::cmp::PartialEq;  // x == y, x != y
use std::cmp::PartialOrd; // x < y, x <= y, x > y, x >= y

//Indexing
use std::ops::Index; // x[y], &x[y]
use std::ops::IndexMut; // x[y] = z, &mut x[y]


fn main() {
    println!("Chapter 12, operator overloading");

    assert_eq!(4.125f32.add(5.75), 9.875);
    assert_eq!(10.add(20), 10 + 20);

    let c1 = Complex::<i32>{re: 12, im: 1};
    let c2 = Complex::<i32>{re: 99, im: 11};

    let c3 = c1 + c2;
    println!("{:?}", c3);
    let c4 = -c3;
    let mut c5 = Complex::<i32>{re: 9, im: 8};
    println!("{:?}", c4);
    c5 += c4;
    println!("{:?}", c5);
    let c6 = Complex::<i32>{re: 7, im: -2};
    println!("{:?} and {:?} the same -> {}", c5, c6, c5 == c6);
    let c7 = c5 * c6;
    println!("After mul c5 and c6: {:?}", c7);
}

trait MyAdd<Rhs = Self> {
    type Output;
    fn add(self, rhs: Rhs) -> Self::Output;
}

#[derive(Debug)]
struct Complex<T> {
    re: T,
    im: T
}

// impl Add for Complex<i32> {
//     type Output = Complex<i32>;
//     fn add(self, rhs: Self) -> Self {
//         Complex {
//             re: self.re + rhs.re,
//             im: self.im + rhs.im
//         }
//     }
// }

// impl<T> Add for Complex<T> 
// where 
//     T: Add<Output = T> {
//         type Output = Self;
//         fn add(self, rhs: Self) -> Self {
//             Complex {
//                 re: self.re + rhs.re,
//                 im: self.im + rhs.im
//             }
//         }
//     }

impl<L, R> Add<Complex<R>> for Complex<L>
where 
    L: Add<R> {
        type Output = Complex<L::Output>;
        fn add(self, rhs: Complex<R>) -> Self::Output {
            Complex {
                re: self.re + rhs.re,
                im: self.im + rhs.im
            }
        }
    }

impl<T> Neg for Complex<T>
where 
    T: Neg<Output = T> {
        type Output = Complex<T>;
        fn neg(self) -> Self::Output {
            Complex {
                re: -self.re,
                im: -self.im
            }
        }
    }

impl<T> AddAssign for Complex<T> 
where 
    T: AddAssign<T>
{
    fn add_assign(&mut self, rhs: Complex<T>) {
        self.re += rhs.re;
        self.im += rhs.im;
    }
}

impl<T: PartialEq> PartialEq for Complex<T> {
    fn eq(&self, other: &Complex<T>) -> bool {
        self.re == other.re && self.im == other.im
    }
}

impl<T> Mul for Complex<T> 
where 
    T: Mul<Output = T> {
        type Output = Complex<T>;
        fn mul(self, rhs: Complex<T>) -> Self::Output {
            Complex {
                re: self.re * rhs.re,
                im: self.im * rhs.im
            }
        }
    }

