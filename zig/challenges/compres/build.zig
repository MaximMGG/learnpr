const std = @import("std");




pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{.preferred_optimize_mode = .Debug});

    const exe = b.addExecutable(.{
        .name = "compres",
        .root_module = b.addModule("compres", .{
            .optimize = optimize,
            .target = target,
            .root_source_file = b.path("compres.zig"),
        })
    });

    const run_step = b.step("run", "Run application");
    const exe_step = b.addRunArtifact(exe);
    run_step.dependOn(&exe_step.step);

    b.installArtifact(exe);
}
