#include "database.h"
#define DB_CONNECTION_FMT "dbname=%s user=%s password=%s sslmode=disable"
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
const str delete_from_token_table = "DELETE FROM * token WHERE id = $1";
const str get_token_relation = "SELECT * FROM token_relation";    
const str insert_token_relation = "INSERT INTO token_ralation(symbol) VALUES($1)";
const str select_token_relation = "SELECT id FROM token_ralation WHERE symbol = '$1'";

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

Database *databaseConnect(str database_name, str user, str password) {
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
  //TODO(maxim) write this func
  return null;
}



void databaseInsertToken(Database *db, Token *t) {
  //TODO(maxim) after databaseTransformToken will be writen add here

  PQexecPrepared(db->conn, DB_TOKENS_INSERT, 15, null, null, null, 0);
}

void databaseDestroy(Database *db) { 
  PQfinish(db->conn); 
}

map *databaseGetTokenRelation(Database *db) {
  log(INFO, "Get token relation start");
  db->res = PQexec(db->conn, get_token_relation);
  if (PQresultStatus(db->res) != PGRES_TUPLES_OK) {
    log(ERROR, "get_token_relation err: ", PQerrorMessage(db->conn));
    return null; 
  }
  map *m = map_create(STR, I32, null, null);
  i32 rows = PQntuples(db->res);
  for(i32 i = 0; i < rows; i++) {
    str symbol = PQgetvalue(db->res, i, 0);
    i32 id = atol(PQgetvalue(db->res, i, 1));
    map_put(m, symbol, &id);
  }
  PQclear(db->res);
  log(INFO, "Get token relation done");
  return m;
}

static bool databaseCheckSymbolExists(Database *db, str symbol) {
  const char *symbolParam[1] = {symbol};

  db->res = PQexecParams(db->conn, select_token_relation, 1, null, symbolParam, null, null, 0);
  if (PQresultStatus(db->res) != PGRES_TUPLES_OK) {
    log(ERROR, "select_token_relation err: %s", PQerrorMessage(db->conn));
    return false;
  }
  i32 r = PQntuples(db->res);
  if (r == 0) {
    return false;
  }
  PQclear(db->res);
  return true;
}

i32 databaseAddToken(Database *db, str symbol) {
  if (!databaseCheckSymbolExists(db, symbol)) {
    return -1;
  }
  log(INFO, "Insert Token func");
  const char *symbolParam[1] = {symbol};
  db->res = PQexecParams(db->conn, insert_token_relation, 1, null, symbolParam, null, null, 0);
  if (PQresultStatus(db->res) != PGRES_COMMAND_OK) {
    log(ERROR, "insert_token_relation: %s", PQerrorMessage(db->conn));
    return -1;
  }
  PQclear(db->res);
  db->res = PQexecParams(db->conn, select_token_relation, 1, null, symbolParam, null, null, 0);
  if (PQresultStatus(db->res) != PGRES_TUPLES_OK) {
    log(ERROR, "select_token_relation: %s", PQerrorMessage(db->conn));
    return -1;
  }
  i32 res = atol(PQgetvalue(db->res, 0, 0));
  log(INFO, "Insert token done, id: %d", res);
  return res;
}
