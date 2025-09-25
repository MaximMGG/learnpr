package error_handling

import "core:fmt"
import "core:os"
import "core:encoding/json"
import "core:log"
import "core:flags"

Cat :: struct {
    name: string,
    age: int,
}

find_cat_with_name :: proc(cats: []Cat, name: string) -> (Cat, bool) {
    for c in cats {
	if c.name == name {
	    return c, true
	}
    }
    return {}, false
}


one :: proc() {
    cats := [3]Cat{{name = "Molly", age = 1}, {name = "Billy", age = 3},
		   {name = "Candy", age = 7}}

    cat, cat_ok := find_cat_with_name(cats[:], "Molly")
    if cat_ok {
	fmt.printfln("Found %v! It is %v years old.", cat.name, cat.age)
    } else {
	fmt.printfln("%s do not find", "Molly")
    }

    cat, cat_ok = find_cat_with_name(cats[:], "QQQ")
    if cat_ok {
	fmt.printfln("Found %v! It is %v years old.", cat.name, cat.age)
    } else {
	fmt.printfln("%s do not find", "QQQ")
    }

}

Load_Config_Error :: enum {
    None,
    File_Unreadable,
    Invalid_Format,
}

DEFAULT_CONFIG :: Config {
    fullscreen = false,
    window_position = {100, 100}
}


Config :: struct {
    fullscreen: bool,
    window_position: [2]int,
}

load_config :: proc(filename: string) -> (Config, Load_Config_Error) {
    config_data, config_data_ok := os.read_entire_file(filename, context.temp_allocator)
    log.info("read config data:\n", string(config_data[:]))
    if !config_data_ok {
	return {}, .File_Unreadable
    }

    result: Config

    json_error := json.unmarshal(config_data, &result, allocator = context.temp_allocator)

    if json_error != nil {
	return {}, .Invalid_Format
    }
    log.info("read json")
    return result, .None
}

two :: proc() {
    logger := log.create_console_logger()
    context.logger = logger

    log.info("Start work")
    config := load_config("config.json") or_else DEFAULT_CONFIG

    log.info("Work is done")
    fmt.println(config)

    log.destroy_console_logger(context.logger)
}

Help_Request :: distinct bool
Validation_Error :: struct {
    message: string,
}
Parse_Error :: int
Open_File_Error :: i32

Error :: union {
    Parse_Error,
    Open_File_Error,
    Help_Request,
    Validation_Error,
}


divide_and_double :: proc(a, b: $T) -> (T, bool) #optional_ok {
    if a == 0 {
	return 0, false
    }

    return (a/b) * 2, true
}

three :: proc() {
    num := divide_and_double(0, 5) or_else 123
    fmt.println(num)
}

main :: proc() {
    //one()
    //two()
    three()
}
