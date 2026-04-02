package test

import "core:fmt"
import "core:c"
import "core:os"
import "core:io"
import "core:strings"

import gl "vendor:OpenGL"
import glfw "vendor:glfw"


initWindow :: proc(width: i32, height: i32, name: cstring) -> glfw.WindowHandle {
    glfw.Init()
    window := glfw.CreateWindow(width, height, name, nil, nil)
    if window == nil {
        fmt.eprintln("Failed to create glfw window")
    }

    glfw.MakeContextCurrent(window)

    gl.load_up_to(3, 3, proc(p: rawptr, proc_name: cstring) {
        (^rawptr)(p)^ = glfw.GetProcAddress(proc_name)
    })

    return window
}


loadShader :: proc(path: string, type: u32) -> (shader: u32) {
    file, file_err := os.open(path, os.O_RDONLY)
    defer os.close(file)
    if file_err != nil {
        fmt.eprintln("Failed to open:", path, "file")
        shader = 0
        return
    }
    file_size, _ := os.file_size(file)
    buf := make([]u8, file_size)
    defer delete(buf)
    os.read(file, buf)
    shader = gl.CreateShader(type)
    source := []cstring{strings.clone_to_cstring(string(buf))}
    gl.ShaderSource(shader, 1, &source[0], nil)
    gl.CompileShader(shader)
    res: i32
    gl.GetShaderiv(shader, gl.COMPILE_STATUS, &res)
    if bool(res) == gl.FALSE {
        len: i32
        gl.GetShaderiv(shader, gl.INFO_LOG_LENGTH, &len)
        err_buf := make([]u8, len)
        gl.GetShaderInfoLog(shader, len, &len, &err_buf[0])
        fmt.eprintf("Compile", type == gl.VERTEX_SHADER ? "vertex" :
            "fragment", "shader: ", string(err_buf))
    }
    return
}



main :: proc() {

    window := initWindow(720, 720, "test window")

    vertex := loadShader("./vertex.glsl", gl.VERTEX_SHADER)
    fragment := loadShader("./fragment.glsl", gl.FRAGMENT_SHADER)
    prog := gl.CreateProgram()
    gl.AttachShader(prog, vertex)
    gl.AttachShader(prog, fragment)
    gl.LinkProgram(prog)
    gl.ValidateProgram(prog)

    vertices := [?]f32 {
        0.5,  0.5,
        0.5, -0.5,
       -0.5, -0.5,
       -0.5,  0.5
    }

    indices := [?]u32 {
        0, 1, 2, 2, 3, 0
    }

    VAO, VBO, EBO: u32

    gl.GenVertexArrays(1, &VAO)
    gl.BindVertexArray(VAO)

    gl.GenBuffers(1, &VBO)
    gl.GenBuffers(1, &EBO)


    gl.BindBuffer(gl.ARRAY_BUFFER, VBO)
    gl.BufferData(gl.ARRAY_BUFFER, len(vertices) * size_of(f32), raw_data(vertices[:]), gl.STATIC_DRAW)

    gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, EBO)
    gl.BufferData(gl.ELEMENT_ARRAY_BUFFER, len(indices) * size_of(u32), raw_data(indices[:]), gl.STATIC_DRAW)

    gl.VertexAttribPointer(0, 2, gl.FLOAT, gl.FALSE, size_of(f32) * 2, uintptr(0))
    gl.EnableVertexAttribArray(0)

    // gl.BindBuffer(gl.ARRAY_BUFFER, 0)
    // gl.BindVertexArray(0)

    for !bool(glfw.WindowShouldClose(window)) {
        gl.Clear(gl.COLOR_BUFFER_BIT)

        gl.UseProgram(prog)
        gl.Uniform4f(gl.GetUniformLocation(prog, "aColor"), 0.3, 0.1, 0.4, 1.0)
        gl.BindVertexArray(VAO)

        gl.DrawElements(gl.TRIANGLES, 6, gl.UNSIGNED_INT, nil)


        glfw.SwapBuffers(window)
        glfw.PollEvents()

    }


    glfw.DestroyWindow(window)
    glfw.Terminate()
}

