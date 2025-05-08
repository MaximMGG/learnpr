const std = @import("std");
const pg = @cImport({
    @cInclude("libpq-fe.h");
});


const PG_DATA_BASES = struct {

};


fn cleanup(conn: *pg.PGconn) void {
    const cleanup_query = "DROP TABLE IF EXISTS names;";
    const r = pg.PQexec(conn, cleanup_query);
    const res = pg.PQresultStatus(r);
    std.debug.print("CLEANUP STATUS: {s}\n", .{pg.PQresStatus(res)});
    if (res != pg.PGRES_COMMAND_OK) {
        std.debug.print("error while cleanup: {s}\n", .{pg.PQerrorMessage(conn)});
        pg.PQclear(r);
        pg.PQfinish(conn);
        std.c.exit(1);
    }
}


pub fn main() !void {
    std.debug.print("Zig posgtres test\n", .{});

    const conn = pg.PQconnectdb("dbname=testdb user=maximhrunenko password=17TypeofMG").?;
    cleanup(conn);

    const create_table_query = "CREATE TABLE names (id INT PRIMARY KEY, name VARCHAR(128));";

    var r = pg.PQexec(conn, create_table_query);

    var res = pg.PQresultStatus(r);
    std.debug.print("CREATE TABLE STATUS: {s}\n", .{pg.PQresStatus(res)});
    if (res != pg.PGRES_COMMAND_OK) {
        std.debug.print("error while create table: {s}\n", .{pg.PQerrorMessage(conn)});
        pg.PQclear(r);
        pg.PQfinish(conn);
        std.c.exit(1);
    }

    const insert_query = "INSERT INTO names(id, name) VALUES(0, 'Perdo777')";
    r = pg.PQexec(conn, insert_query);
    res = pg.PQresultStatus(r);

    std.debug.print("INSERT INTO TABLE STATUS: {s}\n", .{pg.PQresStatus(res)});
    if (res != pg.PGRES_COMMAND_OK) {
        std.debug.print("error while insert into table: {s}\n", .{pg.PQerrorMessage(conn)});
        pg.PQclear(r);
        pg.PQfinish(conn);
        std.c.exit(1);
    }

    pg.PQclear(r);
    pg.PQfinish(conn);
}
