const std = @import("std");

const json_obj_type = enum {
    NUMBER, STRING, BOOL, ARRAY, OBJ, NULL
};

const json_array = union(json_obj_type) {
    NUMBER: ?f64,
    STRING: ?[]u8,
    BOOL: ?bool,
    ARRAY: ?*json_array,
    OBJ: ?*json_obj,
    NULL: *usize
};

pub const json_obj = struct {
    key: []const u8 = undefined,
    val: union(json_obj_type) {
        NUMBER: f64,
        STRING: []u8,
        BOOL: bool,
        ARRAY: json_array,
        OBJ: *json_obj,
        NULL: ?*usize
    },

    content: []json_obj = undefined,
    size: u32,
    allocator: std.mem.Allocator,

    fn check_size(self: *json_obj) !void {
        if (self.size == self.content.len) {
            var new_cont = try self.allocator.alloc(json_obj, self.size * 2);
            @memcpy(new_cont[0..self.size], self.content);
            self.allocator.free(self.content);
            self.content = new_cont;
        }
    }

    fn skip_spaces(json: []const u8, i: *usize) void {
        while(json[i.*] == ' ' or json[i.*] == '\n') : (i.* += 1) {}
    }

    fn create_array(self: *json_obj, json: []u8, i: *usize) !void {

    }

    fn create_number(self: *json_obj, json: []u8, i: *usize) !void {

    }

    fn create_string(self: *json_obj, json: []u8, i: *usize) !void {

    }

    fn create_bool(self: *json_obj, json: []u8, i: *usize) !void {

    }

    fn create_json_obj(self: *json_obj, json: []u8, i: *usize) !void {
        skip_spaces(json, &i);
        if (json[i] != '{') return error.IncorrectJson;
        i += 1;
        skip_spaces(json, &i);

        while(i != json.len) : (i += 1){
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
                   self.content[self.size] = tmp;
                   try self.check_size();
                },
                '[' => {
                    try tmp.create_array(json, i);
                    self.content[self.size] = tmp;
                    try self.check_size();
                },
                '"' => {
                    try tmp.create_string(json, i);
                    self.content[self.size] = tmp;
                    try self.check_size();
                },
                '0'...'9' => {
                    try tmp.create_number(json, i);
                    self.content[self.size] = tmp;
                    try self.check_size();
                },
                't' or 'f' => {
                    try tmp.create_bool(json, i);
                    self.content[self.size] = tmp;
                    try self.check_size();
                },
                'n' => {
                    tmp.val.NULL = null;
                    self.content[self.size] = tmp;
                    try self.check_size();
                },
                else => {
                    return error.IncorrectJson;
                }
            }
        }
        if (json[i] != ',') {
            return;
        }
    }

    pub fn init(allocator: std.mem.Allocator, json: []const u8) !json_obj {
        var main: *json_obj = try allocator.create(json_obj);
        main.key = "";
        main.content = try allocator.alloc(json_obj, 10);
        main.allocator = allocator;

        var i: usize = 0;

        try main.create_json_obj(json, &i);
    }

    pub fn deinit(self: *json_obj) void {

    }
};
