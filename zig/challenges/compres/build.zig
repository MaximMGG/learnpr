const std = @import("std");


pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{.preferred_optimize_mode = .Debug});
    const main_module = b.addModule("Exe", .{
        .root_source_file = b.path("main.zig"),
        .target = target,
        .optimize = optimize,
    });


    const exe = b.addExecutable(.{
        .name = "main",
        .use_llvm = true,
        .root_module = main_module,
    });

    const test_exe = b.addTest(.{
        .root_module = main_module,
        .use_llvm = true,
        .name = "test",
    });


    const run_step = b.step("run", "Run application");
    const test_step = b.step("test", "Test application");
    const run_art = b.addRunArtifact(exe);
    const run_test = b.addRunArtifact(test_exe);
    run_step.dependOn(&run_art.step);
    test_step.dependOn(&run_test.step);

    b.installArtifact(exe);
}
