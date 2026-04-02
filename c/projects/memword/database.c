#include "database.h"
#include <string.h>
#include <stdio.h>
#include <stdarg.h>

#define DATABASE_CONNECT_QUARY "dbname=%s user=%s password=%s"

#define DATABASE_CHECK_COLUMS_TYPE_NAME "SELECT column_name, data_type, character_maximum_length, is_identity, column_default, FROM information_schema.columns WHERE table_schema = 'public' AND table_name = '%s';"
#define DATABASE_CHECK_TABLE_EXISTS "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = '%s';"

#define DB_POSTGRES_TYPE_LEN 9 
#define DB_POSTGRES_TYPE_NONE 983472938
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

str database_error_str[] = {
  "DATABASE_OK",
  "DATABASE_CONNECT_ERROR",
  "DATABASE_INSERT_ERROR",
  "DATABASE_SELECT_ERROR",
  "DATABASE_EXEC_QUARY_WITH_RES_ERROR",
  "DATABASE_EXEC_QUARY_WITHOUT_RES_ERROR",
};

Database *databaseConnect(str db_name, str user_name, str password) {
  Database *db = make(Database);
  byte buf[1024] = {0};
  sprintf(buf, DATABASE_CONNECT_QUARY, db_name, user_name, password);
  db->conn = PQconnectdb(buf);
  if (PQstatus(db->conn) != CONNECTION_OK) {
    dealloc(db);
    fprintf(stderr, "DATABASE: not connect!\n");
    return null;
  }


  db->db_name = strCopy(db_name);
  db->user_name = strCopy(user_name);
  db->password = strCopy(password);

  db->prepared_insert = mapCreate(STR, STR, null, null);

  db->prepared_select = mapCreate(STR, STR, null, null);
  db->quary_result = DATABASE_OK;

  return db;
}

void databaseDisconnect(Database *db) {
  dealloc(db->db_name);
  dealloc(db->user_name);
  dealloc(db->password);


  Iterator *it = mapIterator(db->prepared_insert);
  while(mapItNext(it)) {
    dealloc(it->key);
    dealloc(it->val);
  }
  mapItDestroy(it);
  mapDestroy(db->prepared_insert);
  it = mapIterator(db->prepared_select);
  while(mapItNext(it)) {
    dealloc(it->key);
    dealloc(it->val);
  }
  mapItDestroy(it);
  mapDestroy(db->prepared_select);
  dealloc(db);
}

//INSERT INTO dictionary(word, translation) VALUES('%s', '%s')

void databaseInsert(Database *db, str quary, ...) {
  va_list li;
  va_start(li, quary);
  byte *quary_buf = alloc(4096);
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
  dealloc(quary_buf);
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
  qr.tuples = make_many(str *, qr.rows);

  for(i32 i = 0; i < qr.rows; i++) {
    for(i32 j = 0; j < qr.cols; j++) {
      str res = PQgetvalue(db->res, i, j);
      qr.tuples[i][j] = strCopy(res);
    }
  }
  PQclear(db->res);

  return qr;
}

static u32 databaseGetDataType(str type) {
  for(u32 i = 0; i < DB_POSTGRES_TYPE_LEN; i++) {
    if (strcmp(db_postgres_type[i], type) == 0) {
      return i;
    }
  }
  return DB_POSTGRES_TYPE_NONE;
}



QuaryRes databaseExecQuaryWithRes(Database *db, str quary) {
  db->res = PQexec(db->conn, quary);
  if (PQresultStatus(db->res) != PGRES_TUPLES_OK) {
    db->quary_result = DATABASE_EXEC_QUARY_WITH_RES_ERROR;
    PQclear(db->res);
    return (QuaryRes){};
  }
  db->quary_result = DATABASE_OK;

  QuaryRes res;
  res.rows = PQntuples(db->res);
  res.cols = PQnfields(db->res);

  res.tuples = make_many(str *, res.rows);

  for(i32 i = 0; i < res.rows; i++) {
    for(i32 j = 0; j < res.cols; j++) {
      str val = PQgetvalue(db->res, i, j);
      res.tuples[i][j] = strCopy(val);
    }
  }

  PQclear(db->res);
  return res;
}

void databaseExecQuaryWithoutRes(Database *db, str quary) {
  db->res = PQexec(db->conn, quary);
  if (PQresultStatus(db->res) != PGRES_COMMAND_OK) {
    db->quary_result = DATABASE_EXEC_QUARY_WITHOUT_RES_ERROR;
    PQclear(db->res);
  }
  db->quary_result = DATABASE_OK;
  PQclear(db->res);
}

str databaseGetError(Database *db) {
  return database_error_str[db->quary_result];
}

void databaseClearQuaryRes(QuaryRes *qr) {
  for(i32 i = 0 ; i < qr->rows; i++) {
    for(i32 j = 0; j < qr->cols; j++) {
      dealloc(qr->tuples[i][j]);
    }
  }
  dealloc(qr->tuples);
}
