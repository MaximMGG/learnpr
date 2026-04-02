const std = @import("std");


pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .name = "base64",
        .root_source_file = b.path("./main.zig"),
        .target = target,
        .optimize = optimize
    });


    const run_art = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_art.step);


    b.installArtifact(exe);

}
