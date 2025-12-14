#include <stdio.h>
#include <libpq-fe.h>

int main() {
  printf("Init postgresql connection test\n");
  const char *conninfo = "dbname=mydb user=maxim password=maxim";
  PGconn *conn;
  PGresult *res;

  conn = PQconnectdb(conninfo);
  if (PQstatus(conn) != CONNECTION_OK) {
    fprintf(stderr, "Connection to database failed: %s\n", PQerrorMessage(conn));
    return 1;
  }
  printf("Connected\n");

  res = PQexec(conn, "SELECT id FROM token_relation WHERE symbol = 'BTCUSDT'");
  if (PQresultStatus(res) != PGRES_TUPLES_OK) {
    fprintf(stderr, "Quary failed: %s\n", PQerrorMessage(conn));
    return 1;
  }
  int rows = PQntuples(res);
	int cols = PQnfields(res);
  printf("Rows: %d, Cols: %d\n", rows, cols);
	printf("Res: %s\n", PQgetvalue(res, 0, 0));

  PQclear(res);
  PQfinish(conn);

  return 0;
}
