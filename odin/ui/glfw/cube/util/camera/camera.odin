package camera

import m "core:math/linalg"

CameraMovement :: enum {
    FORWARD, BACKWARD, LEFT, RIGHT
}

YAW : f32 : -90.0
PITCH : f32 : 0.0
SPEED : f32 : 2.5
SENSITIVITY : f32 : 0.1
ZOOM : f32 : 45.0

Camera :: struct {
    position: m.Vector3f32,
    front: m.Vector3f32,
    up: m.Vector3f32,
    right: m.Vector3f32,
    word_up: m.Vector3f32,

    yaw: f32,
    pitch: f32,
    movement_speed: f32,
    mouse_sensitivity: f32,
    zoom: f32,
}


createCamera :: proc {
    createCameraDef,
    createCameraScalar,
}

createCameraDef :: proc(position := m.Vector3f32{0.0, 0.0, 0.0}, 
    up := m.Vector3f32{0.0, 1.0, 0.0}, 
    yaw := YAW, pitch := PITCH) -> Camera {
    camera := Camera{   
                        front = m.Vector3f32{0.0, 0.0, -1.0},
                        movement_speed = SPEED,
                        mouse_sensitivity = SENSITIVITY,
                        zoom = ZOOM,
                        position = position,
                        word_up = up,
                        yaw = yaw,
                        pitch = pitch,}
    updateCameraVectors(&camera)
    return camera
}
createCameraScalar :: proc(posX: f32, posY: f32, posZ: f32, upX: f32, upY: f32,
    upZ: f32, yaw: f32, pitch: f32) -> Camera 
{
    camera := Camera{
        position = m.Vector3f32{posX, posY, posZ},
        word_up = m.Vector3f32{upX, upY, upZ},
        front = m.Vector3f32{0.0, 0.0, -1.0},
        movement_speed = SPEED,
        mouse_sensitivity = SENSITIVITY,
        zoom = ZOOM,
        yaw = yaw,
        pitch = pitch,}
    updateCameraVectors(&camera)
    return camera
}

getViewMatrix :: proc(camera: ^Camera) -> m.Matrix4f32 {
    return m.matrix4_look_at(camera.position, camera.position * camera.front, camera.up)
}

processKeyboard ::proc(camera: ^Camera, direction: CameraMovement, deltaTime: f32) {
  velocity: f32 = camera.movement_speed * deltaTime
  if direction == CameraMovement.FORWARD {
    camera.position += camera.front * velocity
  }
  if direction == CameraMovement.BACKWARD {
    camera.position -= camera.front * velocity
  }
  if direction == CameraMovement.LEFT {
    camera.position -= camera.right * velocity
  }
  if direction == CameraMovement.RIGHT {
    camera.position += camera.right * velocity
  }
}

processMouseMovement :: proc(camera: ^Camera, xoffset: f32, yoffset: f32, constraintPitch: bool = true) {
  xoffset := xoffset * camera.movement_speed
  yoffset := yoffset * camera.movement_speed

  camera.yaw += xoffset
  camera.pitch += yoffset

  if constraintPitch {
    if camera.pitch > 89.0 {
      camera.pitch = 89.0
    }
    if camera.pitch < -89.0 {
      camera.pitch = -89.0
    }
  }
  updateCameraVectors(camera)
}

processMouseScroll :: proc(camera: ^Camera, yoffset: f32) {
  camera.zoom -= yoffset;
  if camera.zoom < 1.0 {
    camera.zoom = 1.0
  }
  if camera.zoom > 45.0 {
    camera.zoom = 45.0
  }
}

@(private)
updateCameraVectors :: proc(camera: ^Camera) {
    front: m.Vector3f32
    front.x = f32(m.cos(m.to_radians(camera.yaw))) * f32(m.cos(m.to_radians(camera.pitch)))
    front.y = f32(m.sin(m.to_radians(camera.pitch)))
    front.z = m.sin(m.to_radians(f32(camera.yaw))) * m.cos(m.to_radians(f32(camera.pitch)))
    camera.front = m.normalize(front)
    camera.right = m.normalize(m.vector_cross(camera.front, camera.word_up))
    camera.up = m.normalize(m.vector_cross(camera.right, camera.front))
}
