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

  res = PQexec(conn, "INSERT INTO test_table(id, value, price) VALUES(11, 777, 1313.777)");
  if (PQresultStatus(res) != PGRES_COMMAND_OK) {
    fprintf(stderr, "ERROR: %s\n", PQerrorMessage(conn));
  }

  PQclear(res);
  PQfinish(conn);

  return 0;
}
