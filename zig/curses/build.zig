const std = @import("std");


pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .name = "cur_test",
        .root_source_file = b.path("cur_test13.zig"),
        .optimize = optimize,
        .target = target
    });

    exe.linkLibC();
    exe.linkSystemLibrary("ncurses");
    exe.linkSystemLibrary("panel");
    const run_exe = b.addRunArtifact(exe);
    const run_step = b.step("run", "run cur aplication");
    run_step.dependOn(&run_exe.step);
    
    b.installArtifact(exe);
}
