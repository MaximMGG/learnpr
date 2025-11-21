import std/random

type
    O = object
        i: int
    OP = ptr O

proc `=destroy`(o: var O) = 
    echo "destoying O"

proc test =
    for i in 0..5:
        if rand(9) > 1:
            var o: OP = create(O)
            o.i = rand(90)
            echo o.i * o.i

randomize()
test()
