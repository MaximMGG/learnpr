package app

// foreign import lib {
//     "system:GLEW",
// };

import "vendor:glfw"
import GL "vendor:OpenGL"
import "core:fmt"
import "core:c"
import "core:os"
import "core:strings"


// @(default_calling_convention="c")
// foreign lib {
//     glewInit :: proc() -> c.int ---
// }


WIDTH :: 640
HEIGHT :: 480


load_shader :: proc(shader_name: string, shader_type: u32) -> u32 {
    file, f_err := os.open(shader_name, os.O_RDONLY)
    defer os.close(file)
    if f_err != nil {
        fmt.eprintln("Cant open shader file %s", shader_name)
        return 0;
    }
    file_info, file_info_err := os.fstat(file)
    if file_info_err != nil {
        fmt.eprintln("Cant fstat file %s", shader_name)
        return 0;
    }
    buf := make([]u8, file_info.size + 1)
    defer delete(buf)
    read_byte, _ := os.read(file, buf)
    if i64(read_byte) != file_info.size {
        fmt.eprintln("Cant fstat file %s", shader_name)
        return 0;
    }

    shaderSource: cstring = strings.clone_to_cstring(string(buf))
    defer delete(shaderSource)

    shader: u32 = GL.CreateShader(shader_type)
    GL.ShaderSource(shader, 1, &shaderSource, nil)
    GL.CompileShader(shader)

    res: i32
    GL.GetShaderiv(shader, GL.COMPILE_STATUS, &res)
    if res == 0 {
        err_len: i32
        GL.GetShaderiv(shader, GL.INFO_LOG_LENGTH, &err_len)
        err_buf := make([]u8, err_len + 1)
        defer delete(err_buf)
        GL.GetShaderInfoLog(shader, err_len, nil, raw_data(err_buf))
        fmt.eprintln("Compile shader %s error\n%s", shader_name, err_buf)
        return 0;
    }
    return shader
}


main :: proc() {
    if !bool(glfw.Init()) {
        fmt.eprintln("glfw Init error")
        return
    }

    // glfw.WindowHint(glfw.RESIZABLE, glfw.TRUE)
    // glfw.WindowHint(glfw.OPENGL_FORWARD_COMPAT, glfw.TRUE)
    // glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)
    // glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, c.int(3))
    // glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, c.int(3))



    window := glfw.CreateWindow(WIDTH, HEIGHT, "TEST WINDOW", nil, nil)
    if window == nil {
        fmt.eprintln("Create window error")
        return
    }

    glfw.MakeContextCurrent(window)
    // glfw.SwapInterval(1)
    // GL.Enable(GL.BLEND)

    // if glewInit() != 0 {
    //     fmt.eprintln("GLEW error")
    //     return
    // }

    //fmt.printfln("GL Version %s", GL.GetString(GL.VERSION))


    vertexShader: u32 = load_shader("vertex.glsl", GL.VERTEX_SHADER)
    fragmentShader: u32 = load_shader("fragment.glsl", GL.FRAGMENT_SHADER)
    program: u32 = GL.CreateProgram()
    GL.AttachShader(program, vertexShader)
    GL.AttachShader(program, fragmentShader)
    GL.LinkProgram(program)
    GL.UseProgram(program)

    position: [6]f32 = {
       -0.5, -0.5,
        0.0,  0.5,
        0.5, -0.5
    }

    vbo: u32
    vao: u32

    GL.GenVertexArrays(1, &vao)
    GL.GenBuffers(1, &vbo)

    GL.BindVertexArray(vao)
    GL.BindBuffer(GL.ARRAY_BUFFER, vbo)
    GL.BufferData(GL.ARRAY_BUFFER, size_of(position), raw_data(&position), GL.STATIC_DRAW)

    GL.VertexAttribPointer(0, 2, GL.FLOAT, GL.FALSE, size_of(f32) * 2, uintptr(0))
    GL.EnableVertexAttribArray(0)

    for !bool(glfw.WindowShouldClose(window)) {
        GL.Clear(GL.COLOR_BUFFER_BIT)

        GL.DrawArrays(GL.TRIANGLES, 0, 3)

        glfw.SwapBuffers(window)
        glfw.PollEvents()
    }

    glfw.DestroyWindow(window)
    glfw.Terminate()
}
