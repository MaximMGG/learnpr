const std = @import("std");



pub const Shader = struct {

    pub fn init(alloator: std.mem.Allocator) type {
        return struct {
            This = @This,

        };
    }

};
