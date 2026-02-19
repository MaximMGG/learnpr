package util

import gl "vendor:OpenGL"

VertexElement :: u32

vertexElementCreate :: proc(p: rawptr, size: i32) -> VertexBuffer {
  vb: VertexBuffer
  gl.CreateBuffers(1, &vb)
  gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, vb)
  gl.BufferData(gl.ELEMENT_ARRAY_BUFFER, int(size), p, gl.STATIC_DRAW)

  return vb
}

vertexElementDestroy :: proc(vb: ^VertexBuffer) {
  gl.DeleteBuffers(1, vb)
}

vertexElementBind :: proc(vb: VertexBuffer) {
  gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, vb)
}

vertexElementUnbind :: proc(vb: VertexBuffer) {
  gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, 0)
}


