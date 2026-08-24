package shader

import "core:os"
import "core:log"
import gl "vendor:OpenGL"
import la "core:math/linalg"

Shader :: struct {
  id: u32,
  uniforms: map[string]i32
}

@(private)
checkStatus :: proc(element: u32, element_type: u32) -> bool {
  switch element_type {
  case gl.VERTEX_SHADER:
    status: i32
    gl.GetShaderiv(element, gl.COMPILE_STATUS, &status)
    if status == 0 {
      buf: [512]u8
      gl.GetShaderInfoLog(element, 512, nil, raw_data(buf[:]))
      log.error("Compile VERTEX shader error:", transmute(string)buf[:])
      return false
    }
  case gl.FRAGMENT_SHADER:
    status: i32
    gl.GetShaderiv(element, gl.COMPILE_STATUS, &status)
    if status == 0 {
      buf: [512]u8
      gl.GetShaderInfoLog(element, 512, nil, raw_data(buf[:]))
      log.error("Compile FRAGMENT shader error:", transmute(string)buf[:])
      return false
    } else {
      return true
    }
  case 0:
    status: i32
    gl.GetProgramiv(element, gl.LINK_STATUS, &status)
    if status == 0 {
      buf: [512]u8
      gl.GetProgramInfoLog(element, 512, nil, raw_data(buf[:]))
      log.error("Link progarm error:", transmute(string)buf[:])
      return false
    }
  }
  return true
}

@(private)
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
  f_shader := compile(fragment_path, gl.FRAGMENT_SHADER)
  if f_shader == 0 {
    gl.DeleteShader(f_shader)
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


use :: proc(s: ^Shader) {
  gl.UseProgram(s.id)
}

@(private)
get_uniform_location :: proc(s: ^Shader, uniform_name: string) -> i32 {
  loc, ok := s.uniforms[uniform_name]
  if ok {
    return loc
  } else {
    new_loc := gl.GetUniformLocation(s.id, cstring(raw_data(uniform_name)))
    if new_loc != -1 {
      s.uniforms[uniform_name] = new_loc
      return new_loc
    } else {
      log.error("Can't find uniform:", uniform_name)
      return -1
    }
  }
}

set_int :: proc(s: ^Shader, uniform_name: string, val: i32) {
  loc := get_uniform_location(s, uniform_name)
  if loc != -1 {
    gl.Uniform1i(loc, val)
  }
}

set_float :: proc(s: ^Shader, uniform_name: string, val: f32) {
  loc := get_uniform_location(s, uniform_name)
  if loc != -1 {
    gl.Uniform1f(loc, val)
  }
}

set_vec3 :: proc(s: ^Shader, uniform_name: string, val: la.Vector3f32) {
  loc := get_uniform_location(s, uniform_name)
  if loc != -1 {
    val := val
    gl.Uniform3fv(loc, 1, &val[0])
  }
}

set_mat4 :: proc(s: ^Shader, uniform_name: string, val: la.Matrix4x4f32) {
  loc := get_uniform_location(s, uniform_name)
  if loc != -1 {
    val := val
    gl.UniformMatrix4fv(loc, 1, false, &val[0][0])
  }
}

destroy :: proc(s: ^Shader) {
  gl.DeleteProgram(s.id)
  delete(s.uniforms)
}


