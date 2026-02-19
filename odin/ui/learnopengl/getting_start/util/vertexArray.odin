package util

import gl "vendor:OpenGL"

VertexArray :: struct {
  id: u32,
  elements: [dynamic]Element,
  stride: i32
}

Element :: struct {
  count: i32,
  size: i32
}

vertexArrayCreate :: proc() -> VertexArray{
  VAO: VertexArray
  gl.CreateVertexArrays(1, &VAO.id)
  gl.BindVertexArray(VAO.id)
  return VAO
}

vertexArrayDestroy :: proc(va: ^VertexArray) {
  gl.DeleteVertexArrays(1, &va.id)
}

vertexArrayAddf32 :: proc(va: ^VertexArray, count: i32) {
  e: Element = {count = count, size = size_of(f32) * count}
  append(&va.elements, e)
  va.stride += e.size
}

vertexArrayProcess :: proc(va: ^VertexArray) {
  offset: i32
  for e, i in va.elements {
    gl.VertexAttribPointer(u32(i), e.count, gl.FLOAT, gl.FALSE, va.stride, uintptr(offset))
    gl.EnableVertexAttribArray(u32(i))
    offset += e.size
  }
}
