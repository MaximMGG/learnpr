const std = @import("std");

const PATH_TO_FILE = "/home/{s}/.config/inc_file.inc";

fn checkIncFile() !void {
    const allocator = std.heap.page_allocator;

    var env = try std.process.getEnvMap(allocator);
    defer env.deinit();
    const user = env.get("USER").?;

    var buf: [128]u8 = .{0} ** 128;

    const path = try std.fmt.bufPrint(&buf, PATH_TO_FILE, .{user});

    if (std.posix.access(path, std.c.F_OK)) {
        return;
    } else |_| {
        const f = try std.fs.createFileAbsolute(path, .{});
        f.close();
    }
}


pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "inc",
        .root_module = exe_mod,
    });

    exe.linkSystemLibrary("ncurses");
    exe.linkLibC();
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    try checkIncFile();

}
