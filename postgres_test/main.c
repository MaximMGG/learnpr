#include <stdio.h>
#include <stdlib.h>
#include <libpq-fe.h>

void cleanup(PGconn *conn) {
    char *cleanup_query = "DROP TABLE IF EXISTS names;";
    PGresult *r = PQexec(conn, cleanup_query);

    ExecStatusType res = PQresultStatus(r);
    printf("CLEANUP %s\n", PQresStatus(res));
    if (res != PGRES_COMMAND_OK) {
        printf("Error while cleanup: %s\n", PQerrorMessage(conn));
        PQclear(r);
        PQfinish(conn);
        exit(1);
    }
}

int main() {

    printf("libpq tutor\n");

    char *conninfo = "dbname=testdb user=maximhrunenko password=17TypeofMG";

    PGconn *conn = PQconnectdb(conninfo);

    cleanup(conn);

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

    if (resStatus != PGRES_COMMAND_OK) {
        printf("Error while executing the query: %s\n", PQerrorMessage(conn));

        PQclear(res);

        PQfinish(conn);

        exit(1);
    }

    char *insert_query = "INSERT INTO names (id, name) VALUES(0, 'Perdo');";

    res = PQexec(conn, insert_query);
    resStatus = PQresultStatus(res);
    printf("Insert query status: %s\n", PQresStatus(resStatus));

    PQclear(res);
    PQfinish(conn);

    printf("Done");

    return 0;
}
