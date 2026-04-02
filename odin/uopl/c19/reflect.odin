package reflect_test

import "core:fmt"
import "core:reflect"


Cat_Color :: enum {
    None,
    Tabby,
    Orange,
    Calico,
}


main :: proc() {
    color_name := "Orange"
    if color, ok := reflect.enum_from_name(Cat_Color, color_name); ok {
	fmt.println(int(color), color)
    }
}
