const std = @import("std");


pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .use_llvm = true,
        .name = "way",
        .root_module = b.addModule("way_module", .{
            .optimize = optimize,
            .target = target,
            .root_source_file = b.path("waytask.zig"),
        }),
    });


    exe.linkLibC();
    exe.linkSystemLibrary("wayland-client");

    const run_step = b.step("run", "Run application");
    const exe_step = b.addRunArtifact(exe);
    run_step.dependOn(&exe_step.step);

    b.installArtifact(exe);
}
