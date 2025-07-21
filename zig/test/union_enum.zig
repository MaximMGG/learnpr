const std = @import("std");


const json_type = enum {
    NUMBER, STRING, BOOL, JSON_OBJ, ARRAY, NULL
};


    const json_arr = struct {

    };

    const json_obj = struct {
        type: json_type,
        key: []u8,

        val: union(json_type) {
            NUMBER: f64,
            STRING: []u8,
            BOOL: bool,
            JSON_OBJ: *json_obj,
            ARRAY: *json_arr,
            NULL: *usize
        },

        pub fn print_type(self: *json_obj) void {
            switch(self.val) {
                .NUMBER => {
                    std.debug.print("Number\n", .{});
                },
                .STRING => {
                    std.debug.print("String\n", .{});
                },
                .BOOL => {
                    std.debug.print("Bool\n", .{});
                },
                .JSON_OBJ => {
                    std.debug.print("json obj\n", .{});
                },
                .ARRAY => {
                    std.debug.print("array\n", .{});
                },
                .NULL => {
                    std.debug.print("null\n", .{});
                },
            }
        }
    };



pub fn main() void {
    var j: json_obj = .{.key = "", .type = .NUMBER, .val = .{.NUMBER = @as(f64, 123123)}};
    j.print_type();
}
