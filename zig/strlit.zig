const print = @import("std").debug.print;
const mem = @import("std").mem;
const std = @import("std");

pub fn main() void {
    const bytes = "hello";
    print("{}\n", .{@TypeOf(bytes)});
    print("{d}\n", .{bytes.len});
    print("{c}\n", .{bytes[1]});
    print("{d}\n", .{bytes[1]});
    const hello = 
        \\#include <stdio.h>
        \\
        \\int main() {
        \\  printf("Hello, world!\n");
        \\ return0;
        \\}
    ;
    print("Hello world in C:\n {s}\n", .{hello});

    const String: type = []const u8;
    const s: String = "Hello";
    print("string: {s}\n", .{s});
    var v: []u8 = "Byehueue";
    v[0] += 1;
    print("mutable string: {s}\n", .{v});


}
