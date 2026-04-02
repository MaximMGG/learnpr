
const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .name = "token",
        .use_llvm = true,
        .root_module = b.addModule("Sub module", .{
            .optimize = optimize,
            .target = target,
            .root_source_file = b.path("./main.zig")
        })
    });


    exe.linkLibC();
    exe.linkSystemLibrary("ssl");
    exe.linkSystemLibrary("crypto");
    exe.linkSystemLibrary("curses");
    
    const run_step = b.step("run", "Run whole application");
    const run_exe = b.addRunArtifact(exe);
    run_step.dependOn(&run_exe.step);


    b.installArtifact(exe);
}
