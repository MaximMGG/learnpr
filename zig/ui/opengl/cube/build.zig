const std = @import("std");


pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});


    const exe = b.addExecutable(.{
        .name = "cube",
        .use_llvm = true,
        .root_module = b.addModule("Module cube", .{
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("main.zig"),
        })
    });

    exe.linkSystemLibrary("glfw");
    exe.linkSystemLibrary("GL");
    exe.linkSystemLibrary("GLEW");

    const run_step = b.step("run", "Rune cube application");
    const run_exe = b.addRunArtifact(exe);

    run_step.dependOn(&run_exe.step);

    b.installArtifact(exe);
}
