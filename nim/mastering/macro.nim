import std/macros
import pixels


macro disable(body: untyped): untyped =
    result = newStmtList()

disable:
    drawText(10, 10, "Disable piece of code!", Blue)


var s = "Hello";
var i = s.contains('e')
if i:
    echo "Yes"



let s2 = """"
asd
    'aiosdjf'
"" a''
""""

echo s2
