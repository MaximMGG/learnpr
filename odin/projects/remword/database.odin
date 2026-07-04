package remword


import "core:c"

foreign import db {
  "system:pq",
}

PGresult :: struct{}
PGconn :: struct{}


ConnStatusType :: enum(c.int) {
	CONNECTION_OK,
	CONNECTION_BAD,
	CONNECTION_STARTED,
	CONNECTION_MADE,
	CONNECTION_AWAITING_RESPONSE,
	CONNECTION_AUTH_OK,
	CONNECTION_SETENV,
	CONNECTION_SSL_STARTUP,
	CONNECTION_NEEDED,
	CONNECTION_CHECK_WRITABLE,
	CONNECTION_CONSUME,
	CONNECTION_GSS_STARTUP,
	CONNECTION_CHECK_TARGET,
	CONNECTION_CHECK_STANDBY,
	CONNECTION_ALLOCATED,
	CONNECTION_AUTHENTICATING
}

ExecStatusType :: enum(c.int) {
	PGRES_EMPTY_QUERY = 0,
	PGRES_COMMAND_OK,
	PGRES_TUPLES_OK,
	PGRES_COPY_OUT,
	PGRES_COPY_IN,
	PGRES_BAD_RESPONSE,
	PGRES_NONFATAL_ERROR,
	PGRES_FATAL_ERROR,
	PGRES_COPY_BOTH,
	PGRES_SINGLE_TUPLE,
	PGRES_PIPELINE_SYNC,
	PGRES_PIPELINE_ABORTED,
	PGRES_TUPLES_CHUNK,
}


@(default_calling_convention="c")
foreign db {
  PQresultStatus    :: proc(res: ^PGresult) -> ExecStatusType ---
  PQntuples         :: proc(res: ^PGresult) -> c.int ---
  PQnfields         :: proc(res: ^PGresult) -> c.int ---
  PQexec            :: proc(conn: ^PGconn, query: cstring) -> ^PGresult ---
  PQconnectdb       :: proc(conninfo: cstring) -> ^PGconn ---
  PQfinish          :: proc(conn: ^PGconn) ---
  PQclear           :: proc(res: ^PGresult) ---
  PQerrorMessage    :: proc(conn: ^PGconn) -> cstring ---
  PQstatus          :: proc(conn: ^PGconn) -> ConnStatusType ---
  PQgetvalue        :: proc(res: ^PGresult, tup_num, field_num: c.int) -> cstring ---
  //TODO(maxim) need to complite
}
