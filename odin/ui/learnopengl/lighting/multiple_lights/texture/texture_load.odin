package texture

import gl "vendor:OpenGL"
import stb "vendor:stb/image"
import "core:log"

Texture_Error :: enum {
  TEXTURE_OK,
  LOAD_TEX_ERROR
}


Texture :: struct {
  id: u32
}


load :: proc(path: string) -> (Texture, Texture_Error) {
  t: Texture
  gl.GenTextures(1, &t.id)
  gl.BindTexture(gl.TEXTURE_2D, t.id)

  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_LINEAR)

  width, height, nrChannels: i32

  stb.set_flip_vertically_on_load(1)

  data := stb.load(cstring(raw_data(path)),  &width, &height, &nrChannels, 0)
  if data != nil {
    format: u32
    if nrChannels == 1 {
      format = gl.RED
    } else if nrChannels == 3 {
      format = gl.RGB
    } else if nrChannels == 4 {
      format = gl.RGBA
    }

    gl.TexImage2D(gl.TEXTURE_2D, 0, i32(format), width, height, 0, format, gl.UNSIGNED_BYTE, data)
    gl.GenerateMipmap(gl.TEXTURE_2D)
    
  } else {
    log.error("Error stb.load with texture:", path)
    gl.DeleteTextures(1, &t.id)
    t.id = 0
    return t, .LOAD_TEX_ERROR
  }

  stb.image_free(data)

  return t, nil
}

destroy :: proc(t: ^Texture) {
  gl.DeleteTextures(1, &t.id)
}

