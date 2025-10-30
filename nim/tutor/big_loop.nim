
const SIZE = 10000000

proc process(size: uint): int64 =
    for i in 0..size:
        result += 1
    

echo process(SIZE)
