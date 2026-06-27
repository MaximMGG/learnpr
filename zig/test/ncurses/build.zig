const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const translate_c = b.addTranslateC(.{
        .root_source_file = b.path("c.h"),
        .target = target,
        .optimize = optimize,
    });

    translate_c.linkSystemLibrary("curses", .{});

    const exe = b.addExecutable(.{
        .name = "hello",
        .root_module = b.createModule(.{ .root_source_file = b.path("main.zig"), .target = target, .optimize = optimize, .imports = &.{.{
            .name = "c",
            .module = translate_c.createModule(),
        }} }),
    });
    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);
    const run_step = b.step("run", "run app");
    run_step.dependOn(&run_exe.step);
}
