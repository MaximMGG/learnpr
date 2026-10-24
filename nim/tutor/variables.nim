
# it's known in comptime can't be changed
const PI = 3.14f32


# it's set in runtime, but can't be changed
let name: string = "Bob"


# it's set in runtime, but could be change
var s: string = "Silly"

s = s & " is strong"

echo PI
echo name
echo s
