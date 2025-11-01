import pixels

const
    WIDTH = 1024
    HEIGHT = 720

template bounsCheck(a, b: int) =
    if  a < 0 or a >= WIDTH or
        b < 0 or b >= HEIGHT:
        return

proc safePutPixel(x, y: int, col: Color) =
    bounsCheck(x, y)
    echo "call putPixel"
    putPixel(x, y, col);

safePutPixel(123, 3, pixels.Yellow)
safePutPixel(1233, 3, pixels.Yellow)



template wrap(body: untyped) =
    drawText(0, 0, "Before Body", 12, Yellow)
    body


wrap:
    for i in 1..3:
        let textToDraw = "Welcome to Nim for the " & $i & "th time!"
        drawText(10, i * 14, textToDraw, 12, Gold)


template putPixel(x, y: int) = putPixel(x, y, colorContext)
template drawText(x, y: int, s: string) = drawText(x, y, s, colorContext)


template withColor(col: Color; body: untyped) =
    let colorContext {.inject.} = col
    body

withColor Blue:
    putPixel(3, 4)
    drawText(10, 10, "abc", 12)
