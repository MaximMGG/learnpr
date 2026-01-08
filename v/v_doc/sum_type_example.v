


struct Point {
  x int
  y int
}

struct Line {
  p1 Point
  p2 Point
}

type ObjectSumType = Point | Line


fn main() {
  mut object_list := []ObjectSumType{}
  object_list << Point{1, 1}
  object_list << Line{
    p1: Point{3, 3}
    p2: Point{2, 2}
  }

  dump(object_list)

}
