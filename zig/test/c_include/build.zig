const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const translate_c = b.addTranslateC(.{
        .root_source_file = b.path("c.h"),
        .target = target,
        .optimize = optimize,
    });
    translate_c.linkSystemLibrary("glfw", .{});
    translate_c.linkSystemLibrary("glad", .{});

    const exe = b.addExecutable(.{
        .name = "app",
        .root_module = b.createModule(.{
            .root_source_file = b.path("main.zig"),
            .optimize = optimize,
            .target = target,
        })
    });

    exe.root_module.addImport("c", translate_c.createModule());

    const run_step = b.step("run", "Run application");
    const run_exe = b.addRunArtifact(exe);
    run_step.dependOn(&run_exe.step);

    b.installArtifact(exe);
}
