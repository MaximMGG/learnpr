const std = @import("std");
const w = @cImport({
    @cInclude("wayland-client.h");
    @cInclude("wayland-client-protocol.h");
});
const pty = @cImport(@cInclude("pty.h"));


pub fn main() void {
    var wl_display = w.wl_display_connect(null) orelse {
        @panic("Cant create wayland display");
    };


    _ = &wl_display;



    std.debug.print("All done\n", .{});

}
