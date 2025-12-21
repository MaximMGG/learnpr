const std = @import("std");
const db = @cImport(@cInclude("libpq-fe.h"));

const Database = struct {
    conn: ?*db.PGconn,
    res: *db.PGresult,

    dbname: []const u8,
    user_name: []const u8,
    user_password: []const u8,

    allocator: std.mem.Allocator,
};

fn db_connect(allocator: std.mem.Allocator, dbname: []const u8, user_name: []const u8, user_password: []const u8) !?*Database {
    const dbase = try allocator.create(Database);
    const connect_string = try std.fmt.allocPrint(allocator, "dbname={s} user={s} password={s}\x00", .{ dbname, user_name, user_password });
    std.debug.print("{s}\n", .{connect_string});
    defer allocator.free(connect_string);
    dbase.conn = db.PQconnectdb(connect_string.ptr);
    if (dbase.conn == null) {
        std.debug.print("connect is null\n", .{});
        return null;
    }
    if (db.PQstatus(dbase.conn) != db.CONNECTION_OK) {
        std.log.err("PQconnectdb error with conn_string: {s}\n", .{connect_string});
        return null;
    }

    dbase.dbname = try std.fmt.allocPrint(allocator, "{s}", .{dbname});
    dbase.user_name = try std.fmt.allocPrint(allocator, "{s}", .{user_name});
    dbase.user_password = try std.fmt.allocPrint(allocator, "{s}", .{user_password});
    dbase.allocator = allocator;

    return dbase;
}

fn db_select(database: *Database, query: []const u8) !?[][][]u8 {
    database.res = db.PQexec(database.conn, query.ptr).?;
    if (db.PQresultStatus(database.res) != db.PGRES_TUPLES_OK) {
        std.log.err("PQexec with query {s} error -> {s}\n", .{ query, db.PQerrorMessage(database.conn) });
        return null;
    }
    const rows = db.PQntuples(database.res);
    const cols = db.PQnfields(database.res);
    const res = try database.allocator.alloc([][]u8, @intCast(rows));

    for (0.., res) |i, *row| {
        row.* = try database.allocator.alloc([]u8, @intCast(cols));
        for (0.., row.*) |j, *c| {
            c.* = try database.allocator.dupe(u8, std.mem.span(db.PQgetvalue(database.res, @intCast(i), @intCast(j)).?));
        }
    }
    return res;
}

fn db_disconect(dbase: *Database) void {
    dbase.allocator.free(dbase.dbname);
    dbase.allocator.free(dbase.user_name);
    dbase.allocator.free(dbase.user_password);
    db.PQfinish(dbase.conn);
    dbase.allocator.destroy(dbase);
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const conn = try db_connect(allocator, "mydb", "maxim", "maxim") orelse return;
    defer db_disconect(conn);
    std.debug.print("User: {s}\n", .{conn.user_name});

    const res = try db_select(conn, "select * from token");

    for (res.?) |tuple| {
        for (tuple) |val| {
            std.debug.print("{s}\n", .{val});
        }
    }
}

test "connect_to_db" {
    const conn = db.PQconnectdb("dbname=mydb").?;
    db.PQfinish(conn);
}
