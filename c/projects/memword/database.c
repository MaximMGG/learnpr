#include "database.h"
#include <string.h>
#include <stdio.h>
#include <stdarg.h>

#define DATABASE_CONNECT_QUARY "dbname=%s user=%s password=%s"

#define DATABASE_CHECK_COLUMS_TYPE_NAME "SELECT column_namb, data_type, character_maximum_length, is_identity, column_default, FROM information_schema.columns WHERE table_schema = 'public' AND table_name = '%s';"
#define DATABASE_CHECK_TABLE_EXISTS "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = '%s';"

str db_postgres_type[] = {
  "smallint",
  "integer",
  "bigint",
  "real",
  "double precision",
  "character varying",
  "boolean",
  "decimal",
  "numeric"
};

str error_str[] = {
  "DATABASE_OK",
  "DATABASE_CONNECT_ERROR",
  "DATABASE_INSERT_ERROR",
  "DATABASE_SELECT_ERROR",
};

Database *databaseConnect(Allocator *allocator, str db_name, str user_name, str password) {
  Database *db = MAKE(allocator, Database);
  byte buf[1024] = {0};
  sprintf(buf, DATABASE_CONNECT_QUARY, db_name, user_name, password);
  db->conn = PQconnectdb(buf);
  if (PQstatus(db->conn) != CONNECTION_OK) {
    DEALLOC(allocator, db);
    fprintf(stderr, "DATABASE: not connect!\n");
    return null;
  }

  db->allocator = allocator;

  db->db_name = strCopy(allocator, db_name);
  db->user_name = strCopy(allocator, user_name);
  db->password = strCopy(allocator, password);

  db->prepared_insert = mapCreate(allocator, STR, STR, null, null);
  db->prepared_select = mapCreate(allocator, STR, STR, null, null);

  db->quary_result = DATABASE_OK;

  return db;
}

void      databaseDisconnect(Database *db) {
  DEALLOC(db->allocator, db->db_name);
  DEALLOC(db->allocator, db->user_name);
  DEALLOC(db->allocator, db->password);


  Iterator *it = mapIterator(db->prepared_insert);
  while(mapItNext(it)) {
    DEALLOC(db->allocator, it->key);
    DEALLOC(db->allocator, it->val);
  }
  mapItDestroy(it);
  mapDestroy(db->prepared_insert);
  it = mapIterator(db->prepared_select);
  while(mapItNext(it)) {
    DEALLOC(db->allocator, it->key);
    DEALLOC(db->allocator, it->val);
  }
  mapItDestroy(it);
  mapDestroy(db->prepared_select);
  DEALLOC(db->allocator, db);
}

//INSERT INTO dictionary(word, translation) VALUES('%s', '%s')

void databaseInsert(Database *db, str quary, ...) {
  va_list li;
  va_start(li, quary);
  byte *quary_buf = ALLOC(db->allocator, 4096);
  memset(quary_buf, 0, 4096);
  vsprintf(quary_buf, quary, li);

  db->res = PQexec(db->conn, quary_buf);
  if (PQresultStatus(db->res) != PGRES_COMMAND_OK) {
    db->quary_result = DATABASE_INSERT_ERROR;
  } else {
    db->quary_result = DATABASE_OK;
  }

  PQclear(db->res);
  va_end(li);
  DEALLOC(db->allocator, quary_buf);
}

QuaryRes databaseSelect(Database *db, str quary) {
  QuaryRes qr;

  db->res = PQexec(db->conn, quary);
  if (PQresultStatus(db->res) != PGRES_TUPLES_OK) {
    db->quary_result = DATABASE_SELECT_ERROR;
    PQclear(db->res);
    return (QuaryRes){};
  } else {
    db->quary_result = DATABASE_OK;
  }

  qr.rows = PQntuples(db->res);
  qr.cols = PQnfields(db->res);
  qr.tuples = MAKE_MANY(db->allocator, str *, qr.rows);

  for(i32 i = 0; i < qr.rows; i++) {
    for(i32 j = 0; j < qr.cols; j++) {
      str res = PQgetvalue(db->res, i, j);
      qr.tuples[i][j] = strCopy(db->allocator, res);
    }
  }
  PQclear(db->res);

  return qr;
}

/*
 * %d %s %lf %f
 *
 *
 *
 *
 */



static i32 g_pos = -1;
static str g_struct_variable = null;
static u32 g_len = 0;

static CORE_TYPES databaseGetNextVal(str struct_variable) {

}

void databaseInsertStruct(Database *db, str table, str struct_variable, ptr val) {

}
QuaryStructRes databaseSelectStruct(Database *db, str talbe, str struct_variable);
QuaryRes databaseExecQuaryWithRes(Database *db, str quary);
void databaseExecQuaryWithoutRes(Database *db, str quary);
str databaseGetError(Database *db);

