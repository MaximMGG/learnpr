import terminal as term

const Max = 100

let i: int = 1
var sum: int
while sum < Max:
    inc sum, i

echo sum

stdout.write("May you tell me your name: ")
var name = stdin.readLine()
if name != "no":
    echo "Nice to meat you ", name
echo "Press any key to continue"
let c = term.getch()
echo "OK, let us coninue, you pressed key: ", c



