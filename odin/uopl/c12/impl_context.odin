package impl_context

import "core:fmt"
import "base:runtime"
import "core:log"
import "core:os"
import "core:math/rand"
import "core:time"
import "core:slice"

do_work :: proc() {
    make_lots_of_ints :: proc(allocator := context.allocator) -> []int {
	ints := make([]int, 4096)

	for &v, idx in ints {
	    v = idx * 4
	}

	return ints
    }

    my_ints := make_lots_of_ints(context.temp_allocator)

    delete(my_ints)
    fmt.println("We are here!")
}

main :: proc() {
    //do_work()
    //two()
    //three()
    //four()
    //five()
    six()
}

assert_fail :: proc(prefix, message: string, loc := #caller_location) -> ! {
    fmt.printfln("Oh no, an assertion at line: %v", loc)
    fmt.println(message)
    runtime.trap()
}

two :: proc() {
    context.assertion_failure_proc = assert_fail
    number := 5
    assert(number == 7, "Number has wrong value")
}

three :: proc() {
    context.logger = log.create_console_logger()
    defer log.destroy_console_logger(context.logger)

    log.info("Program stared")

    log.info("Program finished")
}


some_work :: proc() {
    log.info("Some work beggins here")
}

some_end_work :: proc() {
    log.info("Some work ends here")
}


four :: proc() {
    mode: int = 0

    when ODIN_OS == .Linux || ODIN_OS == .Darwin {
	mode = os.S_IRUSR | os.S_IWUSR | os.S_IRGRP | os.S_IROTH
    }

    logh, logh_err := os.open("log.txt", (os.O_CREATE | os.O_TRUNC | os.O_RDWR), mode)
    if logh_err == os.ERROR_NONE {
	os.stdout = logh
	os.stderr = logh
    }

    logger := logh_err == os.ERROR_NONE ? log.create_file_logger(logh) :
	log.create_console_logger()
    context.logger = logger

    some_work()
    some_end_work()

    if logh_err == os.ERROR_NONE {
	log.destroy_file_logger(logger)
    } else {
	log.destroy_console_logger(logger)
    }
}





five :: proc() {
    _, _, t := time.clock_from_time(time.now())
    random_state := rand.create(u64(t))
    context.random_generator = runtime.default_random_generator(&random_state)

    fmt.println(rand.int_max(100))
}

numbers := []int {2, 7, 42, 1}

Sort_Setting :: struct {
    put_at_end: int,
}

sorting_proc :: proc(i, j: int) -> bool {
    sort_setting := (^Sort_Setting)(context.user_ptr)

    if sort_setting != nil {
	if i == sort_setting.put_at_end {
	    return false
	}

	if j == sort_setting.put_at_end {
	    return true
	}
    }
    return i < j
}

sort_settings := Sort_Setting {
    put_at_end = 2,
}

six :: proc() {
    context.user_ptr = &sort_settings
    slice.sort_by(numbers, sorting_proc)
    fmt.println(numbers)
}

