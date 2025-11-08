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
    updateCameraVectors(camera)
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
    updateCameraVectors(camera)
    return camera
}

getViewMatrix :: proc() -> m.Matrix4f32 {

}

processKeyboard ::proc(direction: CameraMovement, deltaTime: f32) {

}


@(private)
updateCameraVectors :: proc(camera: Camera) {
    front: m.Vector3f32
    front.x = f32(m.cos(m.to_radians(camera.yaw))) * f32(m.cos(m.to_radians(camera.pitch)))
    front.y = f32(m.sin(m.to_radians(camera.pitch)))
    front.z = f32(m.sin(m.to_radians(camera.yaw))) * f32(m.cos(m.to_raians(camera.pitch)))
    camera.front = m.normalize(front)
    camera.right = m.normalize(m.vector_cross(camera.front, camera.word_up))
    camera.up = m.normalize(m.vector_cross(camera.right, camera.front))
}
