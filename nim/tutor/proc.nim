

proc yes(question: string): bool =
    echo question, " (y/n)"
    while true:
        case readLine(stdin)
        of "y", "Y", "yes", "Yes": return true
        of "n", "N", "no", "No": return false
        else: echo "Please be clear yes or no"

if yes("Should I delete all files"):
    echo "I can't do in"
else:
    echo "You gat dam right"


echo "Result value"

proc sumTillNegative(x: varargs[int]): int =
    for i in x:
        if i < 0: return
        result += i

echo sumTillNegative()
echo sumTillNegative(99, 12, 319)
echo sumTillNegative(1, 3, -1)

echo "return last expression"

proc retLastInt(): int =
    var x = 0
    var y = 0
    x += 123
    y += 81283
    x += y
    x

echo retLastInt()

proc printSeq(s: string, nprinted: int = -1) =
    var nprinted = if nprinted == -1: s.len else: min(nprinted, s.len)
    for i in 0..<nprinted:
        echo s[i]


proc divmod(a, b: int, res, remainder: var int) = 
    res = a div b
    remainder = a mod b

var
    x, y: int

divmod(8, 5, x, y)
echo x
echo y

echo "Discarded"

proc p(x, y: int): int {.discardable.} =
    return x + y

echo p(123, 1)
p(123, 1)


echo "Overloading procedures"


proc toString(x: int): string =
    result = 
        if x < 0: "negative"
        elif x > 0: "positve"
        else: "zero"

proc toString(x: bool): string =
    result = 
        if x: "true"
        else: "false"

assert toString(123) == "positve"
assert toString(false) == "false"


