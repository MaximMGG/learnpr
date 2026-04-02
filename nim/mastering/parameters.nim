import pixels

type Point = object
    x: int
    y: int

proc resetPointsToOrigin(points: var seq[Point]) =
    for i in 0..<points.len:
        points[i] = Point(x: 0, y: 0)



var points = @[Point(x: 1, y: 3), Point(x: 4, y: 5)]

resetPointsToOrigin points

echo points

