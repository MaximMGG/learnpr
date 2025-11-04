package cube

import "core:fmt"
import "core:log"
import "core:c"
import gl "vendor:OpenGL"
import glfw "vendor:glfw"
import stb "vendor:stb/image"
import "util"

WIDTH :: 1280
HEIGHT :: 720


keyCallBack :: proc "c" (window: glfw.WindowHandle, key: c.int, scancode: c.int, action: c.int, mods: c.int) {
    if key == glfw.KEY_ESCAPE && action == glfw.PRESS {
        glfw.SetWindowShouldClose(window, true)
    }
}

main :: proc() {
    glfw.Init()
    defer glfw.Terminate()
    log.log(.Info, "Init glfw")

    window := glfw.CreateWindow(WIDTH, HEIGHT, "CUBE", nil, nil)
    defer glfw.DestroyWindow(window)
    log.log(.Info, "Create window")

    glfw.MakeContextCurrent(window)
    glfw.SetKeyCallback(window, keyCallBack)

    gl.load_up_to(4, 5, proc(p: rawptr, name: cstring){
        (^rawptr)(p)^ = glfw.GetProcAddress(name)
    })

    shader := util.compileShader("./vertex.glsl", "./fragment.glsl")
    defer gl.DeleteProgram(shader.id)
    log.log(.Info, "Compile Shaders")



    log.log(.Info, "Start main loop")

    for !bool(glfw.WindowShouldClose(window)) {
        gl.Clear(gl.COLOR_BUFFER_BIT)


        glfw.SwapBuffers(window)
        glfw.PollEvents()
    }
}
