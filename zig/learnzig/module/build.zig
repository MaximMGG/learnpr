const std = @import("std");


pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});


    const calc_module = b.addModule("calc", .{
        .root_source_file = .{.src_path = "test/add.zig"},
    });
    const exe = b.addExecutable(.{
        .name = "main",
        .target = target,
        .optimize = optimize,
        .root_source_file = .{.src_path = "main.zig"}
    });
}
