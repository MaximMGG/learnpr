package util

import "core:os"
import "core:log"
import "core:fmt"
import gl "vendor:OpenGL"
import m "core:math/linalg"

ShaderError :: enum {
  OPEN_FILE_ERROR,
  FILE_READ_ERROR,
  COMPILE_ERROR,
  LINK_ERROR
}

Shader :: struct {
  id: int,
  location: map[string]int
}

ShaderType :: enum {
  VERTEX_SHADER,
  FRAGMENT_SHADER,
  PROGRAM
}

@(private)
checkStatus :: proc(shader: u32, type: ShaderType) -> bool {
  switch(type) {
  case .VERTEX_SHADER, .FRAGMENT_SHADER: 
    res: i32
    gl.GetShaderiv(shader, gl.COMPILE_STATUS, &res)
    if bool(res) == gl.FALSE {
      len: i32
      gl.GetShaderiv(shader, gl.INFO_LOG_LENGTH, &len)
      err_msg := make([]u8, len)
      defer delete(err_msg)
      gl.GetShaderInfoLog(shader, len, &len, raw_data(err_msg))

      log.error("Compile Shader", "vertex" if type == .VERTEX_SHADER else
        "fragment", transmute(string)err_msg)
      return false
    }
  case .PROGRAM:
    res: i32
    gl.GetProgramiv(shader, gl.LINK_STATUS, &res)
    if bool(res) == gl.FALSE {
      len: i32
      gl.GetProgramiv(shader, gl.INFO_LOG_LENGTH, &len)
      err_msg := make([]u8, len)
      gl.GetProgramInfoLog(shader, len, &len, raw_data(err_msg))
      log.error("Program link error:", transmute(string)err_msg)
      return false
    }
  }

  return true
}


@(private)
compileShaderHelper :: proc(path: string, type: int) -> (u32,
  ShaderError) {
  file, file_err := os.open(path)
  if file_err != nil {
    log.error("Compile shader error:", file_err)
    return 0, .OPEN_FILE_ERROR
  }
  defer os.close(file)
  stat, stat_err := os.fstat(file)
  if stat_err != nil {
    log.error("fstat error:", stat_err)
    return 0, .OPEN_FILE_ERROR
  }
  defer os.file_info_delete(stat)
  buf := make([]u8, stat.size)
  defer delete(buf)
  
  read_bytes, read_err := os.read(file, buf)
  if read_err != nil {
    log.error("os.read error:", read_err)
    return 0, .FILE_READ_ERROR
  }

  if i64(read_bytes) != stat.size {
    log.error("Read bytes", read_bytes, "not equalse stat.size", stat.size)
    return 0, .FILE_READ_ERROR
  }
  shader := gl.CreateShader(u32(type))
  shader_source: cstring = cstring(raw_data(buf))
  gl.ShaderSource(shader, 1, &shader_source, nil)
  gl.CompileShader(shader)
  if !checkStatus(shader, .VERTEX_SHADER if type == gl.VERTEX_SHADER else
    .FRAGMENT_SHADER) {

    log.error("Shader compile error")
    return 0, .COMPILE_ERROR
  }

  return shader, nil
}


compileShader :: proc(vs: cstring, fs: cstring) -> Shader {
  vertex_shader, v_err := compileShaderHelper(string(vs), gl.VERTEX_SHADER)
  if v_err != nil {
    log.error("Vertex shader compile error")
    return Shader{}
  }
  fragment_shader, f_err := compileShaderHelper(string(fs), gl.FRAGMENT_SHADER)
  if f_err != nil {
    log.error("Fragment shader compile error")
    return Shader{}
  }

  program := gl.CreateProgram()
  gl.AttachShader(program, vertex_shader)
  gl.AttachShader(program, fragment_shader)
  gl.LinkProgram(program)
  if !checkStatus(program, .PROGRAM) {
    log.error("Link program error")
    return Shader{}
  }
  gl.ValidateProgram(program)

  gl.DeleteShader(vertex_shader)
  gl.DeleteShader(fragment_shader)

  return Shader{id = 1}
}
