

enum Shape {
  Circle {
    r: f64
  },
  Rect {
    w: f64, h: f64
  },
  Dot
}

fn main() {
  var shapes: Shape[>..] = [];
  shapes.push(Shape.Circle{1.0});
  shapes.push(Shape.Rect{2.0, 3.0});
  shapes.push(Shape.Dot);
  shapes[2] = Shape.Rect{1.0, 1.0};

  var packed: Shape..[>..] = [];
  packed.push(Shape.Circle{3.0});
  packed.push(Shape.Rect{1.0, 2.0});
  packed.push(Shape.Dot);

  for o in packed {
    match o {
      Rect &r => {
        r.w += 1.0;
      },
      _ => {}
    }
  }

  print(packed);

  for o in packed {
    print(o, " area ", area(o))
  }
}

fn name(s: Shape) -> u8[:] {
  match s {
    Rect r => 
      if r.w == r.h {"square"} else {
        "rectengle"
      },
    Circle c => {
      "circle"
    },
    _ => "other"
  }
}


let GROUND = 0;
let SHALLOW = 1;
let DEEP = 4;
let LAVA = 7;

fn terrain(t: i64) -> u8[:] {
  match t {
    GROUND => "ground",
    SHALLOW..DEEP => "water",
    LAVA, 10..12 => "hot",
    _ => "rock",
  }
}

fn area(s: Shape.Circle) -> f64 {3.14159 * s.r * s.r}
fn area(s: Shape.Rect) -> f64 {s.w * s.h}
fn area(s: Shape.Dot) -> f64 {0.0}


