package util

import "core:os"
import "core:fmt"
import "core:strings"
import gl "vendor:OpenGL"

ShaderError :: enum {
    OPEN_FILE_ERROR,
    FILE_READ_ERROR,
    COMPILE_ERROR,
    LINK_ERROR
}

Shader :: struct {
    id: u32
}

ShaderType :: enum {
    VERTEX_SHADER,
    FRAGMENT_SHADER,
    PROGRAM
}


@(private)
checkStatus :: proc(shader: u32, type: ShaderType) -> bool {
    switch type {
    case .VERTEX_SHADER, .FRAGMENT_SHADER:
        res: i32
        gl.GetShaderiv(shader, gl.COMPILE_STATUS, &res)
        if bool(res) == gl.FALSE {
            len: i32
            gl.GetShaderiv(shader, gl.INFO_LOG_LENGTH, &len)
            err_msg := make([]u8, len)
            defer delete(err_msg)
            fmt.eprintf("Cant compile %s shader: %s\n", "vertex" if type == .VERTEX_SHADER else "fragment", err_msg)
            return false
        }
    case .PROGRAM:
        res: i32
        gl.GetProgramiv(shader, gl.LINK_STATUS, &res)
        if bool(res) == gl.FALSE {
            len: i32
            gl.GetProgramiv(shader, gl.INFO_LOG_LENGTH, &len)
            err_msg := make([]u8, len)
            defer delete(err_msg)
            fmt.eprintf("Cant link program: %s\n", err_msg)
            return false
        }
    }

    return true
}


@(private)
compileShaderHelper :: proc(path: string, shader_type: int) -> (u32, ShaderError){
    file, file_err := os.open(path)
    defer os.close(file)
    if file_err != nil {
        fmt.eprintln("Cant open ", path)
        return 0, .OPEN_FILE_ERROR
    }
    stat, _ := os.fstat(file)
    buf := make([]u8, stat.size + 1)
    defer delete(buf)

    read_bytes, _ := os.read(file, buf)
    if i64(read_bytes) != stat.size {
        fmt.eprintfln("%d != %d", read_bytes, stat.size)
        return 0, .FILE_READ_ERROR
    }
    shader: u32 = gl.CreateShader(u32(shader_type))
    shader_source: cstring = transmute(cstring)raw_data(buf)

    gl.ShaderSource(shader, 1, &shader_source, nil)
    gl.CompileShader(shader)
    if !checkStatus(shader, .VERTEX_SHADER if shader_type == gl.VERTEX_SHADER else .FRAGMENT_SHADER) {
        return 0, .COMPILE_ERROR
    }
    return shader, nil
}

compileShader :: proc(v_path: string, f_path: string) -> Shader {
    vertex_shader, v_err := compileShaderHelper(v_path, gl.VERTEX_SHADER)
    if v_err != nil {
        fmt.eprintf("%v\n", v_err)
        return Shader{}
    }
    fragment_shader, f_err := compileShaderHelper(v_path, gl.FRAGMENT_SHADER)
    if f_err != nil {
        fmt.eprintf("%v\n", v_err)
        return Shader{}
    }

    program := gl.CreateProgram()
    gl.AttachShader(program, vertex_shader)
    gl.AttachShader(program, fragment_shader)
    gl.LinkProgram(program)
    if !checkStatus(program, .PROGRAM) {
        fmt.eprintln("Linkage error")
        return Shader{}
    }
    gl.ValidateProgram(program)

    gl.DeleteShader(vertex_shader)
    gl.DeleteShader(fragment_shader)

    return Shader{program}
}


