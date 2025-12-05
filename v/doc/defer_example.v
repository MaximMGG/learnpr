import os


enum State {
	normal
	write_log
	return_error
}

fn write_log(s State) !int {
	mut f := os.create("log.txt")!
	defer {f.close()}
	if s == .write_log {

		return f.writeln("This is a log file")
	} else if s == .return_error {
		return error("Nothing written; file open: ${f.is_opened}")
	}
	return 0
}

fn main() {
	n := write_log(.write_log) or {
		println("Error: ${err}")
		0
	}
	println("${n} bytes written")

	res_defer()
	println("Defer loop")
	defer_in_loop()
	println("goto example")
	goto_example()
}


fn res_defer() int {
	defer {
		if $res() > 100 {
			println("Defer state > 100")
		} else {
			println("Defer state < 100")
		}
	}

	return 0
}

fn defer_in_loop() {
	defer {println("Func finish")}
	println("Loop start")
	for i in 1..4 {
		defer {println("Deferred execution for ${i}. Defer 1.")}
		defer {println("Deferred execution for ${i}. Defer 2.")}
		defer {println("Deferred execution for ${i}. Defer 3.")}
		println("Loop iteration: ${i}")
	}
	println("Loop done.")
}

fn goto_example() {
	i := 2
	if i > 0 {
		if i == 2 {
			unsafe {
				goto end
			}
		} else {
			unsafe {
				goto not_end
			}
		}
	}
not_end:
	println("Here not end")
end:
	println("Here end")
}


