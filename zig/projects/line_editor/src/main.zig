const std = @import("std");
const c = @cImport({
    @cInclude("stdlib.h");
    @cInclude("stdio.h");
});
const stdout = std.io.getStdOut().writer();

var lines: [2000][]u8 = undefined;
var line: [c.BUFSIZ]u8 = undefined;
var a1: i32 = 0;
var a2: i32 = 0;
var a3: i32 = 0;
var last_line: usize = 0;
var curr_line: i32 = 0;

var cmd: u8 = undefined;
var filename: []u8 = undefined;
var cmd_parms: []u8 = undefined;

fn str_dup(allocator: std.mem.Allocator, s: []u8) ![]u8 {
    const new = try allocator.dupe(u8, s);
    return new;
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    if (args.len < 2) {
        std.process.exit(1);
    }
    // Read in input file to line buffer
    filename = args[1];
    var fp = try std.fs.cwd().openFile(filename, .{.mode = .read_only});
    defer fp.close();
    var buf_reader = std.io.bufferedReader(fp.reader());
    const reader = buf_reader.reader();
    while(reader.readUntilDelimiter(&line, '\n')) |cur_line| {
        lines[last_line] = try str_dup(allocator, cur_line);
        last_line += 1;
    } else |_| {}

    // Input loop to read next command to run on lines
    while(true) {
        // Print promt by defalut
        try stdout.print("*", .{});
        // Read in next line adresses and command to run
        const next_line: []u8 = std.io.getStdIn().reader().readUntilDelimiter(&line, '\n') orelse break;

        if (c.sscanf(line[0..].ptr, "%d,%d%c", &a1, &a2, &cmd) < 3) {

        }
    }
}

