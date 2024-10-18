const std = @import("std");
const fs = std.fs;
const Sha256 = std.crypto.hash.sha2.Sha256;
const print = std.debug.print;

const BUF_SIZE = 16;

fn sha256_digest(file: fs.File) ![Sha256.digest_length]u8 {
    var sha256 = Sha256.init(.{});
    const rdr = file.reader();

    var buf: [BUF_SIZE]u8 = undefined;

    var n = try rdr.read(&buf);

    while (n != 0) {
        sha256.update(buf[0..n]);
        n = try rdr.read(&buf);
    }

    return sha256.finalResult();
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    const file = try fs.cwd().openFile("zig-cookbook-02.txt", .{});
    defer file.close();

    const digest = try sha256_digest(file);
    const hex_digest = try std.fmt.allocPrint(allocator, "{s}", .{std.fmt.fmtSliceHexLower(&digest)});

    defer allocator.free(hex_digest);
    print("->{s}<-\n", .{hex_digest});

    try std.testing.expectEqualStrings("cda70dbe427ef75f47ed5290fa730122fba7eeed8588481070cfa81f0f88f5a2", hex_digest);
}
