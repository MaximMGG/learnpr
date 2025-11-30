#include "database.h"
#define DB_CONNECTION_FMT "dbname=%s sslmode=disable"
#define DB_TOKENS_INSERT "tokens_insert"

#define DB_TOKENS_INSERT_QUARY \
  "INSERT INTO tokens (symbol, priceChange, priceChangePercent,"          \
  "weightedAvgPrice, openPrice, highPrice, lowPrice, volume, quoteVolume,"\
  "openTime, closeTime, firstId, count) VALUES ($1, $2, $3, $4, $5, $6,"  \
  "$7, $8, $9, $10, $11, $12, $13, $14, $15)"


const str create_table_quary = "CREATE TABLE token ("
          "symbol INT,"
          "priceChange NUMERIC,"
          "priceChangePercent NUMERIC,"
          "weightedAvgPrice NUMERIC,"
          "openPrice NUMERIC,"
          "highPrice NUMERIC,"
          "lowPrice NUMERIC,"
          "lastPrice NUMERIC,"
          "volume NUMERIC,"
          "quoteVolume NUMERIC,"
          "openTime INT,"
          "closeTime INT,"
          "firstId INT,"
          "lastId INT,"
          "count INT)";

const str check_exist_quary = "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'tokens'";


static void databaseCreateTable(Database *db) {
  log(INFO, "Start creaing table tokens");

  db->res = PQexec(db->conn, create_table_quary);
  if (PQresultStatus(db->res) != PGRES_COMMAND_OK) {
    log(ERROR, "Creation of table tokens error: %s", PQerrorMessage(db->conn));
    PQclear(db->res);
    return;
  }
  PQclear(db->res);
  log(INFO, "Creating table done");
}

static void databaseCheckTableExists(Database *db) {
  db->res = PQexec(db->conn, check_exist_quary);

  if (PQresultStatus(db->res) != PGRES_TUPLES_OK) {
    fprintf(stderr, "%s error: %s\n", check_exist_quary, PQerrorMessage(db->conn));
    log(ERROR, "%s error", check_exist_quary);
    return;
  }
  PQclear(db->res);
  if (strcmp("1", PQgetvalue(db->res, 0, 0)) != 0) {
    databaseCreateTable(db);
  } else {
    log(INFO, "Data base exists");    
  }
}

Database *databaseConnect(str database_name) {
  log(INFO, "databaseCreate begining");
  Database *db = make(Database);
  db->database_name = str_copy(database_name);
  str conn_str = str_create_fmt(DB_CONNECTION_FMT, database_name);

  db->conn = PQconnectdb(conn_str);
  dealloc(conn_str);
  if (PQstatus(db->conn) != CONNECTION_OK) {
    log(ERROR, "PQconnectdb error");
    return null;
  }
  databaseCheckTableExists(db);

  db->res = PQprepare(db->conn, DB_TOKENS_INSERT, DB_TOKENS_INSERT_QUARY, 15, null);
  if (PQresultStatus(db->res) != PGRES_COMMAND_OK) {
    log(ERROR, "PQprepare error: %s", PQerrorMessage(db->conn));
    return null;
  }

  log(INFO, "Database connect done");
  return db;
}

str *databaseTranformToken(Token *t) {
  log(INFO, "Tranforming token to insert into DB");
  str *res = alloc(sizeof(str) * 15);
  

  
  return null;
}




void databaseInsertToken(Database *db, Token *t) {

  PQexecPrepared(db->conn, DB_TOKENS_INSERT, 15, null, null, null, 0);

}

void databaseDestroy(Database *db) {
  PQfinish(db->conn);
}
