const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const exe = b.addExecutable(.{ 
        .name = "hello", 
        .root_source_file = b.path("main.zig"), 
        .target = target,
        .optimize = .ReleaseSafe, 
        .version = 
            .{ .major = 0, .minor = 0, .patch = 1 }
    });

    const test_exe = b.addTest(.{
        .name = "unit_test",
        .root_source_file = b.path("main.zig"),
        .target = target,
    });

    b.installArtifact(test_exe);
    b.installArtifact(exe);
    const run = b.addRunArtifact(exe);
    const run_arti_test = b.addRunArtifact(test_exe);

    const run_step = b.step("run", "Run the project");
    const run_test_step = b.step("tests", "Run unit tests");
    run_step.dependOn(&run.step);
    run_test_step.dependOn(&run_arti_test.step);
}
