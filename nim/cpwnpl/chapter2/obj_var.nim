
type
    ShapeKind = enum
        line, rect, circ

    Shape = object
        visible: bool
        case kind: ShapeKind
        of line:
            x1, y1, x2, y2: float
        of rect:
            x, y, width, height: float
        of circ:
            x0, y0, radius: float

proc draw(el: Shape) = 
    if el.kind == line:
        echo "process line segment"
    elif el.kind == rect:
        echo "process rectangle"
    elif el.kind == circ:
        echo "process circle"
    else:
        echo "unknown shape"

var
    s: seq[Shape]

s.add(Shape(kind: circ, x0: 0, y0: 0, radius: 100, visible: true))
s.add(Shape(kind: line, x1: 1, y1: 1, x2: 2, y2: 2, visible: false))

for el in s:
    draw(el)
