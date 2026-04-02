
# proc printThings(things: varargs[string]) =
#   for thing in things:
#     echo thing

proc printThings(things: varargs[string, `$`]) =
  for thing in things:
    echo thing

    
printThings "words", "to", "print"

printThings 1, "string", @[1, 2, 3]

