from std/strutils import parseInt



echo "What's your name?"

let name: string = readLine(stdin)

echo "Hi, ", name, "!"



let sur_name = readLine(stdin)

if sur_name == "":
  echo "Do not have a sur name??"
elif sur_name == "Marly":
  echo "Ok, mr Marly!"
else:
  echo "Wow, ", sur_name, " interesting"


echo "What's your dog name?"

let dog_name = readLine(stdin)

case dog_name
of "":
  echo "No dog?"
of "Marly":
  echo "Your dog name it is your sur name?"
of "Dog":
  echo "Oh, your are so fany!"
else:
  echo "Good boy ", dog_name, "!"



echo "A number please: "
let n = parseInt(readLine(stdin))
case n
of 0..2, 4..7: echo "The number is in the set: {0, 1, 2, 4, 5, 6, 7}"
of 3, 8: echo "The number is 3 or 8"
else: discard


echo "Please tell your name agane"

var name2 = readLine(stdin)

while name2 == "":
  echo "Please, tell your name! Not empty line..."
  name2 = readLine(stdin)

echo "Finily, mr ", name2
