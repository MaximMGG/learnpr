package load_json_unmarshal

import "core:os"
import "core:fmt"
import "core:encoding/json"


Game_Settings :: struct {
    window_width: i32,
    window_height: i32,
    window_title: string,
    rendering_api: string,
    renderer_settings: struct {
	msaa: bool,
	depth_testing: bool,
    },
}

main :: proc() {
    data, ok := os.read_entire_file("game_setting.json")

    if !ok {
	fmt.eprintln("Failed to load the file!")
	return
    }

    defer delete(data)
    settings: Game_Settings
    unmarshal_err := json.unmarshal(data, &settings)
    if unmarshal_err != nil {
	fmt.eprintln("Failed to unmarshal the file!")
	return
    }
    fmt.eprintln("Result %v\n", settings)
    delete(settings.window_title)
    delete(settings.rendering_api)
}
