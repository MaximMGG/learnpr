const std = @import("std");

const file_name = "test.inc";

const item = struct {
    name: []u8,
    current_consumption: u32,
    limit: u32,
    difference: i32,


    fn print(self: *item) void {

        std.debug.print("name: {s}, current_consumption: {d}, limit: {d}, difference: {d}", 
            .{self.name, self.current_consumption, self.limit, self.difference});
    }



};


pub fn main() void {
    const allocator = std.heap.page_allocator;

    const args = std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator);

    var list = std.ArrayList(*item).init(allocator);
    defer list.deinit();
        
    if (args.len == 1) {
        std.log.err("Bat useage", .{});
        return;
    }

    if (args[1][0] == 'r') {

        const f = try std.fs.cwd().openFile(file_name, .{.mode = .readonly});
        defer f.close();

        const r = f.reader();

        while(r.readStruct(item)) |t| {
            var tmp = try allocator.create(item);
            tmp = t;
            try list.append(tmp);
        } else |_| {

        }

        for(list.items) |i| {
            i.print();
            allocator.free(i);
        }

    } else if (args[1][0] == 'w') {
        const f = try std.fs.cwd().openFile(file_name, .{.mode = .write_only}) catch |err| {
            switch(err) {
                .FileNotFound => {
                    try std.fs.cwd().createFile(file_name, .{});
                },
                else => {unreachable;}
            }
        };
        defer f.close();

        while(true) {
            var t: item = undefined;
            std.debug.print("Enter the name: ", .{});


        }
    }

    return 0;
}
