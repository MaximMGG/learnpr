package database

import "core:c"

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
}
