package main


import "core:fmt"
import rl "vendor:raylib"
import b2 "vendor:box2d"

LENGTH_UNITS_PER_METER :: 256

main :: proc() {
    rl.InitWindow(1280, 720, "Box2D")
    defer rl.CloseWindow()

    rl.SetTargetFPS(144)

    b2.SetLengthUnitsPerMeter(LENGTH_UNITS_PER_METER)

    world := b2.DefaultWorldDef()
    
    world.gravity.y = LENGTH_UNITS_PER_METER * 9.80665 * 0.4
    world_id := b2.CreateWorld(world)
    defer b2.DestroyWorld(world_id)


    extent := b2.Vec2{128, 128}
    box_polygon := b2.MakeBox(extent.x, extent.y)
    box_body_def := b2.DefaultBodyDef()
    box_body_def.type = .dynamicBody
    box_body_def.position = {700, 300}
    box_body_def.rotation = b2.MakeRot(2*b2.PI * 0.125)
    bodyID := b2.CreateBody(world_id, box_body_def)
    defer b2.DestroyBody(bodyID)
    shape_def := b2.DefaultShapeDef()
    shape_id := b2.CreatePolygonShape(bodyID, shape_def, box_polygon)
    defer b2.DestroyShape(shape_id, true)

    
    for !rl.WindowShouldClose() {
	dt := rl.GetFrameTime()
	b2.World_Step(world_id, dt, 8)
	
	rl.BeginDrawing()
	rl.ClearBackground({128, 190, 255, 255})


	{
	    p := b2.Body_GetWorldPoint(bodyID, -extent)
	    rec := rl.Rectangle{
		p.x, p.y,
		extent.x, extent.y,
	    }
	    rotation := b2.Rot_GetAngle(b2.Body_GetRotation(bodyID))
	    rl.DrawRectanglePro(rec, extent * 0.5, rotation, {255, 128, 0, 255})
	}

	rl.EndDrawing()
    }
}
