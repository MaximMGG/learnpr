package shader

import "core:os"
import "core:fmt"
import math "core:math/linalg"
import gl "vendor:OpenGL"

Shader :: struct {
  id: u32,
}

check_compile_error :: proc(shader: u32, type: u32) -> bool {
  success: i32
  infoLog: [1024]u8

  if type == gl.VERTEX_SHADER {
    gl.GetShaderiv(shader, gl.COMPILE_STATUS, &success)
    if bool(success) == gl.FALSE {
      gl.GetShaderInfoLog(shader, 1024, nil, raw_data(infoLog[:]))
      fmt.eprintf("Compile Vertex Shader error: %s\n", string(infoLog[:]))
      return false
    }
  } else if type == gl.FRAGMENT_SHADER {

    gl.GetShaderiv(shader, gl.COMPILE_STATUS, &success)
    if bool(success) == gl.FALSE {
      gl.GetShaderInfoLog(shader, 1024, nil, raw_data(infoLog[:]))
      fmt.eprintf("Compile Fragment Shader error: %s\n", string(infoLog[:]))
      return false
    }
  } else if type == gl.PROGRAM {
    gl.GetProgramiv(shader, gl.LINK_STATUS, &success)
    if bool(success) == gl.FALSE {
      gl.GetProgramInfoLog(shader, 1024, nil, raw_data(infoLog[:]))
      fmt.eprintf("Link Programm error: %s\n", string(infoLog[:]))
      return false
    }
  } else {
    fmt.eprintln(type, " - not support")
    return false
  }
  return true
}

compileShader :: proc(path: string, type: u32) -> u32 {
  buf, buf_ok := os.read_entire_file(path)
  defer delete(buf)

  shader := gl.CreateShader(type)
  s := cstring(raw_data(buf))
  gl.ShaderSource(shader, 1, &s, nil)
  gl.CompileShader(shader)
  if !check_compile_error(shader, type) {
    return 0
  }
  return shader
}

createShader :: proc(vertexPath: string, fragmentPath: string) -> (Shader, bool) {
  vertexShader := compileShader(vertexPath, gl.VERTEX_SHADER)
  fragmentShader := compileShader(fragmentPath, gl.FRAGMENT_SHADER)
  id: u32 = gl.CreateProgram()
  gl.AttachShader(id, vertexShader)
  gl.AttachShader(id, fragmentShader)
  gl.LinkProgram(id)
  if !check_compile_error(id, gl.PROGRAM) {
    return Shader{id = 0}, false
  }
  gl.DeleteShader(vertexShader)
  gl.DeleteShader(fragmentShader)

  return Shader{id = id}, true
}

use :: proc(shader: Shader) {
  gl.UseProgram(shader.id)
}

setBool :: proc(shader: Shader, name: string, val: bool) {
  gl.Uniform1i(gl.GetUniformLocation(shader.id, cstring(raw_data(name))), i32(val))
}

setInt :: proc(shader: Shader, name: string, val: i32) {
  gl.Uniform1i(gl.GetUniformLocation(shader.id, cstring(raw_data(name))), val)
}

setFloat :: proc(shader: Shader, name: string, val: f32) {
  gl.Uniform1f(gl.GetUniformLocation(shader.id, cstring(raw_data(name))), val)
}

setVec2 :: proc(shader: Shader, name: string, val: math.Vector2f32) {
  v := val
  gl.Uniform2fv(gl.GetUniformLocation(shader.id, cstring(raw_data(name))), 1, ([^]f32)(&v[0]))
}

setVec3 :: proc(shader: Shader, name: string, val: math.Vector3f32) {
  v := val
  gl.Uniform3fv(gl.GetUniformLocation(shader.id, cstring(raw_data(name))), 1, ([^]f32)(&v[0]))
}

setVec4 :: proc(shader: Shader, name: string, val: math.Vector4f32) {
  v := val
  gl.Uniform4fv(gl.GetUniformLocation(shader.id, cstring(raw_data(name))), 1, ([^]f32)(&v[0]))
}

setMat2 :: proc(shader: Shader, name: string, val: math.Matrix2f32) {
  v := val
  gl.UniformMatrix2fv(gl.GetUniformLocation(shader.id, cstring(raw_data(name))), 1, gl.FALSE, ([^]f32)(&v[0]))
}

setMat3 :: proc(shader: Shader, name: string, val: math.Matrix3f32) {
  v := val
  gl.UniformMatrix3fv(gl.GetUniformLocation(shader.id, cstring(raw_data(name))), 1, gl.FALSE, ([^]f32)(&v[0]))
}

setMat4 :: proc(shader: Shader, name: string, val: math.Matrix4f32) {
  v := val
  gl.UniformMatrix4fv(gl.GetUniformLocation(shader.id, cstring(raw_data(name))), 1, gl.FALSE, ([^]f32)(&v[0]))
}


