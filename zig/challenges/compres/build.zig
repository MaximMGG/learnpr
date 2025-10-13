const std = @import("std");




pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .use_llvm = true,
        .name = "compres",
        .root_module = b.addModule("compres", .{
            .optimize = optimize,
            .target = target,
            .root_source_file = b.path("compres.zig"),
        })
    });
    //exe.linkLibC();

    const run_step = b.step("run", "Run application");
    const exe_step = b.addRunArtifact(exe);
    run_step.dependOn(&exe_step.step);

    b.installArtifact(exe);
}
