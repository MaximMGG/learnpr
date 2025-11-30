#ifndef DATABASE_H
#define DATABASE_H
#include <libpq-fe.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include "token.h"

typedef struct {
  str database_name;
  PGconn *conn;
  PGresult *res;
} Database;

Database *databaseConnect(str database_name);
void databaseInsertToken(Database *db, Token *t);
void databaseDestroy(Database *db);

#endif //DATABASE_H
