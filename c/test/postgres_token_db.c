#include <libpq-fe.h>

//   str symbol;
//   f64 priceChange;
//   f64 priceChangePercent;
//   f64 weightedAvgPrice;
//   f64 openPrice;
//   f64 highPrice;
//   f64 lowPrice;
//   f64 lastPrice;
//   f64 volume;
//   f64 quoteVolume;
//   i64 openTime;
//   i64 closeTime;
//   i64 firstId;
//   i64 lastId;
//   i64 count;

const char *quary = "CREATE TABLE token ("
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


const char *dropTable = "DROP TABLE token";

static void checkTableExists(PGconn *conn, PGresult *res, char *table_name) {
  const char *sql = "SELECT COUNT(*) FROM pg_tables "
    "WHERE schemaname = 'public' AND tablename = $1";

  const char *paramValues[1] = {table_name};
  
  res = PQexecParams(conn, sql, 1, NULL, paramValues, NULL, NULL, 0);

  if (PQresultStatus(res) != PGRES_TUPLES_OK) {
    fprintf(stderr, "%s failed\n", sql);
    PQfinish(conn);
    return;
  }

  printf("Table %s status %s\n", table_name, PQgetvalue(res, 0, 0));

  PQclear(res);

}


int main() {
  const char *connect = "dbname=mydb user=maxim password=maxim sslmode=disable";
  PGconn *conn;
  PGresult *res;

  conn = PQconnectdb(connect);

  if (PQstatus(conn) != CONNECTION_OK) {
    fprintf(stderr, "PQ connect error: %s\n", PQerrorMessage(conn));
    return 1;
  }
  printf("Connected\n");


  printf("Try to DROP TABLE\n");

  res = PQexec(conn, dropTable);

  if (PQresultStatus(res) != PGRES_COMMAND_OK) {
    fprintf(stderr, "PQexe error: %s\n", PQerrorMessage(conn));
    return 1;
  }
  printf("Table is DROPED\n");
  PQclear(res);
  
  res = PQexec(conn, quary);
  if (PQresultStatus(res) != PGRES_COMMAND_OK) {
    fprintf(stderr, "PQexec error: %s\n", PQerrorMessage(conn));
    PQfinish(conn);
    return 1;
  }
  printf("Create table\n");

  checkTableExists(conn, res, "token");
  
  PQfinish(conn);
  return 0;
}
