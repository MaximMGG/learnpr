const std = @import("std");
const time = std.time;

const stdout = std.io.getStdOut().writer();

fn print_space(repeat: usize) void {
    for (0..repeat) |i| {
        stdout.print("{d} - Hello world ", .{i}) catch return;
    }
}

fn print_new_line(repeat: usize) void {
    for (0..repeat) |i| {
        stdout.print("{d} - Hello world\n", .{i}) catch return;
    }
}

pub export fn main(argc: c_int, argv: [*]const [*:0]const u8) c_int {
    if (argc != 2) {
        stdout.print("Usage: <intager>\n", .{}) catch return 1;
        return 0;
    }

    var for_part: []const u8 = undefined;
    for_part.ptr = argv[1];
    for_part.len = std.mem.len(argv[1]);

    const repeat: usize = std.fmt.parseInt(usize, for_part, 10) catch return 1;

    var space_time = time.microTimestamp();
    print_space(repeat);
    space_time = time.microTimestamp() - space_time;
    const space_time_taken = @as(f64, @floatFromInt(space_time)) / 1_000_000;
    //const space_time_taken = space_time;

    var new_line_time = time.microTimestamp();
    print_new_line(repeat);
    new_line_time = time.microTimestamp() - new_line_time;
    const new_line_time_taken = @as(f64, @floatFromInt(new_line_time)) / 1_000_000;
    //const new_line_time_taken = new_line_time;

    stdout.print("Space time: \t{d}\nNew Line time: \t{d}\n", .{ space_time_taken, new_line_time_taken }) catch return 1;

    return 0;
}
