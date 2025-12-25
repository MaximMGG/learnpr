const std = @import("std");
const db = @cImport(@cInclude("libpq-fe.h"));


pub fn main() void {

    const conn = db.PQconnectdb("dbname=mydb user=maxim password=maxim").?;
    if (db.PQstatus(conn) != db.CONNECTION_OK) {
       std.debug.print("Connection bad\n", .{}); 
    }

    const res = db.PQexec(conn, "INSERT INTO test_table(id, value, price) VALUES(11, 123, 777.13)").?;

    if (db.PQresultStatus(res) != db.PGRES_COMMAND_OK) {
       const err = std.mem.span(db.PQerrorMessage(conn)); 
       std.debug.print("Error: {s}\n", .{err});
    }

    db.PQclear(res);
    db.PQfinish(conn);
}
