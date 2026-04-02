const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libfizzbuzz = b.addStaticLibrary(.{
        .name = "fizzbuzz",
        .root_source_file = b.path("fizzbuzz.zig"),
        .target = target,
        .optimize = optimize
    });

    const exe = b.addExecutable(.{
        .name = "demo",
        .root_source_file = b.path("main.zig"),
        .target = target,
        .optimize = optimize,

    });

    const run_step = b.step("run", "Running application");

    exe.linkLibrary(libfizzbuzz);
    b.installArtifact(libfizzbuzz);

    if (b.option(bool, "enable-demo", "install the demo too") orelse false) {
        b.installArtifact(exe);
        const run_art = b.addRunArtifact(exe);
        run_step.dependOn(&run_art.step);
    }
}
