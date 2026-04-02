const std = @import("std");

inline fn foo(src: std.builtin.SourceLocation) void {
    std.debug.print("Line: {d}\nColumn: {d}\nFunc: {s}\nFile: {s}", .{src.line, src.column, src.fn_name, src.file});
}


pub fn main() void {
    foo(@src());
}
