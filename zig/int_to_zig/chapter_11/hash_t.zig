const std = @import("std");



pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var hash_table = std.hash_map.AutoHashMap(u32, u16).init(allocator);
    defer hash_table.deinit();

    try hash_table.put(12345, 11);
    try hash_table.put(83748, 112);
    try hash_table.put(7888585, 111);
    try hash_table.put(989989, 911);
    std.debug.print("N of values stored; {d}\n", .{hash_table.count()});

    std.debug.print("Value at key 12345: {d}\n", .{hash_table.get(12345).?});
    if (hash_table.remove(83748)) {
        std.debug.print("Value at key 83748 successfully removed!\n", .{});
    }

    std.debug.print("N of values stored: {d}\n", .{hash_table.count()});

    var it = hash_table.iterator();
    while(it.next()) |entry| {
        std.debug.print("Key: {d}, value: {d}\n", .{entry.key_ptr.*, entry.value_ptr.*});
    }


    std.debug.print("ArrayHashMap\n", .{});
    var arr_hash_map = std.AutoArrayHashMap(u32, u16).init(allocator);
    defer arr_hash_map.deinit();

    try arr_hash_map.put(111111, 9);
    try arr_hash_map.put(222222, 8);
    try arr_hash_map.put(333333, 7);
    try arr_hash_map.put(444444, 6);
    try arr_hash_map.put(555555, 5);

    var it2 = arr_hash_map.iterator();
    while(it2.next()) |e| {
        std.debug.print("Key: {d}, Value: {d}\n", .{e.key_ptr.*, e.value_ptr.*});
    }
    std.debug.print("String hash map\n", .{});

    var string_hash_map = std.StringHashMap(u32).init(allocator);
    defer string_hash_map.deinit();
    try string_hash_map.put("Mish", 99999);
    try string_hash_map.put("Bob", 982374);
    try string_hash_map.put("Mishlen", 88781123);
    try string_hash_map.put("Korny", 8989898);

    var it3 = string_hash_map.iterator();
    while(it3.next()) |e| {
        std.debug.print("Key: {s}, Value: {d}\n", .{e.key_ptr.*, e.value_ptr.*});
    }



}
