const std = @import("std");


const Human = struct {
    name: []const u8,
    age: u32,
    sex: u8,


    pub fn print_human(self: Human) void {
        std.debug.print("{c}.name = {s}, .age = {d}, .sex = {c}{c}", .{'{', self.name, self.age, self.sex, '}'});
    }


};


fn string_hash_map() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    const allocator = gpa.allocator();

    var map = std.StringHashMap(Human).init(allocator);
    defer map.deinit();

    try map.put("Pedro", .{.name = "Pedro", .age = 23, .sex = 'M'});
    try map.put("Huano", .{.name = "Huano", .age = 43, .sex = 'M'});
    try map.put("Hulitta", .{.name = "Hulitta", .age = 11, .sex = 'F'});
    try map.put("Laura", .{.name = "Laura", .age = 61, .sex = 'F'});


    var it = map.iterator();

    while(it.next()) |kv| {
        std.debug.print("Name of human: {s}", .{kv.key_ptr.*});
        kv.value_ptr.*.print_human();
        std.debug.print("\n", .{});
    }
}


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    const allocator = gpa.allocator();

    var map = std.AutoHashMap(u32, u16).init(allocator);
    defer map.deinit();

    try map.put(12345, 33);
    try map.put(23456, 44);
    try map.put(34567, 55);
    try map.put(45678, 66);


    var it = map.iterator();

    while(it.next()) |kv| {
        std.debug.print("KEY: {d}, VALUE: {d}\n", .{kv.key_ptr.*, kv.value_ptr.*});
    }


    std.debug.print("N items strore in hash map: {d}\n", .{map.count()});

    std.debug.print("Value of key: 12345 - {d}\n", .{map.get(12345).?});

    if (map.remove(23456)) {
        std.debug.print("Value of key 23456 successfully removed\n", .{});
    }

    std.debug.print("N items strore in hash map: {d}\n", .{map.count()});
    std.debug.print("\n\n", .{});

    try string_hash_map();
}
