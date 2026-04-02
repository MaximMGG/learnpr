const std = @import("std");


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var h = std.HashMap(User, u32, User.HashContext, std.hash_map.default_max_load_percentage).init(allocator);
    defer h.deinit();

    try h.put(.{.id = 0, .name = "Pedro"}, 999);
    try h.put(.{.id = 1, .name = "Huan"}, 777);

    std.debug.print("{d}\n", .{h.get(.{.id = 0, .name = "Pedro"}).?});
    std.debug.print("{d}\n", .{h.get(.{.id = 1, .name = "Huan"}).?});

}


const User = struct {
    id: u64 = undefined,
    name: []const u8 = undefined,



    pub const HashContext = struct {
        pub fn hash(_: HashContext, u: User) u64 {
            var h = std.hash.Wyhash.init(0);
            h.update(std.mem.asBytes(&u.id));
            h.update(u.name);
            return h.final();
        }

        pub fn eql(_: HashContext, a: User, b: User) bool {
            if (a.id != b.id) return false;
            return std.mem.eql(u8, a.name, b.name);
        }
    };

};
