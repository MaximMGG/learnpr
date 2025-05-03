const std = @import("std");



pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});


    const exe = b.addExecutable(.{
        .name = "fork",
        .root_source_file = b.path("fork_test.zig"),
        .optimize = optimize,
        .target = target,
    });

    exe.linkLibC();

    b.installArtifact(exe);
    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step("run", "run the application");

    run_step.dependOn(&run_cmd.step);
}
