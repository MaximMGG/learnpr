const std = @import("std");


pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const translate_c = b.addTranslateC(.{
        .root_source_file = b.path("c.h"),
        .optimize = optimize,
        .target = target,
    });

    translate_c.linkSystemLibrary("ssl", .{});
    translate_c.linkSystemLibrary("crypto", .{});
    const c_module = translate_c.createModule();

    const exe = b.addExecutable(.{
        .name = "ssl_test",
        .root_module = b.createModule(.{
            .root_source_file = b.path("main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{
                    .name = "ssl",
                    .module = c_module,
                },
            }
        }),
    });

    b.installArtifact(exe);

    const run_art = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run application");
    run_step.dependOn(&run_art.step);

}
