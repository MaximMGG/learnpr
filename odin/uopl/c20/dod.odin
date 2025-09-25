package dod

import "core:fmt"
import "core:time"
import "core:mem"
import vmem "core:mem/virtual"

COUNT :: 1000000


Person :: struct {
    health: int,
    age: int,
}

first_variant :: proc() {
    people: [dynamic]^Person

    add_person :: proc(people: ^[dynamic]^Person, health: int, age: int) {
	p := new(Person)
	p^ = {
	    health = health,
	    age = age,
	}

	append(people, p)
    }

    for i in 0..<COUNT {
	add_person(&people, i + 10, i)
    }
}

second_variant :: proc() {
    people: [dynamic]Person

    add_person :: proc(people: ^[dynamic]Person, health, age: int) {
	append(people, Person{health = health, age = age})
    }

    for i in 0..<COUNT {
	add_person(&people, i + 10, i)
    }
}



main :: proc() {

    arena: vmem.Arena
    _ = vmem.arena_init_growing(&arena, 100 * mem.Megabyte)
    allocator := vmem.arena_allocator(&arena)
    context.allocator = allocator
    
    fmt.println("Start")
    fv_start_t := time.tick_now()
    first_variant()
    fv_end_t := time.tick_lap_time(&fv_start_t)
    fmt.printfln("First variant: %f", time.duration_milliseconds(fv_end_t))
    sv_start_t := time.tick_now()
    second_variant()
    sv_end_t := time.tick_lap_time(&sv_start_t)
    fmt.printfln("Second variant: %f", time.duration_milliseconds(sv_end_t))
    fmt.println("End")

    vmem.arena_destroy(&arena)
}
