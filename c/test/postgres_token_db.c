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

const char *quary = "CREATE TABLE IF NOT EXISTS token ("
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

int main() {
  const char *connect = "dbname=mydb sslmode=disable";
  PGconn *conn;
  PGresult *res;

  conn = PQconnectdb(connect);

  if (PQstatus(conn) != CONNECTION_OK) {
    fprintf(stderr, "PQ connect error\n");
    return 1;
  }
  printf("Connected\n");

  res = PQexec(conn, quary);
  if (PQresultStatus(res) != PGRES_COMMAND_OK) {
    fprintf(stderr, "PQexec error: %s\n", PQerrorMessage(conn));
    PQfinish(conn);
    return 1;
  }
  printf("Create table\n");

  PQfinish(conn);
  return 0;
}
