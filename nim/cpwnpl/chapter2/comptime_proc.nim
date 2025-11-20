

func genSep(l: int): string =
    debugecho "Generating separator string"
    for i in 1 .. l:
        result.add('=')

const Sep = genSep(80)

echo Sep


converter myIntToBool(i: int): bool =
    i != 0

var i: int = 1
if i:
    echo "true"
else:
    echo "false"
