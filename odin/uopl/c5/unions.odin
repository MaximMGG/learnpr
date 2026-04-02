package unions

import "core:fmt"

My_Union :: union {
    f32,
    int,
    Person_Data,
}

Person_Data :: struct {
    health: int,
    age: int,
}


main :: proc() {
    val: My_Union = f32(2.4)
    p: My_Union = Person_Data{3, 2}
    fmt.println(val)
    fmt.println(p)
    fmt.println(size_of(val))

    switch v in val {
    case int:
	fmt.println("Int")
    case f32:
	fmt.println("f32")
    case Person_Data:
	fmt.println("Person_Data")
    }

    switch &v in val {
    case int:
	v = 12314
    case f32:
	v = 124.888
    case Person_Data:
	v = {health = 123, age = 888}
    }
    fmt.println(val)

    f32_val, f32_val_ok := val.(f32)

    if f32_val_ok {
	fmt.println("F32_val", val)
    }

    if fv, fv_ok := val.(f32); fv_ok {
	fmt.println("OK")
    }

    if fv, fv_ok := &val.(f32); fv_ok {
	fv^ = 99.123
    }
    fmt.println(val)

    shape: Shape

    fmt.println(shape)

    time: Maybe(int)
    fmt.println(time)
    time = 5
    fmt.println(time)
    if time_val, time_ok := time.?; time_ok {
	fmt.println("Time ok", time_val)
    }
    a_raw_union: My_Raw_Union
    fmt.println(a_raw_union)

    starting_position := [2]f32{0.1, 0.3}
    player_graphics := Texture{3, 4}

    player_entity := Entity {
	position = starting_position,
	texture = player_graphics,
    }
    fmt.println(player_entity)
}

Entity :: struct {
    position: [2]f32,
    texture: Texture,
    variant: Entity_Variant,
}

Entity_Player :: struct {
    can_jump: bool,
}

Entity_Rocket :: struct {
    time_in_space: f32,
}

Entity_Variant :: union {
    Entity_Player,
    Entity_Rocket,
}

Texture :: struct {
    x: int,
    y: int,
}

My_Raw_Union :: struct #raw_union {
    number: int,
    struct_val: My_Struct,
}

My_Struct :: struct {
    val: f32,
}

Maybe :: union($T: typeid) {
    T,
}

Shape :: union #no_nil {
    Shape_Circle,
    Shape_Square,
}

Shape_Circle :: struct {
    radius: f32,
}

Shape_Square :: struct {
    width: f32,
}
