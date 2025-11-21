from std/os import paramCount, paramStr


proc main =
    echo "Executing program", paramStr(0)
    let argc = paramCount() + 1
    if argc == 2:
        echo "The argument supplied is ", paramStr(1)
        if paramStr(1) in ["-d", "--debug"]:
            echo "Running id debug mode"
    elif argc > 2:
        echo "Too many arguments supplied."
    else:
        echo "One argument expected."

main()
