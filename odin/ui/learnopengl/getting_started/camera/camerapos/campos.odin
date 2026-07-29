package camerapos

import la "core:math/linalg"


CameraMovement :: enum {
  FORWARD,
  BACKWARD,
  LEFT,
  RIGHT
}

YAW         : f32 : -90.0
PITCH       : f32 : 0.0
SPEED       : f32 : 2.5
SENSITIVITY : f32 : 0.1
ZOOM        : f32 : 45.0


Camera :: struct {
  position: la.Vector3f32,
  front: la.Vector3f32,
  up: la.Vector3f32,
  right: la.Vector3f32,
  world_up: la.Vector3f32,
  yaw, pitch, movement_speed, sensitivity, zoom: f32
}


create_camera :: proc {
  create_camera_vector,
  create_camera_float
}

create_camera_vector :: proc(position: la.Vector3f32 = la.Vector3f32{0.0, 1.0, 0.0},
                             up: la.Vector3f32 = la.Vector3f32{0.0, 1.0, 0.0},
                             yaw: f32 = YAW, pitch: f32 = PITCH) -> Camera {
  c := Camera{
    position = position,
    world_up = up,
    yaw = yaw,
    pitch = pitch,
    front = la.Vector3f32{0.0, 0.0, -1.0},
    movement_speed = SPEED,
    zoom = ZOOM,
    sensitivity = SENSITIVITY,
  }
  update_camera_vectors(&c)
  return c
}

create_camera_float :: proc(posx, posy, posz, upx, upy, upz, yaw, pitch: f32) -> Camera {
  c := Camera{
    position = la.Vector3f32{posx, posy, posz},
    world_up = la.Vector3f32{upx, upy, upz},
    yaw = yaw,
    pitch = pitch,
    front = la.Vector3f32{0.0, 0.0, -1.0},
    movement_speed = SPEED,
    zoom = ZOOM,
    sensitivity = SENSITIVITY,
  }
  update_camera_vectors(&c)
  return c
}

get_view_matrix :: proc(c: ^Camera) -> la.Matrix4f32 {
  return la.matrix4_look_at_f32(c.position, c.position + c.front, c.up)
}

process_keyboard :: proc(c: ^Camera, dir: CameraMovement, delta_time: f64) {
  velocity: f32 = c.movement_speed * f32(delta_time)
  switch dir {
  case .FORWARD:
    c.position += c.front * velocity
  case .BACKWARD:
    c.position -= c.front * velocity
  case .LEFT:
    c.position -= c.right * velocity
  case .RIGHT:
    c.position += c.right * velocity
  }
}

process_mouse_movement :: proc(c: ^Camera, xoffset, yoffset: f32, constraint_pitch: bool = true) {
  xoffset := xoffset
  yoffset := yoffset
  xoffset *= c.sensitivity
  yoffset *= c.sensitivity

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

@(private)
update_camera_vectors :: proc(c: ^Camera) {
  front: la.Vector3f32
  front.x = la.cos(la.to_radians(c.yaw)) * la.cos(la.to_radians(c.pitch))
  front.y = la.sin(la.to_radians(c.pitch))
  front.z = la.sin(la.to_radians(c.yaw)) * la.cos(la.to_radians(c.pitch))
  c.front = la.normalize(front)

  c.right = la.normalize(la.cross(c.front, c.world_up))
  c.up = la.normalize(la.cross(c.right, c.front))
}
