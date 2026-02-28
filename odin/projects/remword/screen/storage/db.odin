package storage

import "core:c"
import "core:fmt"

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
}

DB_CONNECT_FORMAT :: "dbname=%s name=%s password=%s"
DB_CHECK_MODULE_TABLE_EXISTS : cstring : "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'module'"
DB_CHECK_DICTIONARY_TABLE_EXISTS : cstring : "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'dictionary'"
DB_CREATE_MODULE_TABLE : cstring : "CREATE TABLE module (id SIREAL)"

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
