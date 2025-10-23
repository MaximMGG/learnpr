const std = @import("std");
const w = @cImport({
    @cInclude("wayland-client.h");
    @cInclude("wayland-client-protocol.h");
});
const pty = @cImport(@cInclude("pty.h"));


const compositor: ?*w.wl_compositor = null;
const shm: ?*w.wl_shm = null;
const wm_base: ?*w.xdg_wm_base = null;


const reglistener = w.wl_registry_listener{};


pub fn main() void {
    const wl_display = w.wl_display_connect(null) orelse {
        @panic("Cant create wayland display");
    };


    const registry = w.wl_display_get_registry(wl_display);
    _ = w.wl_registry_add_listener(registry, null, null);


    std.debug.print("All done\n", .{});

}
