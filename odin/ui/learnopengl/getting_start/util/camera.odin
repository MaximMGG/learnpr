package util

import math "core:math/linalg"
import "base:runtime"

CameraMovement :: enum {
  FORWARD, BACKWARD, LEFT, RIGHT
}

YAW :: f32(-90.0)
PITCH :: f32(0.0)
SPEED :: f32(2.5)
SENSITIVITY :: f32(0.1)
ZOOM :: f32(45.0)


Camera :: struct {
  position, front, up, right, worldUp: math.Vector3f32,
  yaw, pitch, movementSpeed, mouseSensitivity, zoom: f32
}

cameraCreate :: proc {
  cameraCreateVec,
  cameraCreateVal,
}

cameraCreateVec :: proc(position: math.Vector3f32 = math.Vector3f32{0.0, 0.0,
  0.0}, up: math.Vector3f32 = math.Vector3f32{0.0, 1.0, 0.0}, yaw: f32 = YAW,
  pitch: f32 = PITCH) -> Camera{
  camera: Camera
  camera.front = math.Vector3f32{0.0, 0.0, -1.0}
  camera.movementSpeed = SPEED
  camera.mouseSensitivity = SENSITIVITY
  camera.zoom = ZOOM
  camera.position = position
  camera.worldUp = up
  camera.yaw = yaw
  camera.pitch = pitch
  updateCameraVectors(&camera)
  return camera
}

cameraCreateVal :: proc(posX, posY, posZ, upX, upY, upZ, yaw, pitch: f32) ->
Camera {
  camera: Camera
  camera.front = math.Vector3f32{0.0, 0.0, -1.0}
  camera.movementSpeed = SPEED
  camera.mouseSensitivity = SENSITIVITY
  camera.zoom = ZOOM
  camera.position = math.Vector3f32{posX, posY, posZ}
  camera.worldUp = math.Vector3f32{upX, upY, upZ}
  camera.yaw = yaw
  camera.pitch = pitch
  updateCameraVectors(&camera)
  return camera
}

cameraGetViewMatrix :: proc(camera: ^Camera) -> math.Matrix4f32 {
  return math.matrix4_look_at(camera.position, camera.position + camera.front,
    camera.up)
}

cameraProcessKeyboard :: proc(camera: ^Camera, direction: CameraMovement, deltaTime: f32) {
  velocity: f32  = camera.movementSpeed * deltaTime
  if direction == .FORWARD {
    camera.position += camera.front * velocity
  }
  if direction == .BACKWARD {
    camera.position -= camera.front * velocity
  }
  if direction == .LEFT {
    camera.position -= camera.right * velocity
  }
  if direction == .RIGHT {
    camera.position += camera.right * velocity
  }
}

cameraProcessMouseMovement :: proc(camera: ^Camera, xoffset, yoffset: f32,
  constrainPitch: bool = true) {

  xoffset := xoffset * camera.mouseSensitivity
  yoffset := yoffset * camera.mouseSensitivity

  camera.yaw += xoffset
  camera.pitch += yoffset

  if constrainPitch {
    if camera.pitch > 89.0 {
      camera.pitch = 89.0 
    }
    if camera.pitch < -89.0 {
      camera.pitch = -89.0
    }
  }
  updateCameraVectors(camera)
}

cameraProcessMouseScroll :: proc(camera: ^Camera, yoffset: f32) {
  camera.zoom -= yoffset
  if camera.zoom < 1.0 {
    camera.zoom = 1.0
  }
  if camera.zoom > 45.0 {
    camera.zoom = 45.0
  }
}

@private
updateCameraVectors :: proc(camera: ^Camera) {
  front: math.Vector3f32
  front.x = math.cos(math.to_radians(camera.yaw)) * math.cos(math.to_radians(camera.pitch))
  front.y = math.sin(math.to_radians(camera.pitch))
  front.z = math.sin(math.to_radians(camera.yaw)) *
  math.cos(math.to_radians(camera.pitch))
  camera.front = math.normalize(front)
  camera.right = math.normalize(math.cross(camera.front, camera.worldUp))
  camera.up = math.normalize(math.cross(camera.right, camera.front))
}


