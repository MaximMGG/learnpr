package camera

import la "core:math/linalg"


Vec3 :: la.Vector3f32
Mat4 :: la.Matrix4x4f32

YAW         : f32 : -90.0
PITCH       : f32 : 0.0
SPEED       : f32 : 2.5
SENSITIVITY : f32 : 0.1
ZOOM        : f32 : 45.0

Camera_Movement :: enum {
  FORWARD, BACKWARD, LEFT, RIGHT
}

Camera :: struct {
  position, front, up, right, world_up: Vec3,
  yaw, pitch, movement_speed, mouse_sensitivity, zoom: f32,
}


@(private)
update_camera_vectors :: proc(c: ^Camera) {
  front: Vec3
  front.x = la.cos(la.to_radians(c.yaw)) * la.cos(la.to_radians(c.pitch))
  front.y = la.sin(la.to_radians(c.pitch))
  front.z = la.sin(la.to_radians(c.yaw)) * la.cos(la.to_radians(c.pitch))
  c.front = la.normalize(front)
  c.right = la.normalize(la.cross(c.front, c.world_up))
  c.up = la.normalize(la.cross(c.right, c.front))
}

create :: proc {
  create_vec3,
  create_val
}

create_vec3 :: proc(position: Vec3 = Vec3{0.0, 0.0, 0.0}, up: Vec3 = Vec3{0.0, 1.0, 0.0}, yaw := YAW, pitch := PITCH) -> Camera{
  c := Camera{
    front = Vec3{0.0, 0.0, -1.0},
    movement_speed = SPEED,
    mouse_sensitivity = SENSITIVITY,
    zoom = ZOOM,
    position = position,
    world_up = up,
    pitch = pitch,
    yaw = yaw
  }
  update_camera_vectors(&c)
  return c
}

create_val :: proc(posx, posy, posz: f32, upx, upy, upz: f32, yaw := YAW, pitch := PITCH) -> Camera {
  c := Camera{
    front = Vec3{0.0, 0.0, -1.0},
    movement_speed = SPEED,
    mouse_sensitivity = SENSITIVITY,
    zoom = ZOOM,
    position = Vec3{posx, posy, posz},
    world_up = Vec3{upx, upy, upz},
    pitch = pitch,
    yaw = yaw
  }
  update_camera_vectors(&c)
  return c
}

process_keyboard :: proc(c: ^Camera, direction: Camera_Movement, delta_time: f32) {
  velocity := c.movement_speed * delta_time
  if direction == .FORWARD {
    c.position += c.front * velocity
  }
  if direction == .BACKWARD {
    c.position -= c.front * velocity
  }
  if direction == .LEFT {
    c.position -= c.right * velocity
  }
  if direction == .RIGHT {
    c.position += c.right * velocity
  }
}

process_mouse_movement :: proc(c: ^Camera, xoffset, yoffset: f32, constraint_pitch: bool = true) {
  xoffset := xoffset * c.mouse_sensitivity
  yoffset := xoffset * c.mouse_sensitivity

  c.yaw += xoffset
  c.pitch += yoffset

  if constraint_pitch {
    if c.pitch > 89.0 {
      c.pitch = 89.0
    }
    if c.pitch < -89.0 {
      c.pitch = -89.0
    }
  }
  update_camera_vectors(c)
}

process_mouse_scroll :: proc(c: ^Camera, yoffset: f32) {
  c.zoom -= yoffset
  if c.zoom < 1.0 {
    c.zoom = 1.0
  }
  if c.zoom > 45.0 {
    c.zoom = 45.0
  }
}

get_view_matrix :: proc(c: ^Camera) -> Mat4 {
  return la.matrix4_look_at(c.position, c.position + c.front, c.up)
}

