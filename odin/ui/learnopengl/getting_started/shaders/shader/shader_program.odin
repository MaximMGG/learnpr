package shader

import gl "vendor:OpenGL"
import "core:os"
import "core:log"

load_shader_error :: enum {
  NONE,
  READ_SOURCE_ERR,
  COMPILE_VERTEX_SHADER_ERR,
  COMPILE_FRAGMENT_SHADER_ERR,
  LINK_PROGRAM_ERR
}

load_program :: proc(vertex_path: string, fragment_path: string) -> (u32, load_shader_error) {
  vertex_shader, v_err := load_shader(vertex_path, gl.VERTEX_SHADER)
  if v_err != nil {
    return 0, v_err
  }
  fragment_shader, f_err := load_shader(fragment_path, gl.FRAGMENT_SHADER)
  if f_err != nil {
    gl.DeleteShader(vertex_shader)
    return 0, f_err
  }
  program := gl.CreateProgram()
  gl.AttachShader(program, vertex_shader)
  gl.AttachShader(program, fragment_shader)
  gl.LinkProgram(program)
  gl.DeleteShader(vertex_shader)
  gl.DeleteShader(fragment_shader)

  status := check_status(program, gl.PROGRAM)
  if status != .NONE {
    return 0, status
  }
  return program, nil
}

load_shader :: proc(path: string, shader_type: u32) -> (u32, load_shader_error) {
  shaderSource, s_err := os.read_entire_file(path, context.allocator)
  defer delete(shaderSource)
  if s_err != nil {
    return 0, .READ_SOURCE_ERR
  }

  shader: u32
  gl.CreateShader(shader_type)
  shader_source_string := cstring(raw_data(shaderSource))
  gl.ShaderSource(shader, 1, &shader_source_string, nil)
  gl.CompileShader(shader)
  status := check_status(shader, shader_type)
  if status != .NONE {
    return 0, status
  }
  return shader, nil
}

check_status :: proc(element: u32, type: u32) -> load_shader_error {
  switch type {
  case gl.VERTEX_SHADER:
    status: i32
    gl.GetShaderiv(element, gl.COMPILE_STATUS, &status)
    if status == i32(gl.FALSE) {
      err_msg: [512]byte
      err_msg_len: i32
      gl.GetShaderiv(element, gl.INFO_LOG_LENGTH, &err_msg_len)
      gl.GetShaderInfoLog(element, 512, nil, raw_data(err_msg[:]))
      log.error("Compile vertex shader error:", transmute(string)err_msg[:err_msg_len])
      return .COMPILE_VERTEX_SHADER_ERR
    }
  case gl.FRAGMENT_SHADER:
    status: i32
    gl.GetShaderiv(element, gl.COMPILE_STATUS, &status)
    if status == i32(gl.FALSE) {
      err_msg: [512]byte
      err_msg_len: i32
      gl.GetShaderiv(element, gl.INFO_LOG_LENGTH, &err_msg_len)
      gl.GetShaderInfoLog(element, 512, nil, raw_data(err_msg[:]))
      log.error("Compile fragment shader error:", transmute(string)err_msg[:err_msg_len])
      return .COMPILE_FRAGMENT_SHADER_ERR
    }
  case gl.PROGRAM:
    status: i32
    gl.GetProgramiv(element, gl.LINK_STATUS, &status)
    if status == i32(gl.FALSE) {
      err_msg: [512]byte
      err_msg_len: i32
      gl.GetProgramiv(element, gl.INFO_LOG_LENGTH, &err_msg_len)
      gl.GetProgramInfoLog(element, 512, nil, raw_data(err_msg[:]))
      log.error("Link program error:", transmute(string)err_msg[:err_msg_len])
      return .LINK_PROGRAM_ERR
    }
  }

  return .NONE
}



