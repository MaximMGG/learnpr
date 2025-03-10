const std = @import("std");
const User = @import("user.zig");
const m = std.math;
const atom = std.atomic;
const expect = std.testing.expect;

const stdout = std.io.getStdOut().writer();
const Role = enum { SE, DPE, DE, DA, PM, PO, KS };

pub fn main() !void {
    try stdout.print("Start chapter 2\n", .{});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    errdefer {
        std.debug.print("So, error here\n", .{});
    }

    var area: []const u8 = undefined;
    const role = Role.SE;

    switch (role) {
        .PM, .SE, .DPE, .PO => {
            area = "Platform";
        },
        .DE, .DA => {
            area = "Data & Analytics";
        },
        .KS => {
            area = "Sales";
        },
    }
    try stdout.print("{s}\n", .{area});
    try print_char("ijifjeab");
    try panic_example();
    try labelet_switch();
    return_error() catch |e| {
        try stdout.print("Catch error {!}\n", .{e});
        switch (e) {
            error.Ret_Error => {
                try stdout.print("Eating error {!}\n", .{error.Ret_Error});
            },
        }
    };
    try loops();
    var number: u32 = 12;
    add2(&number);
    try stdout.print("{d}\n", .{number});
    try struct_example();
    try struct_cast_examle(allocator);
    try cast_examples();
}

fn print_char(str: []const u8) !void {
    for (str) |c| {
        switch (c) {
            'a' => {
                try stdout.print("char - {c}\n", .{c});
            },
            'b' => {
                try stdout.print("char - {c}\n", .{c});
            },
            else => {
                try stdout.print("Enother char\n", .{});
            },
        }
    }
}

fn panic_example() !void {
    const level: u32 = 26;
    const category = switch (level) {
        0...25 => "Beginner",
        26...50 => "Intermediate",
        51...75 => "Profy",
        76...100 => "God",
        else => {
            @panic("Unsuported value");
        },
    };
    try stdout.print("Category {s}\n", .{category});
}

fn labelet_switch() !void {
    label: switch (@as(u8, 1)) {
        1 => {
            try stdout.print("First branch\n", .{});
            continue :label 2;
        },
        2 => {
            try stdout.print("Second branch\n", .{});
            continue :label 3;
        },
        3 => {
            try stdout.print("Thats it\n", .{});
        },
        else => {
            @panic("Ftf\n");
        },
    }
}

fn return_error() !void {
    return error.Ret_Error;
}

fn loops() !void {
    const items = [_]u8{ 'Z', 'e', 'b', 'r', 'a' };

    for (items, 0..items.len) |item, i| {
        try stdout.print("Item {c} - index {d}\n", .{ item, i });
    }

    var i: i32 = 0;
    while (i < 100) : (i += 1) {
        if (i == 10) {
            break;
        }
    }
    try stdout.print("i == {d}\n", .{i});

    var arr: [10]u8 = undefined;
    try stdout.print("Type of arr {any}\n", .{@TypeOf(arr)});
    try stdout.print("Type of &arr {any}\n", .{@TypeOf(&arr)});
    try stdout.print("Type of arr[0..arr.len] {any}\n", .{@TypeOf(arr[0..arr.len])});
    for (arr, 0..) |el, index| {
        try stdout.print("Type of el {any}\n", .{@TypeOf(el)});
        if (index == 2) {
            arr[index] = 'Z';
            //el = '3';
        }
    }
    var arr2: *[10]u8 = &arr;
    try stdout.print("Type of arr2 {any}\n", .{@TypeOf(arr2)});
    try stdout.print("Arr len {d}\n", .{arr.len});
    try stdout.print("Arr - {s}\n", .{arr});
    _ = &arr2;
}

fn add2(number: *u32) void {
    number.* += 2;
}

// const User = struct {
//     id: u64,
//     name: []const u8,
//     email: []const u8,
//
//     fn init(id: u64, name: []const u8, email: []const u8) User {
//         return User {
//             .id = id,
//             .name = name,
//             .email = email
//         };
//     }
//
//     fn print_name(self: User) !void {
//         try stdout.print("User name: {s}\n", .{self.name});
//     }
// };

const Vec3 = struct {
    x: f64,
    y: f64,
    z: f64,

    pub fn distance(self: Vec3, other: Vec3) f64 {
        const xd = m.pow(f64, self.x - other.x, 2.0);
        const yd = m.pow(f64, self.y - other.y, 2.0);
        const zd = m.pow(f64, self.z - other.z, 2.0);
        return m.sqrt(xd + yd + zd);
    }

    pub fn twice(self: *Vec3) void {
        self.x *= 2.0;
        self.y *= 2.0;
        self.z *= 2.0;
    }
};

fn struct_example() !void {
    // const user: User.User = undefined;
    // _ = user;
    var user: User.User = User.User.init(1, "Pedro", "pedro@gmail.com");
    try user.print_name();

    user.change_id(9);
    try stdout.print("new id {d}\n", .{user.id});

    const f = .{ 11.2, 11.0, 0 };

    try stdout.print("{any}\n", .{@TypeOf(.{ @as(f32, 34.1), @as(u32, 44), @as(f64, 11.9) })});
    try stdout.print("{any}\n", .{@TypeOf(f)});

    var v1: Vec3 = .{ .x = 12.1, .y = 12.2, .z = 12.3 };
    const v2: Vec3 = .{ .x = 33.1, .y = 34.7, .z = 111.0 };

    try stdout.print("{d}\n", .{v1.distance(v2)});

    v1.twice();
    try stdout.print("{any}\n", .{@as(*[3]f64, @ptrCast(&v1))});
}

const Full_name = struct {
    name: []const u8,
    id: u64,
    email: []const u8 = undefined,
    allocator: std.mem.Allocator,
};

const Just_name = struct {
    name: []const u8,

    pub fn init(allocator: std.mem.Allocator, name: []const u8) anyerror!*Just_name {
        const full_n: *Full_name = try allocator.create(Full_name); //{ .name = name, .id = 9999, .allocator = allocator };
        full_n.name = name;
        full_n.id = 999;
        full_n.allocator = allocator;
        //var full_n: Full_name = Full_name{ .name = name, .id = 99999 };

        return (@as(*Just_name, @ptrCast(full_n)));
    }
    pub fn deinit(self: *Just_name) void {
        const full_n: *Full_name = @ptrCast(self);
        const allocator = full_n.allocator;
        allocator.destroy(full_n);
    }

    pub fn print_info(self: *Just_name) !void {
        const full_n: *Full_name = @ptrCast(self);
        try stdout.print("Name: {s}, id: {d}\n", .{ full_n.name, full_n.id });
    }
};

fn struct_cast_examle(allocator: std.mem.Allocator) !void {
    var jn: *Just_name = try Just_name.init(allocator, "Asher");
    defer jn.deinit();
    try jn.print_info();
}

fn cast_examples() !void {
    const f: f32 = 3.71;
    const a: i32 = @bitCast(f);
    const f2: f32 = @bitCast(a);

    try stdout.print(
        \\Before casting {d}
        \\After casting to int {d}
        \\After casting back to float {d}
        \\
    , .{ f, a, f2 });

    const bytes align(@alignOf(u32)) = [_]u8{ 0x12, 0x12, 0x12, 0x12 };

    const u32_ptr: *const u32 = @ptrCast(&bytes);
    try expect(@TypeOf(u32_ptr) == *const u32);
    try stdout.print("{d}\n", .{u32_ptr.*});
}
