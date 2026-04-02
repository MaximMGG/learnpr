import pixels

proc startup() =
    echo "start"

startup()

drawText 30, 40, "Welcome to Nim!", 10, Yellow

echo $1234 & " HEllo"

for i in 1..3:
    let texttodraw = "Welcome to nim for the " & $i & "th time!"
    drawText(10, i * 10, texttodraw, 12, pixels.Gold)


