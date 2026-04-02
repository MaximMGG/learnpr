package util

import gl "vendor:OpenGL"
import stb "vendor:stb/image"
import "core:c"
import "core:fmt"

Texture :: u32

textureCreate :: proc(path: string) -> Texture {
  texture: Texture
  //gl.CreateTextures(gl.TEXTURE_2D, 1, &texture)
  gl.GenTextures(1, &texture)
  gl.BindTexture(gl.TEXTURE_2D, texture)

  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT)

  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)

  stb.set_flip_vertically_on_load(c.int(1))
  width, height, nrChannels: i32
  data := stb.load(cstring(raw_data(path)), &width, &height, &nrChannels, 0)
  if data != nil {
    format: i32 = nrChannels == 4 ? gl.RGBA : gl.RGB
    gl.TexImage2D(gl.TEXTURE_2D, 0, format, width, height, 0, u32(format), gl.UNSIGNED_BYTE, data)
    gl.GenerateMipmap(gl.TEXTURE_2D)
  } else {
    fmt.eprintln("Error stb.load")
    return 0
  }
  stb.image_free(data)

  return texture
}

textureBind :: proc(tex: Texture) {
  gl.BindTexture(gl.TEXTURE_2D, tex)
}

textureDestroy :: proc(tex: Texture) {
  tex := tex
  gl.DeleteTextures(1, &tex)
}

