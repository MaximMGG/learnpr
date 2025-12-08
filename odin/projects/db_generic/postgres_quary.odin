package postgres_api



import "core:fmt"
import "base:builtin"
import "base:intrinsics"
import "base:runtime"
import "core:testing"


import "core:c"
import "core:os"
import "core:strings"


foreign import DB {
  "system:pq",
}

PGresult :: struct {}
PGconn :: struct {}

CONNECTION_OK : c.int : 0
PGRES_TUPLES_OK : c.int : 2

@(default_calling_convention = "c")
foreign DB {
  PQexec :: proc(conn: ^PGconn, query: cstring) -> ^PGresult ---
  PQconnectdb :: proc(conninfo: cstring) -> ^PGconn ---
  PQstatus :: proc(conn: ^PGconn) -> c.int ---
  PQclear :: proc(res: ^PGresult) ---
  PQfinish :: proc(conn: ^PGconn) ---
  PQresultStatus :: proc(res: ^PGresult) -> c.int ---
  PQntuples :: proc(res: ^PGresult) -> c.int ---
  PQgetvalue :: proc(res: ^PGresult, tup_num: c.int, field_num: c.int) -> cstring ---
  PQerrorMessage :: proc(conn: ^PGconn) -> cstring ---
  PQprepare :: proc(conn: ^PGconn, stmtName: cstring, query: cstring, nParams:
    c.int, paramTypes: rawptr) -> ^PGresult ---
  PQexecParams :: proc(conn: ^PGconn, command: cstring, nParams: c.int,
    paramTypes: rawptr, paramValues: []cstring, paramLength: ^c.int,
    paramFormats: ^c.int, resultFormat: c.int) -> PGresult ---
}

User :: struct {
    name: string,
    age: i32,
    best_fiest: string,
    maney: u64,
    dick_size: f32,
}

read_to_struct :: proc($T: typeid) {
    test_user: T
    field_count := intrinsics.type_struct_field_count(User)
    tv := type_info_of(T).variant.(runtime.Type_Info_Named)
    fmt.println("Type name is: ", tv.name)
    
    struct_type := tv.base.variant.(runtime.Type_Info_Struct)
    fmt.println(struct_type)

    u: T
    sb: strings.Builder
    defer strings.builder_destroy(&sb)
    strings.builder_init(&sb)

    strings.write_string(&sb, "INSERT INFO ")
    strings.write_string(&sb, tv.name)
    strings.write_string(&sb, " (")

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



@(test)
read_to_struct_test :: proc(t: ^testing.T) {
    read_to_struct(User)
}


