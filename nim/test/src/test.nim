# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import std/strutils


proc getBigString(): string =
    for i in 0..<100000:
        result.add("ijij")


proc getAlphabet(): string =
    for letter in 'a'..'z':
        result.add(letter)



proc main() =
    var s = "Hello world"
    s = s.replace("l", "")
    echo s
    echo getAlphabet()

    var bigs = getBigString()
    var t = s & bigs & s
    echo t


main()
