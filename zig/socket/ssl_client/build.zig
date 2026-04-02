const std = @import("std");


pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "ssl_app",
        .root_source_file = b.path("main.zig"),
        .target = target,
        .optimize = optimize
    });

    exe.linkSystemLibrary("ssl");
    exe.linkSystemLibrary("crypto");
    exe.linkLibC();

    b.installArtifact(exe);

    const run_art = b.addRunArtifact(exe);
    const run_step = b.step("run", "run Application");
    run_step.dependOn(&run_art.step);
}
