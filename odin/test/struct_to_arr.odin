package struct_to_arr

import "core:fmt"
import "core:slice"
import "base:runtime"

FMT :: "%s %d %f"


Test :: struct {
  a: string,
  b: int,
  c: f32
}

print_struct :: proc(t: $T) {
  t := t
  tio := type_info_of(T).variant.(runtime.Type_Info_Named)
  ti := tio.base.variant.(runtime.Type_Info_Struct)
  args := make([]any, ti.field_count)
  defer delete(args)

  base := uintptr(&t)
  for i in 0..<ti.field_count {
    switch(ti.types[i].id) {
    case string:
      args[i] = ((^string)(base + uintptr(ti.offsets[i])))^
    case int:
      args[i] = ((^int)(base + uintptr(ti.offsets[i])))^
    case f32:
      args[i] = ((^f32)(base + uintptr(ti.offsets[i])))^
    }
  }

  tmp := fmt.aprintf(FMT, ..args)
  defer delete(tmp)

  fmt.printf("%s\n", tmp)
}

main :: proc() {

  a := Test{a = "Hello", b = 123, c = 3.3}
  print_struct(a)
  
}
