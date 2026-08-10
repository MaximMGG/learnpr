package shader

import "core:os"
import "core:log"
import gl "vendor:OpenGL"
import "core:math/linalg"

Shader :: struct {
  id: u32,
  uniforms: map[string]i32
}
checkStatus :: proc(element: u32, element_type: u32) -> bool {
  switch element_type {
  case gl.VERTEX_SHADER:
    status: i32
    gl.GetShaderiv(element, gl.COMPILE_STATUS, &status)
    if status == i32(gl.FALSE) {
      buf: [512]u8
      gl.GetShaderInfoLog(element, 512, nil, raw_data(buf[:]))
      log.error("Compile VERTEX shader error:", buf[:])
      return false
    }
  case gl.FRAGMENT_SHADER:
    status: i32
    gl.GetShaderiv(element, gl.COMPILE_STATUS, &status)
    if status == i32(gl.FALSE) {
      buf: [512]u8
      gl.GetShaderInfoLog(element, 512, nil, raw_data(buf[:]))
      log.error("Compile FRAGMENT shader error:", buf[:])
      return false
    }
  case 0:
    status: i32
    gl.GetProgramiv(element, gl.LINK_STATUS, &status)
    if status == i32(gl.FALSE) {
      buf: [512]u8
      gl.GetProgramInfoLog(element, 512, nil, raw_data(buf[:]))
      log.error("Link progarm error:", buf[:])
      return false
    }
  }
  return true
}

compile :: proc(path: string, shader_type: u32) -> u32 {
  source, err := os.read_entire_file(path, context.allocator)
  if err != nil {
    log.error("Read shader source error")
    return 0
  }
  defer delete(source)

  shader: u32 = gl.CreateShader(shader_type)
  gl.ShaderSource(shader, 1, ([^]cstring)(&source), nil)
  gl.CompileShader(shader)
  if !checkStatus(shader, shader_type) {
    log.error("Compile shader error")
    return 0
  }

  return shader
}

load :: proc(vertex_path: string, fragment_path: string) -> Shader {
  v_shader := compile(vertex_path, gl.VERTEX_SHADER)
  if v_shader == 0 {
    log.error("load program error")
    return Shader{}
  }
  f_shader := compile(vertex_path, gl.FRAGMENT_SHADER)
  if f_shader == 0 {
    gl.DeleteShader(v_shader)
    log.error("load program error")
    return Shader{}
  }

  program := gl.CreateProgram()
  gl.AttachShader(program, v_shader)
  gl.AttachShader(program, f_shader)
  gl.LinkProgram(program)
  gl.DeleteShader(v_shader)
  gl.DeleteShader(f_shader)
  if !checkStatus(program, 0) {
    log.error("load program error")
    return Shader{}
  }

  return Shader{id = program, uniforms = make(map[string]i32)}
}
