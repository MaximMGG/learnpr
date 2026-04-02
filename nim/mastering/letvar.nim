import pixels

type Point = object
    x: int
    y: int


proc resetPointsToOrigin(points: var seq[Point]) =
    for i in 0..<points.len:
        points[i].x = 0
        points[i].y = 0


var points = @[Point(x: 123, y: 123)]
resetPointsToOrigin points
