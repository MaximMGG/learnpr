
use num::Complex;
use std::str::FromStr;
use image::ColorType;
use image::codecs::png::PngEncoder;
use std::fs::File;

fn complex_square_add_loop(c: Complex<f64>) {
    let mut z = Complex{re: 0.0, im: 0.0};
    loop {
        z = z * z + c;
    }
}

fn square_add_loop(c: f64) {
    let mut x = 0.;
    loop {
        x = x * x + c;
    }
}


fn escape_time(c: Complex<f64>, limit: usize) -> Option<usize> {
    let mut z = Complex{re: 0.0, im: 0.0};
    for i in 0..limit {
        if z.norm_sqr() > 4.0 {
            return Some(i);
        }
        z = z * z + c;
    }
    None
}


fn main() {
    println!("Hello, world!");
}

fn parse_pair<T: FromStr>(s: &str, separator: char) -> Option<(T, T)> {
    match s.find(separator) {
        None => None,
        Some(index) => {
            match (T::from_str(&s[..index]), T::from_str(&s[index + 1..])) {
                (Ok(l), Ok(r)) => Some((l, r)),
                _ => None
            }
        }
    }
}

fn parse_complex(s: &str) -> Option<Complex<f64>> {
    match parse_pair(s, ',') {
        Some((r, i)) => Some(Complex{re: r, im: i}),
        None => None
    }
}

fn pixel_to_point(bounds: (usize, usize), pixel: (usize, usize),
                    upper_left: Complex<f64>,
                    lower_right: Complex<f64>) -> Complex<f64> {
    let (width, height) = (lower_right.re - upper_left.re, upper_left.im - lower_right.im);
    Complex{re: upper_left.re + pixel.0 as f64 * width / bounds.0 as f64,
    im: upper_left.im - pixel.1 as f64 * height / bounds.1 as f64}
}

fn render(pixels: &mut [u8], bounds: (usize, usize), 
    upper_left: Complex<f64>, lower_right: Complex<f64>) {
    assert!(pixels.len() == bounds.0 * bounds.1);
    for row in 0..bounds.1 {
        for column in 0..bounds.0 {
            let point = pixel_to_point(bounds, (column, row), upper_left, lower_right);

            pixels[row * bounds.0 + column] = match escape_time(point, 255) {
                None => 0,
                Some(count) => 255 - count as u8
            };
        }
    }
}


fn write_image(filename: &str, pixels: &[u8], bounds: (usize, usize)) -> Result<(), std::io::Error> {
    let output = File::create(filename)?;
    let encoder = PngEncoder::new(output);
    encoder.write_image(pixels, bounds.0 as u32, bounds.1 as u32, ColorType::Rgb8);
}




#[test]
fn test_pixel_point() {
    assert_eq!(pixel_to_point((100, 200), (25, 175), 
            Complex{re: -1.0, im: 1.0}, Complex{re: 1.0, im: -1.0}), Complex{re: -0.5, im: -0.75});
}

#[test]
fn test_parse_comlex() {
    assert_eq!(parse_complex("1.25,-0.0625"), Some(Complex{re: 1.25, im: -0.0625}));
    assert_eq!(parse_complex(",-0.0625"), None);
}

#[test]
fn test_parse_pair() {
    assert_eq!(parse_pair::<i32>("",        ','), None);
    assert_eq!(parse_pair::<i32>("10",      ','), None);
    assert_eq!(parse_pair::<i32>(",10",     ','), None);
    assert_eq!(parse_pair::<i32>("10,20",   ','), Some((10, 20)));
    assert_eq!(parse_pair::<i32>("10,20xy", ','), None);
    assert_eq!(parse_pair::<i32>("0.5x",    ','), None);
    assert_eq!(parse_pair::<f64>("0.5x",    'x'), None);
    assert_eq!(parse_pair::<f64>("0.5x1.5", 'x'), Some((0.5, 1.5)));
}


#[test]
fn test_escape_time() {
    let t = Complex{re: 8.1, im: 1.1};
    let res = match escape_time(t, 81) {
        Some(t) => t,
        None => 0
    };
    println!("Res is {res}");

    assert!(res != 0);
}
