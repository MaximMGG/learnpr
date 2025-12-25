const std = @import("std");
const db = @cImport(@cInclude("libpq-fe.h"));
const testing = std.testing;

const Database = struct {
    conn: *db.PGconn,
    res: *db.PGresult,



    fn connect(allocator: std.mem.Allocator, dbname: []const u8, user: []const u8, password: []const u8) !*Database {
        const dbase = try allocator.create(Database);
        const connstr = try std.fmt.allocPrint(allocator, "dbname={s} user={s} password={s}", .{dbname, user, password});
        
        dbase.conn = db.PQconnectdb(connstr.ptr).?;
        if (db.PQstatus(dbase.conn) != db.CONNECTION_OK) {
            std.debug.print("Connection dab\n", .{});
            return error.BadConnection;
        }
        return dbase;
    }

    fn insert(self: *Database, query: []const u8) void {
        self.res = db.PQexec(self.conn, query.ptr).?;
        if (db.PQresultStatus(self.res) != db.PGRES_COMMAND_OK) {
           const err = std.mem.span(db.PQerrorMessage(self.conn)); 
           std.debug.print("Error: {s}\n", .{err});
        }
        db.PQclear(self.res);
    }
   
    fn disconnect(self: *Database) void {
        db.PQfinish(self.conn);
    }
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const dbase = try Database.connect(allocator, "mydb", "maxim", "maxim");
    defer dbase.disconnect();
    dbase.insert("INSERT INTO test_table(id, value, price) VALUES(112, 888, 1384.888)");
}
