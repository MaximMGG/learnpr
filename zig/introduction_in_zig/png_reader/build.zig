const std = @import("std");



pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});
    const c = b.addTranslateC(.{
        .root_source_file = b.path("lib.h"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    c.linkSystemLibrary("spng", .{});

    const exe = b.addExecutable(.{
        .name = "png",
        .root_module = b.createModule(.{
            .root_source_file = b.path("main.zig"),
            .optimize = optimize,
            .target = target,
            .imports = &.{
                .{
                    .name = "c",
                    .module = c.createModule(),
                }
            }
        }),
    });

    const run_step = b.step("run", "Run the application");
    const run_art = b.addRunArtifact(exe);
    run_step.dependOn(&run_art.step);

    b.installArtifact(exe);
}
