const std = @import("std");
const testing = std.testing.expect;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, {s}!\n", .{"world"});

    var a = @as(i32, 39);
    a += 1;

    try stdout.print("{any}\n", .{@TypeOf(stdout)});

    try stdout.print("{d}\n", .{a});

    //const age = 178;

    // _ = age;
    // try stdout.print("Age: {d}\n", .{age});
    try arrays(stdout);
    try blocks(stdout);
    try strings(stdout);
    try types(stdout);
    try strings_func(stdout);
}

fn arrays(w: anytype) !void {
    const f: f32 = 3.8;

    try w.print("{any}\n", .{@TypeOf(w)});

    const i: i32 = @bitCast(f);

    try w.print("Int: {d}\n", .{i});

    const f2: f32 = @bitCast(i);

    try w.print("Float after cast: {d}\n", .{f2});

    const ns = [4]u8{ 48, 24, 12, 6 };
    const ls = [_]f32{ 12.4, 32.1, 1.2, 99.8 };
    _ = ns;
    _ = ls;
    const nss: [4]u8 = .{ 2, 8, 6, 1 };
    try w.print("{any}\n", .{@TypeOf(nss)});
    try w.print("{any}\n", .{nss});

    try testing(@TypeOf(nss) == [4]u8);

    try w.print("Slicing\n", .{});

    const slice_nss = nss[1..3];

    try w.print("{any}\n", .{slice_nss});
    try w.print("Type of slice -> {any}\n", .{@TypeOf(slice_nss)});
    try w.print("{d}\n", .{slice_nss[0]});

    var vs = [4]u8{ 9, 8, 7, 6 };
    vs[3] = 10;

    try testing(@TypeOf(vs) == [4]u8);
    try w.print("{any}\n", .{vs});
    try w.print("Type of vs: {any}\n", .{@TypeOf(vs)});

    const slice_vs = vs[1..3];

    try w.print("{any}\n", .{slice_vs});
    try w.print("Type of slice_vs -> {any}\n", .{@TypeOf(slice_vs)});
    try w.print("{d}\n", .{slice_vs[0]});
}

fn blocks(w: anytype) !void {
    try w.print("Blocks\n", .{});

    const sum = one: {
        var i: i32 = 0;
        super_loop: for (0..100) |index| {
            i += @intCast(index);
            if (i >= 66 and i <= 80) {
                break :super_loop;
            }
        }
        i *= 2;
        break :one i;
    };
    try w.print("{d}\n", .{sum});

    const arr: [4]i32 = make_arr: {
        const a: i32 = 3;
        const b: i32 = 7;
        const c: i32 = 8;
        const d: i32 = 99;

        break :make_arr .{ a, b, c, d };
    };
    try w.print("{any}\n", .{arr});
}

fn strings(w: anytype) !void {
    try w.print("Strings\n", .{});
    const string_object_c: []const u8 = "I am string object const";
    //var buf: [100]u8 = .{0} ** 100;
    const string_object_v: []u8 = @constCast("I am string object variable");
    const string_literal = "I am a string literal";
    //string_object_v[10] = 'Q';
    try w.print("{s} - {any}\n", .{ string_object_c, @TypeOf(string_object_c) });
    try w.print("{s} - {any}\n", .{ string_object_v, @TypeOf(string_object_v) });
    //try w.print("{s} - {any}\n", .{ buf, @TypeOf(buf) });
    try w.print("{s} - {any}\n", .{ string_literal, @TypeOf(string_literal) });

    const bytes = [_]u8{ 0x48, 0x65, 0x6c, 0x6c, 0x6f };
    try w.print("{s}\n", .{bytes});

    const string_example = "This is an example";

    try w.print("Bytes that represent this object {p}\n", .{&string_example});

    for (string_example) |byte| {
        try w.print("0x{X} ", .{byte});
    }
    try w.print("\n", .{});
}

fn types(w: anytype) !void {
    try w.print("types\n", .{});
    const simplr_array = [_]i32{ 1, 2, 3, 4 };
    const string_obj: []const u8 = "A string literal";
    try w.print("Type 1: {}\n", .{@TypeOf(simplr_array)});
    try w.print("Type 2: {}\n", .{@TypeOf("A string literal a")});
    try w.print("Type 3: {}\n", .{@TypeOf(&simplr_array)});
    try w.print("Type 4: {}\n", .{@TypeOf(string_obj)});
    try w.print("Type 5: {}\n", .{@TypeOf(string_obj.ptr)});

    var u8str = try std.unicode.Utf8View.init("アメリカ");
    var iterator = u8str.iterator();
    while (iterator.nextCodepointSlice()) |codepoint| {
        try w.print("got codepoint {}\n", .{std.fmt.fmtSliceHexUpper(codepoint)});
    }
    try w.print("{s}\n", .{u8str.bytes});
}

//std.mem.eql();
//std.mem.splitScalar();
//std.mem.splitSequence();
//std.mem.startsWith();
//std.mem.EndsWith();
//std.mem.trim();
//std.mem.conat();
//std.mem.count();
//std.mem.replace();

fn strings_func(w: anytype) !void {
    try w.print("String funcs\n", .{});
    try w.print("std.mem.eql()\n", .{});

    const name_p: []const u8 = "Peter";
    try w.print("{any}\n", .{std.mem.eql(u8, name_p, "Peter")});

    const list: []const u8 = "Many, one, two, bob, never";

    try w.print("std.mem.splitScalar()\n", .{});
    var it = std.mem.splitScalar(u8, list, ',');
    while (it.next()) |val| {
        try w.print("{s}\n", .{val});
    }
    try w.print("std.mem.splitSequence()\n", .{});

    var it2 = std.mem.splitSequence(u8, list, ", ");
    while (it2.next()) |val| {
        try w.print("{s}\n", .{val});
    }
    try w.print("std.mem.startsWith()\n", .{});
    if (std.mem.startsWith(u8, list, "one")) {
        try w.print("Starts with one\n", .{});
    } else if (std.mem.startsWith(u8, list, "Many")) {
        try w.print("Starts with Many\n", .{});
    } else {
        try w.print("Hz\n", .{});
    }
    try w.print("std.mem.endsWith()\n", .{});
    if (std.mem.endsWith(u8, list, "never")) {
        try w.print("Ends with never\n", .{});
    } else {
        try w.print("HZZ\n", .{});
    }
    try w.print("std.mem.concat()\n", .{});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const for_concat_1 = "First string";
    const for_concat_2 = "Second string";
    const for_concat_3 = "Therd string";
    const for_concat_4 = "Fource string";
    const super_string = try std.mem.concat(allocator, u8, &[_][]const u8{ for_concat_1, " ", for_concat_2, " ", for_concat_3, " ", for_concat_4 });
    try w.print("{s}\n", .{super_string});
    allocator.free(super_string);
}
