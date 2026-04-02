import pixels

type Point = object
        x: int
        y: int

type Direction = enum
    Horizontal
    Vertical


proc drawHorizontalLine(start: Point; length: Positive) =
    for delta in 0..length:
        putPixel(start.x + delta, start.y)

proc drawVerticalLine(start: Point, length: Positive) =
    for delta in 0..length:
        putPixel(start.x, start.y + delta)

proc drawLine(start: Point; length: Positive; direction: Direction) = 
    case direction
    of Horizontal:
        drawHorizontalLine(start, length)
    of Vertical:
        drawVerticalLine(start, length)

var p = Point(x: 60, y: 40)

drawLine(p, 60, Horizontal)
drawLine(p, 40, Vertical)
