package texture


import gl "vendor:OpenGL"
import stbi "vendor:stb/image"
import "core:log"

load_texture_error :: enum {
  NONE,
  LOAD_TEXTURE_ERR,
}

load_jpg :: proc(path: string) -> (u32, load_texture_error) {
  tex: u32
  gl.GenTextures(1, &tex)
  gl.BindTexture(gl.TEXTURE_2D, tex)

  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT)

  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_LINEAR)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)

  width, height, nrChanals: i32

  stbi.set_flip_vertically_on_load(1)
  data := stbi.load(cstring(raw_data(path)), &width, &height, &nrChanals, 0)
  defer stbi.image_free(data)
  if data != nil {
    gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGB, width, height, 0, gl.RGB, gl.UNSIGNED_BYTE, data)
    gl.GenerateMipmap(gl.TEXTURE_2D)
  } else {
    log.error("Can't load texture:", path)
    return 0, .LOAD_TEXTURE_ERR
  }

  return tex, nil
}

load_png :: proc(path: string) -> (u32, load_texture_error) {
  tex: u32
  gl.GenTextures(1, &tex)
  gl.BindTexture(gl.TEXTURE_2D, tex)

  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT)

  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_LINEAR)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)

  width, height, nrChanals: i32

  stbi.set_flip_vertically_on_load(1)
  data := stbi.load(cstring(raw_data(path)), &width, &height, &nrChanals, 0)
  defer stbi.image_free(data)
  if data != nil {
    gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGB, width, height, 0, gl.RGBA, gl.UNSIGNED_BYTE, data)
    gl.GenerateMipmap(gl.TEXTURE_2D)
  } else {
    log.error("Can't load texture:", path)
    return 0, .LOAD_TEXTURE_ERR
  }

  return tex, nil
}
