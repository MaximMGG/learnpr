const std = @import("std");
const ArrayList = std.ArrayList;
const TokenType = @import("enums.zig").TokenType;


pub const ParseData = struct {
    token_list: *ArrayList(Token),
    last_token: ?Token = null,
    character_index: usize = 0,
    code: []const u8 = "",
    line_count: usize = 0,
    char_count: usize = 0,
    was_comment: bool = false,
};

pub const Token = struct {
    text: []const u8,
    type: TokenType,
    line_number: usize,
    char_number: usize,


    pub fn printValues(self: *Token) void {
        std.debug.print("Token values:\n text: '{s}'\n type: {}\n line no: {d}\n", 
            .{self.text, self.type, self.line_number});
    }

    pub fn isType(self: *const Token, token_type: TokenType) bool {
        return self.type == token_type;
    }

};

