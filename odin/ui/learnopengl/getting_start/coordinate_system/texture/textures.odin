package texture

import "core:c"
import "core:fmt"

import stb "vendor:stb/image"
import gl "vendor:OpenGL"

createTexture :: proc(path: string) -> (u32 , bool){
  texture: u32
  gl.GenTextures(1, &texture)
  //set the texture wrapping parameters
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT)
  // set texture filtering parameters
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR)
  gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)
  //load image, create texture and generate mipmaps

  width, height, nrChanels: c.int
  stb.set_flip_vertically_on_load(c.int(true))
  data := stb.load(cstring(raw_data(path)), &width, &height, &nrChanels, 0)
  defer stb.image_free(data)

  if data != nil {
    gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGB, i32(width), i32(height), 0, gl.RGB, gl.UNSIGNED_BYTE, data)
    gl.GenerateMipmap(gl.TEXTURE_2D)
  } else {
    fmt.eprintln("Can't load texture", path)
    return 0, false
  }

  return texture, true
}


