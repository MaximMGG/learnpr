const std = @import("std");


const Dog = extern struct {
    name: [64]u8 = .{0} ** 64,
    age: u32 = 0
};

pub fn main() !void {
    const f = try std.fs.cwd().createFile("test.txt", .{});
    var d = Dog{.age = 7};
    std.mem.copyForwards(u8, &d.name, "Aiub");
    
    try f.writer().writeStruct(d);
    f.close();

    const f2 = try std.fs.cwd().openFile("test.txt", .{.mode = .read_only});
    defer f2.close();

    const d2 = try f2.reader().readStruct(Dog);
    std.debug.print("Dog name: {s}, Dog age: {d}\n", .{d2.name, d2.age});

}
