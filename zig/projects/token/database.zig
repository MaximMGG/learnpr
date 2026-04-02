const std = @import("std");
const c = @cImport(@cInclude("libpq-fe.h"));



pub const Database = struct {

    pub fn init(allocator: std.mem.Allocator, database_name: []const u8, user: []const u8, password: []const u8) Database {
        const conn_str = try std.fmt.allocPrint(allocator, "dbname={s} user={s} password{s}", .{database_name, user, password});
        defer allocator.free(conn_str);
        const conn = c.PQconnectdb(conn_str.ptr).?;

        if (c.PQstatus(conn) != c.PGRES_COMMAND_OK) {

        }



    }
};
