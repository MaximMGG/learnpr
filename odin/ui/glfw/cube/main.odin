package cube

import "base:runtime"
import "core:fmt"
import "core:log"
import c "core:c"
import gl "vendor:OpenGL"
import glfw "vendor:glfw"
import stb "vendor:stb/image"
import "util"
import m "core:math/linalg"

WIDTH :: 1280
HEIGHT :: 720
CUBE_POSITIONS :: 10

faster: bool = false
slower: bool = false

cameraPos := m.Vector3f32{0.0, 0.0, 3.0}
cameraFront := m.Vector3f32{0.0, 0.0, -1.0}
cameraUp := m.Vector3f32{0.0, 1.0, 0.0}

deltaTime: f32
lastFrame: f32


keyCallBack :: proc "c" (window: glfw.WindowHandle, key: c.int, scancode: c.int, action: c.int, mods: c.int) {
    if key == glfw.KEY_ESCAPE && action == glfw.PRESS {
        glfw.SetWindowShouldClose(window, true)
    }

    if key == glfw.KEY_UP && action == glfw.PRESS {
        faster = true
        slower = false
    } else if key == glfw.KEY_DOWN && action == glfw.PRESS {
        slower = true
        faster = false
    }

    cameraSpeed: f32 = 2.5 * deltaTime
    if key == glfw.KEY_W && action == glfw.PRESS {
        cameraPos += cameraSpeed * cameraFront
    } 
    if key == glfw.KEY_S && action == glfw.PRESS {
        cameraPos -= cameraSpeed * cameraFront
    }
    if key == glfw.KEY_A && action == glfw.PRESS {
        cameraPos -= m.normalize(m.vector_cross(cameraFront, cameraUp)) * cameraSpeed
    }
    if key == glfw.KEY_D && action == glfw.PRESS {
        cameraPos += m.normalize(m.vector_cross(cameraFront, cameraUp)) * cameraSpeed
    }
}

main :: proc() {
    context.logger = log.create_console_logger()
    defer log.destroy_console_logger(context.logger)

    fmt.println("Init glfw")
    glfw.Init()
    defer glfw.Terminate()
    log.log(.Info, "Init glfw")

    window := glfw.CreateWindow(WIDTH, HEIGHT, "CUBE", nil, nil)
    defer glfw.DestroyWindow(window)
    log.log(.Info, "Create window")

    glfw.MakeContextCurrent(window)
    glfw.SetKeyCallback(window, keyCallBack)

    gl.load_up_to(3, 3, proc(p: rawptr, name: cstring){
        (^rawptr)(p)^ = glfw.GetProcAddress(name)
    })

    gl.Enable(gl.DEPTH_TEST)

    shader := util.compileShader("./vertex.glsl", "./fragment.glsl")
    defer gl.DeleteProgram(shader.id)
    log.log(.Info, "Compile Shaders")

    util.check_err()

    vertices := [?]f32 {
        -0.5, -0.5, -0.5,  0.0, 0.0,
         0.5, -0.5, -0.5,  1.0, 0.0,
         0.5,  0.5, -0.5,  1.0, 1.0,
         0.5,  0.5, -0.5,  1.0, 1.0,
        -0.5,  0.5, -0.5,  0.0, 1.0,
        -0.5, -0.5, -0.5,  0.0, 0.0,

        -0.5, -0.5,  0.5,  0.0, 0.0,
         0.5, -0.5,  0.5,  1.0, 0.0,
         0.5,  0.5,  0.5,  1.0, 1.0,
         0.5,  0.5,  0.5,  1.0, 1.0,
        -0.5,  0.5,  0.5,  0.0, 1.0,
        -0.5, -0.5,  0.5,  0.0, 0.0,

        -0.5,  0.5,  0.5,  1.0, 0.0,
        -0.5,  0.5, -0.5,  1.0, 1.0,
        -0.5, -0.5, -0.5,  0.0, 1.0,
        -0.5, -0.5, -0.5,  0.0, 1.0,
        -0.5, -0.5,  0.5,  0.0, 0.0,
        -0.5,  0.5,  0.5,  1.0, 0.0,

         0.5,  0.5,  0.5,  1.0, 0.0,
         0.5,  0.5, -0.5,  1.0, 1.0,
         0.5, -0.5, -0.5,  0.0, 1.0,
         0.5, -0.5, -0.5,  0.0, 1.0,
         0.5, -0.5,  0.5,  0.0, 0.0,
         0.5,  0.5,  0.5,  1.0, 0.0,

        -0.5, -0.5, -0.5,  0.0, 1.0,
         0.5, -0.5, -0.5,  1.0, 1.0,
         0.5, -0.5,  0.5,  1.0, 0.0,
         0.5, -0.5,  0.5,  1.0, 0.0,
        -0.5, -0.5,  0.5,  0.0, 0.0,
        -0.5, -0.5, -0.5,  0.0, 1.0,

        -0.5,  0.5, -0.5,  0.0, 1.0,
         0.5,  0.5, -0.5,  1.0, 1.0,
         0.5,  0.5,  0.5,  1.0, 0.0,
         0.5,  0.5,  0.5,  1.0, 0.0,
        -0.5,  0.5,  0.5,  0.0, 0.0,
        -0.5,  0.5, -0.5,  0.0, 1.0
    }

    cubePosition := [CUBE_POSITIONS]m.Vector3f32{
        m.Vector3f32{0.0,  0.0,  0.0},
        m.Vector3f32{ 2.0,  5.0, -15.0},
        m.Vector3f32{-1.5, -2.2, -2.5},
        m.Vector3f32{-3.8, -2.0, -12.3},
        m.Vector3f32{ 2.4, -0.4, -3.5},
        m.Vector3f32{-1.7,  3.0, -7.5},
        m.Vector3f32{ 1.3, -2.0, -2.5},
        m.Vector3f32{ 1.5,  2.0, -2.5},
        m.Vector3f32{ 1.5,  0.2, -1.5},
        m.Vector3f32{-1.3,  1.0, -1.5}
    }

    cubeRotation := [CUBE_POSITIONS]f32{
        0.1,
        0.2,
        0.3,
        0.4,
        0.5,
        0.6,
        0.7,
        0.8,
        0.9,
        1.0,
    }

    

    VAO, VBO: u32

    gl.GenVertexArrays(1, &VAO)
    defer gl.DeleteVertexArrays(1, &VAO)
    gl.GenBuffers(1, &VBO)
    defer gl.DeleteBuffers(1, &VBO)

    gl.BindVertexArray(VAO)

    gl.BindBuffer(gl.ARRAY_BUFFER, VBO)
    gl.BufferData(gl.ARRAY_BUFFER, size_of(vertices), &vertices[0], gl.STATIC_DRAW)

    gl.VertexAttribPointer(0, 3, gl.FLOAT, gl.FALSE, size_of(f32) * 5, uintptr(0))
    gl.EnableVertexAttribArray(0)
    gl.VertexAttribPointer(1, 2, gl.FLOAT, gl.FALSE, size_of(f32) * 5, uintptr(size_of(f32) * 3))
    gl.EnableVertexAttribArray(1)


    util.check_err()
    texture: u32
    gl.GenTextures(1, &texture)
    defer gl.DeleteTextures(1, &texture)
    gl.BindTexture(gl.TEXTURE_2D, texture)

    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT)
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT)

    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR)
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)

    util.check_err()
    stb.set_flip_vertically_on_load(c.int(1))
    width, height, nrChannels: c.int
    data := stb.load("crate.png", &width, &height, &nrChannels, 0)
    if data != nil {
        format: u32 = nrChannels == 4 ? gl.RGBA : gl.RGB
        gl.TexImage2D(gl.TEXTURE_2D, 0, i32(format), width, height, 0, u32(format), gl.UNSIGNED_BYTE, data)
        gl.GenerateMipmap(gl.TEXTURE_2D)

    } else {
        log.error("Cant load texture")
        return
    }
    stb.image_free(data)

    util.check_err()
    gl.UseProgram(shader.id)
    util.setInt(shader, "texture1", 0)

    projection := m.MATRIX4F32_IDENTITY
    projection *= m.matrix4_perspective(f32(m.to_radians(45.0)), f32(WIDTH) / f32(HEIGHT), f32(0.1), f32(100.0))
    util.setMat4(shader, "projection", &projection)

    log.log(.Info, "Start main loop")
    util.check_err()



    for !bool(glfw.WindowShouldClose(window)) {

        currentFrame := f32(glfw.GetTime())
        deltaTime = currentFrame - lastFrame
        lastFrame = currentFrame


        gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
        gl.UseProgram(shader.id)

        gl.ActiveTexture(gl.TEXTURE0)
        gl.BindTexture(gl.TEXTURE_2D, texture)

        gl.UseProgram(shader.id)

        view := m.matrix4_look_at_f32(cameraPos, cameraPos + cameraFront, cameraUp)
        util.setMat4(shader, "view", &view)


        for i in 0..<CUBE_POSITIONS {
            if faster {
                cubeRotation[i] += 0.1
            } else if slower {
                cubeRotation[i] -= 0.1
            }
        }

        faster = false
        slower = false


        gl.BindVertexArray(VAO)
        for i in 0..<CUBE_POSITIONS {
            model := m.matrix4_translate(cubePosition[i])
            model *= m.matrix4_rotate(f32(glfw.GetTime()) * cubeRotation[i], m.Vector3f32{1.0, 0.3, 0.5})
            util.setMat4(shader, "model", &model)

            gl.DrawArrays(gl.TRIANGLES, 0, 36)
        }


        glfw.SwapBuffers(window)
        glfw.PollEvents()
        util.check_err()
    }
}
