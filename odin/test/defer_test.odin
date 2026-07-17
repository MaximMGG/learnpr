package defer_test


import "core:fmt"


Dog :: struct {
  name: string,
  age: int,
  buf: []byte
}

@(deferred_out=destroy_dog)
create_dog :: proc(name: string, age: int) -> ^Dog {
  d := new(Dog)
  d.name = name
  d.age = age
  d.buf = make([]byte, 512)
  return d
}

destroy_dog :: proc(d: ^Dog) {
  delete(d.buf)
  free(d)
  fmt.println("Dog destroed")
}

main :: proc() {
  d := create_dog("Bobby", 12)
}
