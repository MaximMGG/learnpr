#include <stdio.h>
#include <stdlib.h>
#include <postgresql/libpq-fe.h>


int main() {

    printf("libpq tutor\n");

    char *conninfo = "dbname=testdb user=maxim password=maxim";

    PGconn *conn = PQconnectdb(conninfo);

    if (PQstatus(conn) != CONNECTION_OK) {
        printf("Error while connectiong to the databse server %s\n", PQerrorMessage(conn));

        PQfinish(conn);

        exit(1);
    }

    printf("Connection Established\n");
    printf("Port: %s\n", PQport(conn));
    printf("Host: %s\n", PQhost(conn));
    printf("DBName: %s\n", PQdb(conn));


    char *query = "CREATE TABLE names ("
                    "id INT PRIMARY KEY,"
                    "name VARCHAR(128) NOT NULL"
                    ");";

    PGresult *res = PQexec(conn, query);

    ExecStatusType resStatus = PQresultStatus(res);

    printf("Query Status: %s\n", PQresStatus(resStatus));

    if (resStatus != PGRES_TUPLES_OK) {
        printf("Error while executing the query: %s\n", PQerrorMessage(conn));

        PQclear(res);

        PQfinish(conn);

        exit(1);
    }

    printf("Done");

    return 0;
}
