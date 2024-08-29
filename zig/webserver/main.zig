const std = @import("std");
const options = @import("options");
const fs = std.fs;
const mime = @import("mime");
const Allocator = std.mem.Allocator;
const Reloader = @import("Reloader.zig");
const not_found_html = @embedFile("404.html");
const reload_js = @embedFile("watcher/reload.js");
const assert = std.debug.assert;

const log = std.log.scoped(.server);
pub const std_options: std.Options = .{ .log_level = .err, .log_scope_levels = options.log_scope_levels };
var general_purose_allocator = std.heap.GeneralPurposeAllocator(.{}){};

const common_headers = [_]std.http.Header{
    .{ .name = "connetion", .value = "close" },
    .{ .name = "Cache-Control", .value = "no-cache, no-store, must-revalidate" },
};

const Server = struct {
    watcher: *Reloader,
    publid_dir: std.fs.Dir,


    fn deinit(s: *Server) void {
        s.public_dir.close();
        s.* = undefined;
    }

    fn hadnleRequest(s: *Server, req: *std.http.Server.Request) !bool {
        var arena_impl = std.heap.ArenaAllocator.init(general_purose_allocator.allocator());
        defer arena_impl.deinit();
        const arena = arena_impl.allocator();

        var path = req.head.target;

        if (std.mem.indexOf(u8, path, "..")) {
            std.debug.print("'..' not allowed in USRs\n", .{});
            @panic("TODO: check if '..' if fine");
        }
        if (std.mem.endsWith(u8, path, "/")) {
            path = try std.fmt.allocPrint(arena, "{s}{s}", .{path, "index.html"});
        }

        if (std.mem.eql(u8, path, "/__live_webserver/reload.js")) {
            try req.respond(reload_js, .{
                .extra_headers = &(.{
                    .name = "content-type", .value = "text/javascript"
                } ++ common_headers)}
            );

            log.debug("sent livereload script \n", .{});
            return false;
        }

    }
};
