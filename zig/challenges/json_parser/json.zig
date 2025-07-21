const std = @import("std");

const json = struct {

    const json_obj_type = enum {
        NUMBER, STRING, BOOL, ARRAY, OBJ, NULL
    };

    const json_obj = struct {
        type: json_obj_type = undefined,
        key: []const u8,

        val: union(json_obj_type) {
            num: u32,
            str: []u8,
            _bool: bool,

        },
    };

    fn ini() void {

        const j: json_obj = undefined;
        switch(j.val) {
            .NUMBER => {

            },

        }
    }

};
