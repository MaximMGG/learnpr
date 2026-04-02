const std = @import("std");
const Allocator = std.mem.Allocator;
const ParseError = @import("../core/errors.zig").ParseError;
const Printing = @import("../core/printing.zig");
const Structs = @import("../core/structs.zig");
const Token = Structs.Token;
const ParseData = Structs.ParseData;
const ArrayList = std.ArrayList;


pub fn parseToTokens(code: []const u8, allocator: Allocator) !*std.ArrayList(Token) {
    std.debug.print("\t{s}Parseing{s}\t\t\t\t", .{Printing.GREY, Printing.RESET});

    const token_list = try allocator.create(ArrayList(Token));
    token_list.* = try ArrayList(Token).initCapacity(allocator, 0);

    var parse_data = ParseData {
        .code = code,
        .token_list = token_list,
    };

    if (parse_data.code.len == 0) {
        return ParseError.CodeLengthIsZero;
    }

    const STRING_LENGTH: usize = code.len;
    while(parse_data.character_index < STRING_LENGTH) {
        // try processCharacter(&parse_data, allocator);

    }

    std.debug.print("{s}Done{s}\n", .{Printing.CYAN, Printing.RESET});

    return token_list;
}
