#ifndef MY_CAMERA_HPP
#define MY_CAMERA_HPP

#include "types.hpp"
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>



enum Camera_Movement {
  FORWARD, BACKWARD, LEFT, RIGHT
};


#define YAW         -90.0f
#define PITCH         0.0f
#define SPEED         2.5f
#define SENSITIVITY   0.1f 
#define ZOOM         45.0f


class Camera {
public:
  glm::vec3 Position;
  glm::vec3 Front;
  glm::vec3 Up;
  glm::vec3 Right;
  glm::vec3 WorldUp;

  f32 Yaw, Pitch, MovementSpeed, MouseSensitivity, Zoom;

  Camera(glm::vec3 position = glm::vec3(0.0, 0.0, 0.0), glm::vec3 up = glm::vec3(0.0, 1.0, 0.0), f32 yaw = YAW, f32 pitch = PITCH) : 
    Front(glm::vec3(0.0, 0.0, -1.0)), MovementSpeed(SPEED), MouseSensitivity(SENSITIVITY), Zoom(ZOOM) {
      Position = position;
      WorldUp = up;
      Yaw = yaw;
      Pitch = pitch;
      updateCameraVectors();
  }
  Camera(f32 posx, f32 posy, f32 posz, f32 upx, f32 upy, f32 upz, f32 yaw = YAW, f32 pitch = PITCH) : 
    Front(glm::vec3(0.0, 0.0, -1.0)), MovementSpeed(SPEED), MouseSensitivity(SENSITIVITY), Zoom(ZOOM) {
      Position = glm::vec3(posx, posy, posz);
      WorldUp = glm::vec3(upx, upy, upz);
      Yaw = yaw;
      Pitch = pitch;
      updateCameraVectors();
  }

  glm::mat4 getViewMatrix() {
    return glm::lookAt(Position, Position + Front, Up);
  }

  void processKeyboard(Camera_Movement direction, float delta_time) {
    f32 velocity = MovementSpeed * delta_time;
    switch(direction) {
      case FORWARD: Position += Front * velocity; break;
      case BACKWARD: Position -= Front * velocity; break;
      case LEFT: Position -= Right * velocity; break;
      case RIGHT: Position += Right * velocity; break;
    }
  }

  void processMouseMovenet(f32 xoffset, f32 yoffset, bool constraint_pitch = true) {
    xoffset *= MouseSensitivity;
    yoffset *= MouseSensitivity;

    Yaw += xoffset;
    Pitch += yoffset;

    if (constraint_pitch) {
      if (Pitch > 89.0) Pitch = 89.0;
      if (Pitch < -89.0) Pitch = -89.0;

    }
    updateCameraVectors();
  }

  void processMouseScroll(f32 yoffset) {
    Zoom -= yoffset;
    if (Zoom < 1.0) Zoom = 1.0;
    if (Zoom > 45.0) Zoom = 45.0;
  }

private:
  void updateCameraVectors() {
    glm::vec3 front;
    front.x = cos(glm::radians(Yaw)) * cos(glm::radians(Pitch));
    front.y = sin(glm::radians(Pitch));
    front.z = sin(glm::radians(Yaw)) * cos(glm::radians(Pitch));
    Front = glm::normalize(front);
    Right = glm::normalize(glm::cross(Front, WorldUp));
    Up = glm::normalize(glm::cross(Right, Front));
  }
};



#endif //MY_CAMERA_HPP
