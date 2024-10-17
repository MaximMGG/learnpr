package using_odin

import "core:fmt"

Vector3 :: struct{x, y, z: f32}
Entity :: struct {
    position: Vector3,
    orientation: quaternion128,
}

Entity2 :: struct {
    using position: Vector3,
    orientation: quaternion128,
}

foo :: proc(entity: ^Entity) {
    fmt.println(entity.position.x, entity.position.y, entity.position.z)
}

foo2 :: proc(entity: ^Entity) {
    using entity
    fmt.println(position.x, position.y, position.z)
}

foo3 :: proc(using entity: ^Entity) {
    fmt.println(position.x, position.y, position.z)
}

foo4 :: proc(entity: ^Entity) {
    using entity.position
    fmt.println(x, y, z)
}

foo5 :: proc(entity: ^Entity2) {
    fmt.println(entity.x, entity.y, entity.z)
}

create_entity :: proc() -> ^Entity {
    e: ^Entity = new(Entity)
    e.position.x = 312
    e.position.y = 32
    e.position.z = 12
    e.orientation = 999999
    return e
}


test :: struct {
    a, b, c: int
}

main :: proc() {
    entity: Entity = {position={x=1,y=2,z=3}, orientation = 123}
    entity2 := Entity2{x = 1, y = 2, z = 3, orientation = 123}

    //ee := create_entity()

    foo(&entity)
    foo2(&entity)
    foo3(&entity)
    foo4(&entity)
    foo5(&entity2)
    //foo(ee)

    //free(ee)
    
    t: ^test = new(test)

    free(t)
}
