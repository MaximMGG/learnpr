const std = @import("std");


pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .name = "task",
        .root_module = b.addModule("task", .{
            .optimize = optimize,
            .target = target,
            .root_source_file = b.path("shader_task.zig"),
        }),
    });

    exe.linkLibC();
    exe.linkSystemLibrary("GL");
    exe.linkSystemLibrary("glfw");
    exe.linkSystemLibrary("GLEW");

    const run_step = b.step("run", "Run application");
    const run_exe = b.addRunArtifact(exe);
    run_step.dependOn(&run_exe.step);

    b.installArtifact(exe);
}
