package arena_allocator

import "core:fmt"
import "core:os"

import vmem "core:mem/virtual"

load_files :: proc() -> ([]string, vmem.Arena) {
    arena: vmem.Arena
    arena_err := vmem.arena_init_growing(&arena)
    ensure(arena_err == nil)
    arena_alloc := vmem.arena_allocator(&arena)

    f1, f1_ok := os.read_entire_file("test1.txt", arena_alloc)
    ensure(f1_ok)

    f2, f2_ok := os.read_entire_file("test2.txt", arena_alloc)
    ensure(f2_ok)

    f3, f3_ok := os.read_entire_file("test3.txt", arena_alloc)
    ensure(f2_ok)

    res := make([]string, 3, arena_alloc)

    res[0] = string(f1)
    res[1] = string(f2)
    res[2] = string(f3)

    return res, arena
}

main :: proc() {
    files, arena := load_files()

    for f in files {
        fmt.println(f)
    }

    vmem.arena_destroy(&arena)
}
