const std = @import("std");
const c = std.c;
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var buffer: []u8 = try allocator.alloc(u8, 500);
    defer allocator.free(buffer);
    try stdout.print("Address of buffer {p}\n", .{&buffer});
    try stdout.print("Address of buffer.ptr {p}\n", .{&buffer.ptr});
    try stdout.print("Address of buffer.len {p}\n", .{&buffer.len});

    var buf: []u8 = undefined;
    buf.ptr = @alignCast(@ptrCast(c.malloc(500).?));
    defer c.free(@ptrCast(buf));
    buf.len = 500;
    buf.ptr[0] = 'A';
    @memset(buf[0..buf.len], 3);
    try stdout.print("{any}\n", .{@TypeOf(buf)});
    try stdout.print("pointer to buf {any}\n", .{&buf});
    try stdout.print("poiner to buf.ptr {any}\n", .{&buf.ptr});
    try stdout.print("poiner to buf.len {any}\n", .{&buf.len});
    try stdout.print("{any}\n", .{buf});

    for (0..buf.len) |i| {
        if (i % 7 == 0) {
            buf[i] = 77;
        }
    }
    stack_example();
    try alloc_example();
    try alloc_and_read();
    try general_pa();
    try page_a();
    try buffer_a();
    try areana_a();
}

fn add(x: u8, y: u8) u8 {
    const result = x + y;
    return result;
}

fn stack_example() void {
    const r = add(5, 27);
    _ = r;
}

fn alloc_example() !void {
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = gpa.allocator();
    const c_alloc = std.heap.c_allocator;
    const name = "Pedro";
    const info = try std.fmt.allocPrint(c_alloc, "This is {s}", .{name});
    defer c_alloc.free(info);

    try stdout.print("{s}\n", .{info});
}

fn alloc_and_read() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const buf = try allocator.alloc(u8, 50);
    defer allocator.free(buf);
    setval(u8, buf, @as(u8, 0));
    @memset(buf, 0);
    const stdin = std.io.getStdIn().reader();
    _ = try stdin.readUntilDelimiterOrEof(buf, '\n');
    try stdout.print("{s}\n", .{buf});
}

fn setval(comptime T: type, buf: []T, val: T) void {
    for (0..buf.len) |i| {
        buf[i] = val;
    }
}

fn general_pa() !void {
    try stdout.print("GeneralPurposeAllocator\n", .{});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const check: std.heap.Check = gpa.deinit();
        switch (check) {
            .ok => std.debug.print("gpa deinit ok\n", .{}),
            .leak => std.debug.print("gpa leak memory\n", .{}),
        }
    }
    const allocator = gpa.allocator();

    const buf: []u8 = try allocator.alloc(u8, 100);
    defer allocator.free(buf);
    @memset(buf, 0);
    std.mem.copyForwards(u8, buf, "Hello allocators");

    try stdout.print("{s}\n", .{buf});
}

fn page_a() !void {
    try stdout.print("page_allocator\n", .{});
    const pa = std.heap.page_allocator;

    const buf: []u8 = try pa.alloc(u8, 200);
    @memset(buf, 0);
    std.mem.copyForwards(u8, buf, "What a nice day)");

    try stdout.print("{s}\n", .{buf});

    pa.free(buf);
}

fn buffer_a() !void {
    try stdout.print("FixedBufferAllocator\n", .{});
    var buffer: [200]u8 = .{0} ** 200;

    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const buf: []u8 = try allocator.alloc(u8, 20);
    defer allocator.free(buf);
    @memset(buf, 0);

    std.mem.copyForwards(u8, buf, "Little text");
    try stdout.print("{s}\n", .{buf});
}

fn areana_a() !void {
    try stdout.print("areana_allocator\n", .{});
    const c_alloc = std.heap.c_allocator;
    var aa = std.heap.ArenaAllocator.init(c_alloc);
    defer aa.deinit();
    const allocator = aa.allocator();

    const buf: []u8 = try allocator.alloc(u8, 50);
    @memset(buf, 0);

    std.mem.copyForwards(u8, buf, "What i want to say, I dont dow, fortunately");

    try stdout.print("{s}\n", .{buf});

    const i: *u64 = try allocator.create(u64);
    i.* = 999;

    try stdout.print("{d}\n", .{i.*});
    allocator.destroy(i);

    const mega_buf: []f64 = try allocator.alloc(f64, 200);
    @memset(mega_buf, 0);

    for (0..mega_buf.len) |f| {
        mega_buf[f] = @as(f64, @floatFromInt(f)) + 0.3;
    }

    try stdout.print("{any}\n", .{mega_buf});

    const mega_buf_p: [*]f64 = mega_buf.ptr;
    const mega_buf_len: usize = mega_buf.len;

    for (0..mega_buf_len) |f| {
        try stdout.print("{d}\n", .{mega_buf_p[f]});
    }
}
