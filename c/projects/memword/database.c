#include "database.h"
#include <string.h>
#include <stdio.h>

#define DATABASE_CONNECT_QUARY "dbname=%s user=%s password=%s"

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

void databaseInsert(Database *db, str quary, ...) {

}

str* databaseSelect(Database *db, str quary);
void databaseInsertStruct(Database *db, str table, str struct_variable, ptr val);
QuaryStructRes databaseSelectStruct(Database *db, str talbe, str struct_variable);
QuaryRes databaseExecQuaryWithRes(Database *db, str quary);
void databaseExecQuaryWithoutRes(Database *db, str quary);
str databaseGetError(Database *db);

