#include <stdio.h>
#include <postgresql/libpq-fe.h>

int main() {
  printf("Init postgresql connection test\n");
  const char *conninfo = "dbname=testdb sslmode=disable";
  PGconn *conn;
  PGresult *res;

  conn = PQconnectdb(conninfo);
  if (PQstatus(conn) != CONNECTION_OK) {
    fprintf(stderr, "Connection to database failed: %s\n", PQerrorMessage(conn));
    return 1;
  }
  printf("Connected\n");

  res = PQexec(conn, "SELECT * FROM names");
  if (PQresultStatus(res) != PGRES_TUPLES_OK) {
    fprintf(stderr, "Quary failed: %s\n", PQerrorMessage(conn));
    return 1;
  }

  int rows = PQntuples(res);
  int cols = PQnfields(res);

  for(int i = 0; i < cols; i++) {
    printf("%s\t", PQfname(res, i));
  }

  printf("\n\n");
  
  for(int i = 0; i < rows; i++) {
    for(int j = 0; j < cols; j++) {
      printf("%s\t", PQgetvalue(res, i, j));
    }
    printf("\n");
  }
  
  PQclear(res);
  PQfinish(conn);

  return 0;
}
