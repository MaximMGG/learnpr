package shader

import "core:os"
import "core:fmt"
import gl "vendor:OpenGL"
import math "core:math/linalg"

Shader :: u32

ShaderError :: enum {
  CompileError,
  LinkError,
}

@(private)
checkShaderStatus :: proc(shader: Shader, type: u32) -> bool {
  switch type {
  case gl.VERTEX_SHADER:
    result: i32
    gl.GetShaderiv(shader, gl.COMPILE_STATUS, &result)
    if bool(result) == gl.FALSE {
      len: i32
      gl.GetShaderiv(shader, gl.INFO_LOG_LENGTH, &len)
      tmp_buf := make([]u8, len + 1)
      defer delete(tmp_buf)
      gl.GetShaderInfoLog(shader, len, &len, raw_data(tmp_buf))
      fmt.eprintf("Error compile VERTEX shader:", transmute(string)tmp_buf)
      return false
    }
  case gl.FRAGMENT_SHADER:
    result: i32
    gl.GetShaderiv(shader, gl.COMPILE_STATUS, &result)
    if bool(result) == gl.FALSE {
      len: i32
      gl.GetShaderiv(shader, gl.INFO_LOG_LENGTH, &len)
      tmp_buf := make([]u8, len + 1)
      defer delete(tmp_buf)
      gl.GetShaderInfoLog(shader, len, &len, raw_data(tmp_buf))
      fmt.eprintf("Error compile FRAGMENT shader:", transmute(string)tmp_buf)
      return false
    }
  case gl.PROGRAM:
    result: i32
    gl.GetProgramiv(shader, gl.LINK_STATUS, &result)
    if bool(result) == gl.FALSE {
      len: i32
      gl.GetProgramiv(shader, gl.INFO_LOG_LENGTH, &len)
      tmp_buf := make([]u8, len + 1)
      defer delete(tmp_buf)
      gl.GetProgramInfoLog(shader, len, &len, raw_data(tmp_buf))
      fmt.eprintf("Error link PROGRAM:", transmute(string)tmp_buf)
      return false
    }
  }
  return true
}


@(private)
compileShader :: proc(path: string, type: u32) -> u32 {
  buf, buf_ok := os.read_entire_file(path)
  if !buf_ok {
    fmt.eprintln("read_entire_file:", path, "error")
    return 0
  }
  defer delete(buf)
  shader := gl.CreateShader(type)
  s := raw_data(buf)
  gl.ShaderSource(shader, 1, ([^]cstring)(&s), nil)
  gl.CompileShader(shader)
  if !checkShaderStatus(shader, type) {
    return 0
  }
  return shader
}

createShader :: proc(vertexPath: string, fragmentPath: string) -> (Shader, ShaderError) {
  vertexShader := compileShader(vertexPath, gl.VERTEX_SHADER)
  if vertexShader == 0 {
    return 0, .CompileError
  }
  fragmentShader := compileShader(fragmentPath, gl.FRAGMENT_SHADER)
  if fragmentShader == 0 {
    return 0, .CompileError
  }
  shader: Shader = gl.CreateProgram()
  gl.AttachShader(shader, vertexShader)
  gl.AttachShader(shader, fragmentShader)
  gl.LinkProgram(shader)
  if !checkShaderStatus(shader, gl.PROGRAM) {
    return 0, .LinkError
  }
  gl.ValidateProgram(shader)
  gl.DeleteShader(vertexShader)
  gl.DeleteShader(fragmentShader)

  return shader, nil
}

use :: proc(shader: Shader) {
  gl.UseProgram(shader)
}

setInt :: proc(shader: Shader, name: cstring, val: i32) {
  location := gl.GetUniformLocation(shader, name)
  if location < 0 {
    fmt.eprintln("Cant find location for uniform:", name)
    return
  }
  gl.Uniform1i(location, val)
}

setMat4 :: proc(shader: Shader, name: cstring, val: math.Matrix4f32) {
  location := gl.GetUniformLocation(shader, name)
  if location < 0 {
    fmt.eprintln("Cant find location for uniform:", name)
    return
  }
  val := val
  gl.UniformMatrix4fv(location, 1, false, ([^]f32)(&val[0]))
}


