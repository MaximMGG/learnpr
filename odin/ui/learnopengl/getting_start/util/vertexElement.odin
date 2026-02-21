package util

import gl "vendor:OpenGL"

VertexElement :: u32

vertexElementCreate :: proc(p: rawptr, size: i32) -> VertexElement {
  ve: VertexElement
  gl.GenBuffers(1, &ve)
  gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, ve)
  gl.BufferData(gl.ELEMENT_ARRAY_BUFFER, int(size), p, gl.STATIC_DRAW)

  return ve
}

vertexElementDestroy :: proc(ve: ^VertexElement) {
  gl.DeleteBuffers(1, ve)
}

vertexElementBind :: proc(ve: VertexElement) {
  gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, ve)
}

vertexElementUnbind :: proc() {
  gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, 0)
}


