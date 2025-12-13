package postgres_api

import "core:fmt"
import "base:intrinsics"
import "base:runtime"
import "core:testing"
import "core:math/rand"

import vm "core:mem/virtual"

import "core:strings"

ITERATION :: 100


names :: struct {
    id: int,
    name: string,
}



@(test)
insert_into_names :: proc(t: ^testing.T) {
  db := engine_connect("mydb", "maxim", "maxim")
  defer engine_destroy(db)

  for i in 0..<ITERATION {
    n := names{id = rand.int_range(0, 256), name = "Mickle"}
    engine_insert_struct(db, n)
  }
}

main :: proc() {
  db := engine_connect("mydb", "maxim", "maxim")
  defer engine_destroy(db)

  for i in 0..<ITERATION {
    n := names{id = rand.int_range(0, 256), name = "Mickle"}
    engine_insert_struct(db, n)
  }
  fmt.println("Done")
}
