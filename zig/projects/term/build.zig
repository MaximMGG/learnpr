const std = @import("std");



pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const translate_c = b.addTranslateC(.{
        .root_source_file = b.path("src/c.h"),
        .target = target,
        .optimize = optimize
    });

    const exe = b.addExecutable(.{
        .name = "term",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .optimize = optimize,
            .target = target,
            .imports = &.{
                .name = "c",
                .module = translate_c.createModule(),
            },
        })
    });
    b.installArtifact(exe);

    const run_exe = b.addRunArtifact();
    const run_step = b.step("run", "Run the Application");
    run_step.dependOn(&run_exe);
}
