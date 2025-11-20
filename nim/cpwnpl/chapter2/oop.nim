

type
    Shape = ref object of RootObj

    Rectangle = ref object of Shape
        x, y, width, height: float

    Circle = ref object of Shape
        x, y, radius: float

    LineSegment = ref object of Shape
        x1, y1, x2, y2: float

method draw(s: Shape) {.base.} =
    echo "This is shape"
    # quit "to override"

method draw(s: Rectangle) = 
    echo "drawing a rectangle"

method draw(s: Circle) = 
    echo "drawing a circle"

method draw(r: LineSegment) = 
    echo "drawing a line segment"

proc main() = 
    var l: seq[Shape]
    l.add(Rectangle(x: 0, y: 0, width: 100, height: 50))
    l.add(Circle(x: 60, y: 20, radius: 50))
    l.add(LineSegment(x1: 20, y1: 20, x2: 20, y2: 50))

    for el in l:
        draw(el)

main()
