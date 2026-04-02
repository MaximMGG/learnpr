const std = @import("std");



pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .name = "tirm",
        .use_llvm = true,
        .root_module = b.addModule("root_module", .{
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("term.zig"),
        }),
    });

    exe.linkLibC();

    const run_step = b.step("run", "Run application");
    const exe_step = b.addRunArtifact(exe);

    run_step.dependOn(&exe_step.step);

    b.installArtifact(exe);
}
