#ifndef DATABASE_H
#define DATABASE_H

#include <cstdext/core.h>
#include <cstdext/container/map.h>
#include <libpq-fe.h>


#define DB_POSTGRES_SMALLINT 0 // 2 bytes "smallint"
#define DB_POSTGRES_INT 1 // 4 bytes "int/integer"
#define DB_POSTGRES_BIGINT 2 // 8 bytes "bigint"
#define DB_POSTGRES_REAL 3 // 4 bytes float "real"
#define DB_POSTGRES_VARCHAR 4 // variable-length string with limin "varchar(n)" "character varying"
                        
#define DB_POSTGRES_BOOLEAN 5 // "boolean"
#define DB_POSTGRES_DECIMAL 6 // numeric with precision/scale "decimal"
#define DB_POSTGRES_NUMERIC 7 // same as decimal "numeric"


typedef enum {
  DATABASE_OK,
  DATABASE_CONNECT_ERROR,
  DATABASE_INSERT_ERROR,
  DATABASE_SELECT_ERROR,
  DATABASE_INSERT_STRUCT_ERROR,
  DATABASE_SELECT_STRUCT_ERROR,
  DATABASE_EXEC_QUARY_WITH_RES_ERROR,
  DATABASE_EXEC_QUARY_WITHOUT_RES_ERROR,
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
  str **tuples;
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
QuaryRes        databaseSelect(Database *db, str quary);
void            databaseInsertStruct(Database *db, str table, ptr val);
QuaryStructRes  databaseSelectStruct(Database *db, str table, str quary);
QuaryRes        databaseExecQuaryWithRes(Database *db, str quary);
void            databaseExecQuaryWithoutRes(Database *db, str quary);
str             databaseGetError(Database *db);
void            databaseClearQuaryRes(Allocator *allocator, QuaryRes *qr);

#endif// DATABASE_H
