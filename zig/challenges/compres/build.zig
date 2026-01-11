const std = @import("std");


pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{.preferred_optimize_mode = .Debug});

    const exe = b.addExecutable(.{
        .name = "main",
        .use_llvm = true,
        .root_module = b.addModule("Exe", .{
            .root_source_file = b.path("main.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });


    const run_step = b.step("run", "Run application");
    const run_art = b.addRunArtifact(exe);
    run_step.dependOn(&run_art.step);

    b.installArtifact(exe);
}
