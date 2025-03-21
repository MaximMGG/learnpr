const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "app",
        .root_source_file = b.path("app.zig"),
        .target = target,
        .optimize = optimize
    });

    const version = b.option([]const u8, "version", "application version string") orelse "0.0.0";
    const enable_foo = detectWhetherToEnableLibFoo();
    const who_builder = b.option([]const u8, "who_builder", "show, who is run zig build command") orelse "Non";

    const options = b.addOptions();

    options.addOption([]const u8, "version", version);
    options.addOption(bool, "have_libfoo", enable_foo);
    options.addOption([]const u8, "who_builder", who_builder);

    exe.root_module.addOptions("config", options);

    b.installArtifact(exe);
    const run_a = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run application");

    run_step.dependOn(&run_a.step);
}


fn detectWhetherToEnableLibFoo() bool {
    return false;
}
