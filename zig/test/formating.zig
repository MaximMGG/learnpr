const std = @import("std");

const item = struct {
    name: []u8 = undefined,
    a: u32,
    b: u32,
    c: i32,

    fn toString(self: *item, buf: []u8) ![]u8 {
        const res = try std.fmt.bufPrint(buf, "{s: <20} {d: ^20} {d: ^20} {d: ^20}", 
            .{self.name, self.a, self.b, self.c});
        return res;
    }
};


pub fn main() !void {
    std.debug.print("{s: <20} {s: ^20} {s: ^20} {s: ^20}\n", .{"name", "current_consubption", "limits", "diffrens"});
    var it1 = item{.a = 123, .b = 234, .c = 345};
    it1.name = try std.heap.page_allocator.dupe(u8, "Bobby");
    defer std.heap.page_allocator.free(it1.name);

    var buf: [512]u8 = .{0} ** 512;
    const str = try it1.toString(&buf);

    std.debug.print("{s}\n", .{str});
}
