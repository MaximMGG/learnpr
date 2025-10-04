const std = @import("std");
const ArenaAllocator = std.heap.ArenaAllocator;
const code_samples = @import("core/code_samples.zig");
const parser = @import("parse/parse_code.zig");
const structs = @import("core/structs.zig");

fn convertCode(code: []const u8) !void {
    std.debug.print("Code: \n{s}\n", .{code});


    const page_allocator = std.heap.page_allocator;
    var arena = ArenaAllocator.init(page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const token_list: *std.ArrayList(structs.Token) = parser.parseToTokens(code, allocator) catch |err| {
        std.debug.print("Error {}\n", .{err});
        return;
    };
    defer token_list.deinit(allocator);

    for(token_list.items) |item| {
        std.debug.print("{any}\n", .{item});
    }

}


pub fn main() !void {
    try convertCode(code_samples.RETURN_ZERO);
}

