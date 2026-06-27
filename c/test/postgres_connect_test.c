#include <stdio.h>
#include <libpq-fe.h>

int main() {
  printf("Init postgresql connection test\n");
  const char *conninfo = "dbname=mydb user=mhrun";
  PGconn *conn;
  PGresult *res;

  conn = PQconnectdb(conninfo);
  if (PQstatus(conn) != CONNECTION_OK) {
    fprintf(stderr, "Connection to database failed: %s\n", PQerrorMessage(conn));
    return 1;
  }
  printf("Connected\n");

  res = PQexec(conn, "SELECT * FROM test_table;");
  if (PQresultStatus(res) != PGRES_TUPLES_OK) {
    fprintf(stderr, "ERROR: %s\n", PQerrorMessage(conn));
  }

  int rows = PQntuples(res);
  int cols = PQnfields(res);
  printf("Rows %d Cols %d\n", rows, cols);

  PQclear(res);
  PQfinish(conn);

  return 0;
}
