const Build = @import("std").Build;

pub fn build(b: *Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "app",
        .use_llvm = true,
        .root_module = b.createModule(.{
            .root_source_file = b.path("main.zig"),
            .optimize = optimize,
            .target = target,
            .link_libc = true,
        }),
    });

    exe.root_module.linkSystemLibrary("glfw", .{});
    exe.root_module.linkSystemLibrary("glad", .{});
    exe.root_module.linkSystemLibrary("m", .{});

    const run_exe = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run application");

    run_step.dependOn(&run_exe.step);

    b.installArtifact(exe);
}
