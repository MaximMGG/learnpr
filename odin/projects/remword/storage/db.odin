package storage

import "core:c"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:mem"
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
  PQnfields :: proc(res: ^PGresult) -> c.int ---
}

DatabaseError :: enum {
  CONNECTION_ERROR,
  INSERT_STRUCT_ERROR,
  SELECT_STRUCT_ERROR,
  EXEC_QUARY_WITH_RESULT_ERROR,
  EXEC_QUARY_WITHOUT_RESULT_ERROR,
}

Database :: struct {
  conn: ^PGconn,
  res: ^PGresult,
  db_name: string,
  name: string,
  password: string,
  prepared_insert_struct: map[string]string,
  prepared_select_struct: map[string]string,

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
  if database.res != nil {
    PQclear(database.res)
  }
  PQfinish(database.conn)

  for _, v in database.prepared_select_struct {
    delete(v)
  }
  for _, v in database.prepared_insert_struct {
    delete(v)
  }

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
      strings.write_string(&values, "'%s'")
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

insert_struct :: proc(database: ^Database, table: string, t: $T) -> DatabaseError {
  quary := database.prepared_insert_struct[table]
  if quary == nil {
    quary = insert_struct_prepare_quary(t)
    database.prepared_insert_struct[table] = quary
  }
  tio := type_info_of(T).variant.(runtime.Type_Info_Named)
  ti := tio.base.variant.(runtime.Type_Info_Struct)

  args := make([]any, ti.field_count)
  defer delete(args)
  t := t
  base := uintptr(&t)

  for i in 0..<ti.field_count {
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
      args[i] = ((^int)(base + ti.offsets[i]))^
    case f32:
      fallthrough
    case f64:
      args[i] = ((^f64)(base + ti.offsets[i]))^
    case cstring:
      fallthrough
    case string:
      args[i] ((^string)(base + ti.offsets[i]))^
    }
  }
  buf := fmt.aprintf(quary, ..args)
  defer delete(buf)

  database.res = PQexec(database.conn, cstring(raw_ptr(buf)))
  if PQresultStatus(database.res) != PGRES_COMMAND_OK {
    return .INSERT_STRUCT_ERROR
  }
  PQclear(database.res)
  return nil
}

select_struct_prepare_quary :: proc(table: string, t: $T) -> string {
  tmp := "SELECT * FROM %s;"
  quary := fmt.aprintf(tmp, table)
  return quary
}

select_struct :: proc(database: ^Database, table: string, t: $T) -> ([]T, DatabaseError) {
  quary := database.prepared_select_struct[table]
  if quary == nil {
    quary = select_struct_prepare_quary(table, t)
    database.prepared_select_struct[table] = quary
  }

  database.res = PQexec(database.conn, cstring(raw_data(quary)))
  if PQresultStatus(database.res) != PGRES_TUPLES_OK {
    PQclear(database.res)
    return []T{}, .SELECT_STRUCT_ERROR
  }
  
  tio := type_info_of(T).variant.(runtime.Type_Info_Named)
  ti := tio.base.variant.(runtime.Type_Info_Struct)

  rows := PQntuples(database.res)
  lines := PQnfields(database.res)


  res := make([]T, rows)

  for i in 0..<rows {
    tmp := res[i]
    base = &tmp
    for j in 0..<lines {
      switch(ti.types[j]) {
      case i8, u8:
        str_val := strings.clone_from_cstring(PQgetvalue(database.res, i, j))
        defer delete(str_val)
        val, _ := u8(strconv.parse_int(str_val, 10))
        mem.copy(base + uintptr(ti.offsets[j]), &val, size_of(u8))
      case i16, u16:
        str_val := strings.clone_from_cstring(PQgetvalue(database.res, i, j))
        defer delete(str_val)
        val, _ := u16(strconv.parse_int(str_val, 10))
        mem.copy(base + uintptr(ti.offsets[j]), &val, size_of(i16))
      case i32, u32:
        str_val := strings.clone_from_cstring(PQgetvalue(database.res, i, j))
        defer delete(str_val)
        val, _ := u32(strconv.parse_int(str_val, 10))
        mem.copy(base + uintptr(ti.offsets[j]), &val, size_of(i32))
      case i64, u64:
        str_val := strings.clone_from_cstring(PQgetvalue(database.res, i, j))
        defer delete(str_val)
        val, _ := u64(strconv.parse_int(str_val, 10))
        mem.copy(base + uintptr(ti.offsets[j]), &val, size_of(i64))
      case int:
        str_val := strings.clone_from_cstring(PQgetvalue(database.res, i, j))
        defer delete(str_val)
        val, _ := int(strconv.parse_int(str_val, 10))
        mem.copy(base + uintptr(ti.offsets[j]), &val, size_of(int))
      case f32:
        str_val := strings.clone_from_cstring(PQgetvalue(database.res, i, j))
        defer delete(str_val)
        val, _ := f32(strconv.parse_f32(str_val))
        mem.copy(base + uintptr(ti.offsets[j]), &val, size_of(f32))
      case f64:
        str_val := strings.clone_from_cstring(PQgetvalue(database.res, i, j))
        defer delete(str_val)
        val, _ := f64(strconv.parse_f64(str_val))
        mem.copy(base + uintptr(ti.offsets[j]), &val, size_of(f64))
      case cstring:
      }
    }
  }
}

select_struct_quary :: proc(databse: ^Database, quary: string, table: string, t: $T) -> ([]T, DatabaseError) {

}

exec_quary_with_result :: proc(database: ^Database, quary: string) -> ([][]string, DatabaseError ){
  database.res = PQexec(database.conn, cstring(raw_data(quary)))
  if PQresultStatus(database.res) != PGRES_TUPLES_OK {
    PQclear(database.res)
    return [][]string{}, .EXEC_QUARY_WITH_RESULT_ERROR
  }

  raws := PQntuples(database.res)
  lines := PQnfields(database.res)

  result := make([][]string, raws)

  for i in 0..<raws {
    for j in 0..<lines {
      s := PQgetvalue(database.res, i, j)
      result[i][j] = strings.clone_from_cstring(s)
    }
  }

  PQclear(database.res)
  return result, nil
}

exec_quary_without_result :: proc(database: ^Database, quary: string) -> (DatabaseError) {
  database.res = PQexec(database.conn, cstring(raw_data(quary)))
  if PQresultStatus(database.res) != PGRES_TUPLES_OK {
    return .EXEC_QUARY_WITHOUT_RESULT_ERROR
  }
  PQclear(database.res)
  return nil
}

clear_result :: proc(res: [][]string) {
  for i in res {
    for j in i {
      delete(j)
    }
  }
  delete(res)
}


test_struct :: struct {
  a: int,
  name: string,
  b: f32,
  c: f64
}


