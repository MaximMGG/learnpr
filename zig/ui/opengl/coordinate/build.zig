const std = @import("std");


pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{
        .name = "coordiante",
        .root_module = b.createModule(.{
            .root_source_file = b.path("main.zig"),
            .optimize = optimize,
            .target = target,
        })
    });

    exe.root_module.linkSystemLibrary("glfw", .{});
    exe.root_module.linkSystemLibrary("glad", .{});

    const run_exe = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run application");

    run_step.dependOn(&run_exe.step);

    b.installArtifact(exe);
}
