

block myBlock:
    echo "iner myBlock"
    var x = 0
    while true:
        echo x
        if x == 4:
            break myBlock

        x += 1

echo "Continue statement"

for x in 0..5:
    if x == 3: continue
    echo x

echo "When statement"

when system.hostOS == "window":
    echo "Winowd OS"
elif system.hostOS == "linux":
    echo "linux OS"
else:
    echo "Unknown OS"

const fac4 = (var x = 1; for i in 1..4: x *= i; x)
echo fac4

