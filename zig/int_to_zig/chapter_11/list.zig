const std = @import("std");


pub fn List(comptime T: type) type {
    return struct {
        const Node = struct {
            next: ?*Node,
            prev: ?*Node,
            data: T
        };

        const Self = @This();

        head: ?*Node,
        tail: ?*Node,
        len: usize,
        allocator: std.mem.Allocator,

        pub fn init(allocator: std.mem.Allocator) Self {
            return .{
                .head = null,
                .tail = null,
                .len = 0,
                .allocator = allocator
            };
        }

        pub fn deinit(self: *Self) void {
            var tmp: ?*Node = self.head;
            while(tmp) |t| {
                var tmp2 = t.next;
                self.allocator.destroy(t);
                tmp = tmp2;
                _ = &tmp2;
            }
            self.len = 0;
            self.head = null;
            self.tail = null;
        }

        pub fn append(self: *Self, data: T) !void {
            if (self.len == 0) {
                var new_node: *Node = try self.allocator.create(Node);
                new_node.data = data;
                new_node.next = self.tail;
                new_node.prev = null;
                self.head = new_node;
            } else {
                var new_node: *Node = try self.allocator.create(Node);
                new_node.data = data;
                new_node.prev = self.tail;
                new_node.next = null;
                self.tail = new_node;
                if (self.len == 1) {
                    self.head.?.next = new_node;
                    new_node.prev = self.head;
                } else {
                    new_node.prev.?.next = new_node;
                } 
            }
            self.len += 1;
        }
    };
}
