const std = @import("std");

const NodeU32 = struct {
    data: u32,
    node: std.SinglyLinkedList.Node = .{},
};

pub fn main() !void {
    var list: std.SinglyLinkedList = .{};
    var one: NodeU32 = .{.data = 1};
    var two: NodeU32 = .{.data = 2};
    var three: NodeU32 = .{.data = 3};
    var four: NodeU32 = .{.data = 4};
    var five: NodeU32 = .{.data = 5};
    
    list.prepend(&two.node);
    list.prepend(&five.node);
    list.prepend(&three.node);
    list.prepend(&one.node);
    list.prepend(&four.node);

    var it = list.first;

    while(it) |node| : (it = node.next) {
        const l: *NodeU32 = @fieldParentPtr("node", node);

        std.debug.print("Current value: {}\n", .{l.data});
    }
}
