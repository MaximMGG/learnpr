package postgres_api



import "core:fmt"
import "base:builtin"
import "base:intrinsics"
import "base:runtime"
import "core:testing"


import "core:c"
import "core:os"
import "core:strings"
import "core:math/rand"


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
select_query :: proc(t: $T) -> string {
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
    s := select_query(u)
    defer delete(s)
    fmt.println("Select query: ", s)
}

ITERATION :: 1000


main :: proc() {
    fmt.println("Begin")
    #no_bounds_check for i in 0..<ITERATION {
	u: User = {name = "Billy",
		   age = rand.int32_range(0, 99), best_fiest = "Mickle", maney = rand.uint64_range(0, 1_000_000), dick_size = rand.float32_range(3.1, 19.4)}
	/* u: User = {name = "Billy", */
	/* 	   age = 12, best_fiest = "Mickle", maney = 12314, dick_size = 2.1} */
	s := select_query(u)
	defer delete(s)
	fmt.println("Iteration: ", i, "User: ", s)
    }
    fmt.println("End")
}
