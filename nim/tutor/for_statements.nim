echo "Counting to ten:"
for i in countup(1, 10):
  echo i

echo "Counting from ten:"
for i in countdown(10, 1):
  echo i

var i: int

while i <= 10:
  echo i
  i += 1
  inc i



echo "for i in 0 ..< 10"
for i in 0..<10:
  echo i


let s = "some string"

for i in 0 ..< s.len:
  echo s[i]

for idx, c in s[0 .. ^1]:
  echo idx, "-", c


for idx, i in ["a", "b"].pairs:
  echo i, " at index ", idx



echo "Blocks"

block myblock:
  echo "entering block"
  while true:
    echo "looping"
    break
  echo "still in block, but not in loop"
echo "outside of block"

block myblock2:
  echo "entering next block"
  while true:
    echo "looping in next block"
    break myblock2
  echo "still in block2 but not in loop"
echo "outside blocks"


for i in 0 ..< 10:
  if i == 3: continue
  echo "I is: ", i


when system.hostOs == "windos":
  echo "running on Windows"
elif system.hostOs == "linux":
  echo "running on linux"
elif system.hostOs == "macosx":
  echo "running on macosx"
else:
  echo "Unknown operating system"


const fac4 = (var x = 1; for i in 1..4: x *= i; x)

echo "Fac 4 is ", fac4



