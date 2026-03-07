package storage

import "core:c"
import "core:fmt"
import "core:strings"
import "base:runtime"
import "core:testing"

foreign import DB "system:pq"

PGconn :: struct{}
PGresult :: struct{}

CONNECTION_OK: c.int : 0
PGRES_TUPLES_OK: c.int : 2
PGRES_COMMAND_OK: c.int : 1




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
	PQprepare :: proc(conn: ^PGconn, stmtName: cstring, query: cstring, nParams: c.int, paramTypes: rawptr) -> ^PGresult ---
	PQexecParams :: proc(conn: ^PGconn, command: cstring, nParams: c.int, paramTypes: rawptr, paramValues: []cstring, paramLength: ^c.int, paramFormats: ^c.int, resultFormat: c.int) -> PGresult ---
}

DatabaseError :: enum {
  CONNECTION_ERROR,
}

Database :: struct {
  conn: ^PGconn,
  res: ^PGresult,
  db_name: string,
  name: string,
  password: string,
  prepared_insert_struct: map[string]string
}


DB_CONNECT_FORMAT :: "dbname=%s name=%s password=%s"

connect :: proc(db_name: string, user_name: string, password: string) -> (Database, DatabaseError) {
  db: Database = {db_name = db_name, name = user_name, password = password}
  conn_str := fmt.aprintf(DB_CONNECT_FORMAT, db_name, user_name, password)
  defer delete(conn_str)

  db.conn = PQconnectdb(cstring(raw_data(conn_str)))
  if PQstatus(db.conn) != CONNECTION_OK {
    fmt.eprintln("PQconnectdb with conn_str:", conn_str, "failed")
    return Database{}, .CONNECTION_ERROR
  }

  return db, nil
}

disconnect :: proc(database: ^Database) {
  PQfinish(database.conn)
}



@(private)
insert_struct_prepare_quary :: proc(t: $T, table: string) -> string {
  sb: strings.Builder
  strings.builder_init(&sb)
  defer strings.builder_destroy(&sb)

  values: strings.Builder
  strings.builder_init(&values)
  defer strings.builder_destroy(&values)
  strings.write_string(&values, "VALUES (")

  strings.write_string(&sb, "INSERT INTO ")
  strings.write_string(&sb, table)
  strings.write_string(&sb, " (")
  tio := type_info_of(T).variant.(runtime.Type_Info_Named)
  ti := tio.base.variant.(runtime.Type_Info_Struct)
  for i in 0..<ti.field_count {
    strings.write_string(&sb, ti.names[i])

    switch(ti.types[i].id) {
    case i8:
      fallthrough
    case u8:
      fallthrough
    case i16:
      fallthrough
    case u16:
      fallthrough
    case i32:
      fallthrough
    case u32:
      fallthrough
    case i64:
      fallthrough
    case u64:
      fallthrough
    case int:
      strings.write_string(&values, "%d")
    case f32:
      fallthrough
    case f64:
      strings.write_string(&values, "%f")
    case cstring:
      fallthrough
    case string:
      strings.write_string(&values, "%s")
    }

    if i == ti.field_count - 1 {
      strings.write_string(&sb, ") ")
      strings.write_string(&values, ")")
    } else {
      strings.write_string(&sb, ", ")
      strings.write_string(&values, ", ")
    }
  }
  strings.write_string(&sb, strings.to_string(values))
  res := strings.clone(strings.to_string(sb))
  return res
}

insert_struct :: proc(database: ^Database, table: string, t: $T, val: T) -> DatabaseError {
  quary := database.prepared_insert_struct[table]
  if quary == nil {
    quary = insert_struct_prepare_quary(t)
    database.prepared_insert_struct[table] = quary
  }

}

select_struct :: proc(database: ^Database, table: string, t: $T) -> []T {

}

test_struct :: struct {
  a: int,
  name: string,
  b: f32,
  c: f64
}

main :: proc() {
  t := test_struct{a = 333, name = "Hello", b = 1.1, c = 3.8}
  res := insert_struct_prepare_quary(t, "_TABLE_")
  defer delete(res)
  fmt.eprintln(res)
}

