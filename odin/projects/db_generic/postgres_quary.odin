package postgres_api

import "core:fmt"
import "base:intrinsics"
import "base:runtime"
import "core:testing"
import "core:math/rand"

import vm "core:mem/virtual"


import "core:c"
import "core:strings"


User :: struct {
    name: string,
    age: i32,
    best_fiest: string,
    maney: u64,
    dick_size: f32,
}

insert_query :: proc(t: $T) -> string {
    
  //TODO(maxim) its for tests, on the future need do with pointers
  if intrinsics.type_is_pointer(T) {
    fmt.eprintln("No pointers, only struct")
    return ""
  }
  tmp := t
  ti := type_info_of(T).variant.(runtime.Type_Info_Named)
  ts := ti.base.variant.(runtime.Type_Info_Struct)
  sb := new(strings.Builder)
  defer free(sb)
  strings.builder_init(sb)
  defer strings.builder_destroy(sb)

  strings.write_string(sb, "INSERT INTO ")
  strings.write_string(sb, ti.name)
  strings.write_string(sb, " (")

  #no_bounds_check for i in 0..<ts.field_count {
    strings.write_string(sb, ts.names[i])
    if i != ts.field_count - 1 {
      strings.write_string(sb, ", ")
    } else {
      strings.write_string(sb, ") ")
    }
  }

  strings.write_string(sb, " VALUES(")
  base := uintptr(&tmp)
  #no_bounds_check for i in 0..<ts.field_count {
    switch ts.types[i].id {
    case i32:
      p: ^i32 = cast(^i32)(base + ts.offsets[i])
      strings.write_int(sb, int(p^))
    case string:
      p: ^string = cast(^string)(base + ts.offsets[i])
      strings.write_quoted_string(sb, p^, '\'')
    case u64:
      p: ^u64 = cast(^u64)(base + ts.offsets[i])
      strings.write_u64(sb, p^)
    case f32:
      p: ^f32 = cast(^f32)(base + ts.offsets[i])
      strings.write_f32(sb, p^, 'f')
    }
    if i != ts.field_count - 1 {
      strings.write_string(sb, ", ")
    }
  }
  strings.write_string(sb, ")")
  res := strings.clone_from_bytes(sb.buf[0:strings.builder_len(sb^)])
  return res
}

read_to_struct :: proc($T: typeid) {
  test_user: T
  field_count := intrinsics.type_struct_field_count(User)
  tv := type_info_of(T).variant.(runtime.Type_Info_Named)
  fmt.println("Type name is: ", tv.name)

  struct_type := tv.base.variant.(runtime.Type_Info_Struct)
  fmt.println(struct_type)

  u: T

  base: uintptr = uintptr(&u)
  for i in 0..<struct_type.field_count {
    switch struct_type.types[i].id {
    case i32:
      p: ^i32 = cast(^i32)(base + struct_type.offsets[i])
      p^ = 123
    case string:
      p: ^string = cast(^string)(base + struct_type.offsets[i])
      p^ = "Hello:)"
    case u64:
      p: ^u64 = cast(^u64)(base + struct_type.offsets[i])
      p^ = 333
    case f32:
      p: ^f32 = cast(^f32)(base + struct_type.offsets[i])
      p^ = 11.3
    }
  }

  fmt.println(u)
}
    /* name: string, */
    /* age: i32, */
    /* best_fiest: string, */
    /* maney: u64, */
    /* dick_size: f32, */


@(test)
read_to_struct_test :: proc(t: ^testing.T) {
  read_to_struct(User)
  u: User = {name = "Billy", age = 33, best_fiest = "Mickle", maney = 111, dick_size = 7}
  s := insert_query(u)
  defer delete(s)
  fmt.println("Select query: ", s)
}

ITERATION :: 100
names :: struct {
    id: int,
    name: string,
}

main :: proc() {
  db := engine_connect("mydb", "maxim", "maxim")
  defer engine_destroy(db)

  // for i in 0..<ITERATION {
  //   n := names{id = rand.int_range(0, ITERATION), name = "Bobby"}
  //   engine_insert_struct(db, n, "")
  // }
    arena: vm.Arena
    arene_err := vm.arena_init_growing(&arena, 24)
    arena_alloc := vm.arena_allocator(&arena)
    context.allocator = arena_alloc
    defer vm.arena_destroy(&arena)
    

  n2 := engine_select_struct(db, names)
  defer delete(n2)
  for i in n2 {
    fmt.println(i)
  }
  fmt.println("Total structs: ", len(n2))
}


