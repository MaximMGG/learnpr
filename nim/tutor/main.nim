from std/strutils import parseInt

echo "A number please:"
#let n = parseInt(readline(stdin))
# case n
# of 0..2, 4..7: echo "The number is in the set: {0, 1, 2, 4, 5, 6, 7}"
# of 3, 8: echo "The number is 3 or "
# else: discard


let x = "wijij"

echo x.len

echo "Counting to ten"

for i in countup(1, 10):
    echo i

echo "Counting 0 .. 10"
for i in 0 .. 10:
    echo i

echo "Counting 0 ..<10"
for i in 0..<10:
    echo i

echo "iterating though string[0..^1]"

let s = "Hello world!"

for i, c in s[0..^1]:
    echo i, "- ", i

echo "Iterating through items"
for item in ["a", "b"].items:
    echo item

echo "Iterating through pairs"
for index, item in ["a", "b"].pairs:
    echo index, " - ", item
