

type
    Direction = enum
        East, West, South, North

proc print(d: Direction) =
    case d
    of East: echo "East"
    of West: echo "West"
    of South: echo "South"
    of North: echo "North"
    

var d: Direction
d = West

d.print()


var x = 123'i32
echo typeof(x)

var y: uint32 = 8
var f: float32 = 1.0

echo typeof(y)
echo typeof(f)

var c: char = 'u'
echo c
echo c.ord()
echo chr(117)
