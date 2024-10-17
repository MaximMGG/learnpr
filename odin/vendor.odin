package vendor_odin

import "base:runtime"
import "core:fmt"
import "vendor:glfw"

error_callback :: proc "c" (code: i32, desc: cstring) {
    context = runtime.default_context()
    fmt.println(desc, code)
}

key_callback :: proc "c" (window: glfw.WindowHandle, key, scancode, action, mods: i32) {
    if key == glfw.KEY_ESCAPE && action == glfw.PRESS {
        glfw.SetWindowShouldClose(window, glfw.TRUE)
    }
}

main :: proc() {
    glfw.SetErrorCallback(error_callback)

    if !glfw.Init() {
        panic("EXIT_FAILURE")
    }

    defer glfw.Terminate()

    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 2)
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 0)

    window := glfw.CreateWindow(640, 480, "Simple example", nil, nil)
    if window == nil {
        panic("EXIT_FAILURE")
    }
    defer glfw.DestroyWindow(window)
    glfw.SetKeyCallback(window, key_callback)

    glfw.MakeContextCurrent(window)
    glfw.SwapInterval(1)

    for !glfw.WindowShouldClose(window) {

        glfw.SwapBuffers(window)
        glfw.PollEvents()
    }
}
