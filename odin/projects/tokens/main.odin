package main

import "core:fmt"
import "core:os"
import "core:encoding/json"
import "core:c"
import w "window"

main :: proc() {
    w.windowInit()
    defer w.windowDestroy()

    ch: c.int
    for ch != 'q' {
	w.windowDraw()
    }
}

