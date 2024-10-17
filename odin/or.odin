package or_else_odin

import "core:fmt"

main :: proc() {

    m := map[string]int {
        "Hello" = 3,
        "Bye" = 44
    }

    i: int
    ok: bool

    if i, ok = m["Hello"]; !ok {
        i = 123
    }

    i = m["QQQQ"] or_else 999

    assert(i == 999)

    fmt.println(two(44))

    main2()

}

Error :: enum {
    None,
    Critical_error,
    Something_Wrong
}

one :: proc(i: int) -> (int, Error) {
    if i < 10 && i > 0 {
        return i + 1, .None
    } else {
        return 0, .Critical_error
    }
}

two :: proc(i: int) -> Error {
    a: int
    a = one(i) or_return

    return .None
}


Job :: struct {
    id:         int,
    tasks_left: int,
    result:     int,
    error_has_occurred: bool,
}

do_work_until_done :: proc(job: ^Job) -> bool {
    if job.tasks_left == 0 {
        return false
    }

    job.result *= 3
    job.tasks_left -= 1
    return job.tasks_left == 0
}

tally :: proc(job: ^Job) -> (int, bool) {
    if job.error_has_occurred {
        return 0, false
    }
    return job.result, true
}

main2 :: proc() {
    jobs: [dynamic]Job
    append(&jobs, Job{id = 1,})
    append(&jobs, Job{id = 3, tasks_left = 2, result = 7})
    append(&jobs, Job{id = 5, tasks_left = 1, result = 5})
    append(&jobs, Job{id = 7, tasks_left = 1, result = 5, error_has_occurred = true})

    job_loop: for &job in jobs {
        do_work_until_done(&job)    or_continue job_loop
        result := tally(&job)       or_continue job_loop


        fmt.printfln("Job #%i has completed its work. Result is: %i", job.id, result)
    }

}





