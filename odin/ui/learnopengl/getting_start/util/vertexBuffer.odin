package util

import gl "vendor:OpenGL"

VertexBuffer :: u32


vertexBufferCreate :: proc(p: rawptr, size: i32) -> VertexBuffer {
  vb: VertexBuffer
  gl.CreateBuffers(1, &vb)
  gl.BindBuffer(gl.ARRAY_BUFFER, vb)
  gl.BufferData(gl.ARRAY_BUFFER, int(size), p, gl.STATIC_DRAW)

  return vb
}

vertexBufferDestroy :: proc(vb: ^VertexBuffer) {
  gl.DeleteBuffers(1, vb)
}

vertexBufferBind :: proc(vb: VertexBuffer) {
  gl.BindBuffer(gl.ARRAY_BUFFER, vb)
}

vertexBufferUnbind :: proc(vb: VertexBuffer) {
  gl.BindBuffer(gl.ARRAY_BUFFER, 0)
}



