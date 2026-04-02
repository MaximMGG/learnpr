package sep_aloc

import "core:fmt"
import "core:math/rand"
import "core:mem"
import "core:time"

Person :: struct {
    health: int,
    age: int,
}

NUM_ELEMS :: 100000
NUM_TEST_ITERS :: 10

make_person :: proc() -> Person {
    health := int(rand.int31_max(101))
    age := int(rand.int31_max(101))
    return {
	health = health,
	age = age,
    }
}

benchmark_scattered_array :: proc() -> f64 {
    people: [dynamic]^Person

    for i in 0..<NUM_ELEMS {
	p := new(Person)
	p^ = make_person()
	append(&people, p)
    }

    age_sum: int
    start := time.now()
    for i in 0..<NUM_TEST_ITERS {
        for &p in people {
            age_sum += p.age
        }
    }
    end := time.now()
    for i in people {
        free(i)
    }
    fmt.println("Scattered array age sum:", f32(age_sum)/(NUM_TEST_ITERS*NUM_ELEMS))

    delete(people)
    return time.duration_milliseconds(time.diff(start, end))
}

benchmark_tight_array :: proc() -> f64 {
    people: [dynamic]Person

    for i in 0..<NUM_ELEMS {
	p := make_person()
	append(&people, p)
    }

    age_sum: int
    start := time.now()
    for i in 0..<NUM_TEST_ITERS {
	for &p in people {
	    age_sum += p.age
	}
    }
    end := time.now()
    fmt.println("Tight array age sum:", f32(age_sum)/(NUM_TEST_ITERS*NUM_ELEMS))
    delete(people)
    return time.duration_milliseconds(time.diff(start, end))
}

main :: proc() {
    time_scattered := benchmark_scattered_array()
    time_tight := benchmark_tight_array()
    fmt.println("Scattered:", time_scattered)
    fmt.println("Tight:", time_tight)
    fmt.printfln("Cache friendly method is %.2f times faster", time_scattered/time_tight)
}
