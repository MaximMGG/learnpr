#include "database.h"

#define DB_CONNECTION_FMT "dbname=%s sslmode=disable"
#define DB_TOKENS_INSERT "tokens_insert"

#define DB_TOKENS_INSERT_QUARY \
  "INSERT INTO tokens (symbol, priceChange, priceChangePercent,"          \
  "weightedAvgPrice, openPrice, highPrice, lowPrice, volume, quoteVolume,"\
  "openTime, closeTime, firstId, count) VALUES ($1, $2, $3, $4, $5, $6,"  \
  "$7, $8, $9, $10, $11, $12, $13, $14, $15)"



Database *databaseCreate(str database_name) {
  Database *db = make(Database);
  db->database_name = str_copy(database_name);
  str conn_str = str_create_fmt(DB_CONNECTION_FMT, database_name);

  db->conn = PQconnectdb(conn_str);
  dealloc(conn_str);
  if (PQstatus(db->conn) != CONNECTION_OK) {
    log(ERROR, "PQconnectdb error");
    return null;
  }

  db->res = PQprepare(db->conn, DB_TOKENS_INSERT, DB_TOKENS_INSERT_QUARY, 15, null);
  if (PQresultStatus(db->res) != PGRES_COMMAND_OK) {
    log(ERROR, "PQprepare error: %s", PQerrorMessage(db->conn));
    return null;
  }

  return db;
}

void databaseInsertToken(Database *db, Token *t) {

  PQexecPrepared(db->conn, DB_TOKENS_INSERT, 15, null, null, null, 0);

}

void databaseDestroy(Database *db) {
  PQfinish(db->conn);
}
