const std = @import("std");


pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode =  .Debug});
    const target = b.standardTargetOptions(.{});

    const exe_module = b.createModule(.{
        .root_source_file = b.path("app.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "app",
        .root_module = exe_module,
    });

    exe.linkSystemLibrary("GL");
    exe.linkSystemLibrary("glfw");
    exe.linkSystemLibrary("GLEW");
    exe.linkLibC();
    b.installArtifact(exe);

    const cmd_run = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run application");
    run_step.dependOn(&cmd_run.step);

}
