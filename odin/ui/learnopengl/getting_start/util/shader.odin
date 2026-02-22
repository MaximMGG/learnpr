package util

import gl "vendor:OpenGL"
import "core:os"
import "core:fmt"
import math "core:math/linalg"

Shader :: struct {
  id: u32,
  locations: map[string]i32
}

@private
checkHelth :: proc(shader: u32, type: u32) -> bool {
  if type == gl.VERTEX_SHADER {
    res: i32
    gl.GetShaderiv(shader, gl.COMPILE_STATUS, &res)
    if bool(res) == gl.FALSE {
      len: i32
      gl.GetShaderiv(shader, gl.INFO_LOG_LENGTH, &len)
      err_buf := make([]u8, len)
      defer delete(err_buf)
      gl.GetShaderInfoLog(shader, len, &len, raw_data(err_buf))
      fmt.eprint("Compile VERTEX shader error:", transmute(string)err_buf)
      return false
    }  
  } else if type == gl.FRAGMENT_SHADER {
    res: i32
    gl.GetShaderiv(shader, gl.COMPILE_STATUS, &res)
    if bool(res) == gl.FALSE {
      len: i32
      gl.GetShaderiv(shader, gl.INFO_LOG_LENGTH, &len)
      err_buf := make([]u8, len)
      defer delete(err_buf)
      gl.GetShaderInfoLog(shader, len, &len, raw_data(err_buf))
      fmt.eprint("Compile FRAGMENT shader error:", transmute(string)err_buf)
      return false
    }   
  } else if type == gl.PROGRAM {
    res: i32
    gl.GetProgramiv(shader, gl.LINK_STATUS, &res)
    if bool(res) == gl.FALSE {
      len: i32
      gl.GetProgramiv(shader, gl.INFO_LOG_LENGTH, &len)
      err_buf := make([]u8, len)
      defer delete(err_buf)
      gl.GetProgramInfoLog(shader, len, &len, raw_data(err_buf))
      fmt.eprint("Link program error:", transmute(string)err_buf)
      return false
    }   
  }
  return true
}


@private
shaderCompile :: proc(path: string, type: u32) -> (u32, bool) {
  buf, buf_ok := os.read_entire_file(path)
  if !buf_ok {
    return 0, false
  }
  defer delete(buf)
  shader: u32 = gl.CreateShader(type)
  s := cstring(raw_data(buf))
  gl.ShaderSource(shader, 1, ([^]cstring)(&s), nil)
  gl.CompileShader(shader)
  if !checkHelth(shader, type) {
    return 0, false
  }
  return shader, true
}

shaderCreate :: proc(vertexPath: string, fragmentPath: string) -> Shader {
  s: Shader
  vs, vs_ok := shaderCompile(vertexPath, gl.VERTEX_SHADER)
  if !vs_ok {
    return Shader{}
  }
  fs, fs_ok := shaderCompile(fragmentPath, gl.FRAGMENT_SHADER)
  if !fs_ok {
    return Shader{}
  }

  s.id = gl.CreateProgram()
  gl.AttachShader(s.id, vs)
  gl.AttachShader(s.id, fs)
  gl.LinkProgram(s.id)
  gl.DeleteShader(vs)
  gl.DeleteShader(fs)
  if !checkHelth(s.id, gl.PROGRAM) {
    gl.DeleteProgram(s.id)
    return Shader{}
  }
  gl.ValidateProgram(s.id)

  return s
}

shaderDestroy :: proc(s: ^Shader) {
  gl.DeleteProgram(s.id)
  delete(s.locations)
}

shaderUse :: proc(s: ^Shader) {
  gl.UseProgram(s.id)
}

shaderUnuse :: proc(s: ^Shader) {
  gl.UseProgram(0)
}

@private
getLocation :: proc(s: ^Shader, name: string) -> i32 {
  if name in s.locations {
    return s.locations[name]
  } else {
    loc := gl.GetUniformLocation(s.id, cstring(raw_data(name)))
    if loc != -1 {
      s.locations[name] = loc
      return loc
    } else {
      fmt.eprintf("Location for uniform %s do not find\n", name)
      return -1
    }
  }

  return -1
}

setInt :: proc(s: ^Shader, name: string, val: i32) {
  loc := getLocation(s, name)
  if loc != -1 {
    gl.Uniform1i(loc, val)
  }
}

setMat4 :: proc(s: ^Shader, name: string, val: math.Matrix4f32) {
  loc := getLocation(s, name)
  if loc != -1 {
    v := val
    gl.UniformMatrix4fv(loc, 1, false, &v[0][0])
  }
}

setVec3 :: proc {
  setVec3Vec,
  setVec3Val
}

setVec3Vec :: proc(s: ^Shader, name: string, val: math.Vector3f32) {
  loc := getLocation(s, name)
  if loc != -1 {
    v := val
    gl.Uniform3fv(loc, 1, ([^]f32)(&v[0]))
  }
}

setVec3Val :: proc(s: ^Shader, name: string, v0, v1, v2: f32) {
  loc := getLocation(s, name)
  if loc != -1 {
    gl.Uniform3f(loc, v0, v1, v2)
  }
}


