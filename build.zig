const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("ez", .{
        .root_source_file = b.path("root.zig"),
    });

    const test_step = b.step("test", "Run unit tests");
    const tests = b.addTest(.{
        .root_source_file = b.path("root.zig"),
        .target = target,
        .optimize = optimize,
    });
    const run_tests = b.addRunArtifact(tests);
    test_step.dependOn(&run_tests.step);

    const all_step = b.step("all", "Build everything and runs all tests");
    all_step.dependOn(test_step);

    b.default_step.dependOn(all_step);
}
