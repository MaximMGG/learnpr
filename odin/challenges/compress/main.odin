package compress


import "core:fmt"
import "core:os"
import "core:slice"
import pq "core:container/priority_queue"

Node :: struct {
    val: u8,
    weight: u32,
    leaf: bool,
    left: Node,
    rigth: Node,
};

Pair :: struct {
    val: u8,
    count: u32,
};

less :: proc(a, b: Node) -> bool {
    if a.weight > b.weight do return false;

    return true;
}


main :: proc() {
    file, _ := os.open("test2.txt", os.O_RDONLY)
    defer os.close(file)
    fi, _ := os.fstat(file)
    buf := make([]u8, fi.size)
    defer delete(buf)

    read_bytes, _ := os.read(file, buf)
    if read_bytes != fi.size {
        fmt.eprintln("read bytes not equalse file size")
        return
    }

    pairs: [dynamic]u8


}
