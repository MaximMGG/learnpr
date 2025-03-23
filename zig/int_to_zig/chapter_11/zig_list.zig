const std = @import("std");
const SinglyLinkedList = std.SinglyLinkedList;
const Lu32 = SinglyLinkedList(u32);

const Person = struct {
    name: []const u8,
    age: u8,
    height: f32
};



pub fn main() !void {
    var list = Lu32{};
    var one = Lu32.Node{.data = 1};
    var two = Lu32.Node{.data = 2};
    var three = Lu32.Node{.data = 3};
    var four = Lu32.Node{.data = 4};
    var five = Lu32.Node{.data = 5};

    list.prepend(&two);
    two.insertAfter(&five);
    list.prepend(&one);
    two.insertAfter(&three);
    three.insertAfter(&four);

    var tmp = list.first;

    while(tmp) |t| {
        std.debug.print("{d}\n", .{t.data});
        tmp = t.next;
    }

    std.debug.print("Multy array\n", .{});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var people = std.MultiArrayList(Person){};
    defer people.deinit(allocator);

    try people.append(allocator, .{.name = "Morge", .age = 9, .height = 123.4});
    try people.append(allocator, .{.name = "Asperine", .age = 59, .height = 144.4});
    try people.append(allocator, .{.name = "Bobby", .age = 28, .height = 100.4});

    for(people.items(.height)) |*h| {
        std.debug.print("{d}\n", .{h.*});
    }

}
