package load_json

import "core:fmt"
import "core:encoding/json"

import "core:os"

main :: proc() {

    data, ok := os.read_entire_file("game_setting.json")
    if !ok {
	fmt.eprintln("Failed to load the file")
	return
    }

    defer delete(data)

    json_data, err := json.parse(data)

    if err != .None {
	fmt.eprintln("Failed to parse the json file.")
	fmt.eprintln("Error:", err)
    }
    defer json.destroy_value(json_data)

    root := json_data.(json.Object)

    fmt.println("Root:")
    fmt.println(
	"window_width:",
	root["window_width"],
	"window_heigth:",
	root["window_height"],
	"window_title:",
	root["window_title"],
    )
    fmt.println("rendering_api:", root["rendering_api"])

    window_width := root["window_width"].(json.Float)
    fmt.println("window_width:", window_width)

    fmt.println("")

    fmt.println("Renderer Settings:")
    renderer_settings := root["renderer_settings"].(json.Object)
    fmt.println("msaa:", renderer_settings["msaa"])
    fmt.println("depth_testing:", renderer_settings["depth_resting"])
}
