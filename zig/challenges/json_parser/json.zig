const std = @import("std");


const json_obj_val_type = enum {
    NUMBER, STRING, BOOL, NULL, ARRAY, OBJ
};


pub const json_obj = struct {
    key: []const u8 = undefined,
    arr_key: u32 = undefined,

    val: union(json_obj_val_type) {
        NUMBER: f64,
        STRING: []u8,
        BOOL: bool,
        NULL: ?*usize,
        ARRAY: *json_obj,
        OBJ: *json_obj
    },

    content: std.ArrayList(*json_obj) = undefined,

    allocator: std.mem.Allocator,

    fn skip_spaces(json: []const u8, i: *usize) void {
        while(json[i.*] == ' ' or json[i.*] == '\n') : (i.* += 1) {}
    }

    fn create_array(self: *json_obj, json: []u8, i: *usize) !void {
        skip_spaces(json, i);

        switch(json[i.*]) {
            '{' => {

            },
            '"' => {

            },
            '0'...'9' => {

            },
            't' or 'f' => {

            },
            'n' => {

            },
            else => {
                return error.IncorrectJson;
            }
        }
    }

    fn create_number(self: *json_obj, json: []u8, i: *usize) !void {
        var buf: [128]u8 = .{0} ** 128;
        var buf_i: usize = 0;

        while((json[i.*] >= '0' and json[i.*] <= '9') or json[i.*] == '.') : (i.* += 1) {
            buf[buf_i] = json[i.*];
            buf_i += 1;
        }

        self.val.NUMBER = try std.fmt.parseFloat(f64, buf[0..buf_i]);
    }

    fn create_string(self: *json_obj, json: []u8, i: *usize) !void {
        var buf: [512]u8 = .{0} ** 512;
        var buf_i: usize = 0;

        while(json[i.*] != '"') : (i.* += 1) {
            buf[buf_i] = json[i.*];
            buf_i += 1;
        }
        i.* += 1;

        self.val.STRING = try self.allocator.dupe(buf[0..buf_i]);
    }

    fn create_bool(self: *json_obj, json: []u8, i: *usize) void {
        if (json[i.*] == 't') {
            self.val.BOOL = true;
            i.* += 4;
        } else if (json[i.*] == 'f') {
            self.val.BOOL = false;
            i.* += 5;
        }
    }

    fn create_json_obj(self: *json_obj, json: []u8, i: *usize) !void {
        skip_spaces(json, &i);
        if (json[i] != '{') return error.IncorrectJson;
        i += 1;

        while(i != json.len) : (i += 1){
            skip_spaces(json, &i);
            if (json[i] != '"') return error.IncorrectJson;
            var buf: [512]u8 = .{0} ** 512;
            var buf_i: usize = 0;
            while(json[i] != '"') : (i += 1) {
                buf[buf_i] = json[i];
                buf_i += 1;
            }
            var tmp: *json_obj = try self.allocator.create(json_obj);
            tmp.key = try self.allocator.dupe(u8, buf[0..buf_i]);

            i += 1;
            if (json[i] != ':') return error.IncorrectJson;
            skip_spaces(json, &i);

            switch(json[i]) {
                '{' => {
                    try tmp.create_json_obj(json, i);
                    try self.content.append(tmp);
                },
                '[' => {
                    try tmp.create_array(json, i);
                    try self.content.append(tmp);
                },
                '"' => {
                    try tmp.create_string(json, i);
                    try self.content.append(tmp);
                },
                '0'...'9' => {
                    try tmp.create_number(json, i);
                    try self.content.append(tmp);
                },
                't' or 'f' => {
                    tmp.create_bool(json, i);
                    try self.content.append(tmp);
                },
                'n' => {
                    tmp.val.NULL = null;
                    try self.content.append(tmp);
                },
                else => {
                    return error.IncorrectJson;
                }
            }
            if (json[i.*] != ',') {break;}
            else continue;
        }
    }

    pub fn init(allocator: std.mem.Allocator, json: []const u8) !json_obj {
        var main: *json_obj = try allocator.create(json_obj);
        main.key = "";
        main.content = std.ArrayList(*json_obj).init(allocator);
        main.allocator = allocator;

        var i: usize = 0;

        try main.create_json_obj(json, &i);
    }

    pub fn deinit(self: *json_obj) void {
        _ = self;

    }
};
