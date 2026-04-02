const std = @import("std");



pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .name = "png",
        .root_source_file = b.path("main.zig"),
        .target = target,
        .optimize = optimize
    });

    exe.linkLibC();
    exe.linkSystemLibrary("spng");

    const run_step = b.step("run", "Run the application");
    const run_art = b.addRunArtifact(exe);
    run_step.dependOn(&run_art.step);

    b.installArtifact(exe);
}
