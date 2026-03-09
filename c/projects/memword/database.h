#ifndef DATABASE_H
#define DATABASE_H

#include <cstdext/core.h>
#include <cstdext/container/map.h>
#include <libpq-fe.h>

typedef enum {
  DATABASE_OK,
  DATABASE_CONNECT_ERROR,
  DATABASE_INSERT_ERROR,
  DATABASE_SELECT_ERROR,
  DATABASE_INSERT_STRUCT_ERROR,
  DATABASE_SELECT_STRUCT_ERROR,
  DATABASE_EXEC_QUARY_WITH_RES_ERROR,
} DatabaseResult;

typedef struct {
  PGconn *conn;
  PGresult *res;

  str db_name;
  str user_name;
  str password;

  Map *prepared_insert;
  Map *prepared_select;

  DatabaseResult quary_result;
  Allocator *allocator;
} Database;

typedef struct {
  str *tuples;
  i32 rows;
  i32 cols;
} QuaryRes;

typedef struct {
  ptr *tuples;
  i32 rows;
  i32 cols;
} QuaryStructRes;

Database *      databaseConnect(Allocator *allocator, str db_name, str user_name, str password);
void            databaseDisconnect(Database *db);
void            databaseInsert(Database *db, str quary, ...);
str*            databaseSelect(Database *db, str quary);
void            databaseInsertStruct(Database *db, str table, str struct_variable, ptr val);
QuaryStructRes  databaseSelectStruct(Database *db, str talbe, str struct_variable);
QuaryRes        databaseExecQuaryWithRes(Database *db, str quary);
void            databaseExecQuaryWithoutRes(Database *db, str quary);
str             databaseGetError(Database *db);

#endif// DATABASE_H
