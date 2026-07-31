#include "camera.h"
#include <string.h>


// #define YAW -90.0f;
// #define PITCH 0.0f;
// #define SPEED 2.5f;
// #define SENSITIVITY 0.1f;
// #define ZOOM 45.0f;
//
// typedef struct {
//   vec3 position;
//   vec3 front;
//   vec3 up;
//   vec3 right;
//   vec3 wolrd_up;
//
//   f32 yaw;
//   f32 pitch;
//   f32 movement_speed;
//   f32 mouse_sensitivity;
//   f32 zoom;
// } Camera;

static void updateCameraVectors(Camera *c) {
  vec3 front;
  memset(front, 0, sizeof(vec3));
  front[0] = cos(glm_rad(c->yaw)) * cos(glm_rad(c->pitch));
  front[1] = sin(glm_rad(c->pitch));
  front[2] = sin(glm_rad(c->yaw)) * cos(glm_rad(c->pitch));
  glm_normalize(front);
  memcpy(c->front, front, sizeof(vec3));
  vec3 norm;
  glm_cross(c->front, c->world_up, norm);
  memcpy(c->right, norm, sizeof(vec3));
  glm_cross(c->right, c->front, norm);
  memcpy(c->up, norm, sizeof(vec3));
}

Camera cameraCreate(vec3 position, vec3 up, f32 yaw, f32 pitch) {
  Camera c;
  memset(&c, 0, sizeof(Camera));
  memcpy(c.position, position, sizeof(vec3));
  memcpy(c.world_up, up, sizeof(vec3));
  c.yaw = yaw;
  c.pitch = pitch;
  memcpy(c.front, (vec3){0.0f, 0.0f, -1.0f}, sizeof(vec3));
  c.movement_speed = SPEED;
  c.mouse_sensitivity = SENSITIVITY;
  c.zoom = ZOOM;
  updateCameraVectors(&c);
  return c;
}

void cameraGetViewMatrix(Camera *c, mat4 *lookat_mat) {
  vec3 dest;
  glm_vec3_add(c->position, c->front, dest),
  glm_lookat(c->position, dest, c->up, *lookat_mat);
}

void cameraProcessKeyboard(Camera *c, CameraMovement direction, f32 delta_time) {
  f32 velocity = c->movement_speed * delta_time;
  switch(direction) {
    case FORWARD: {
      glm_vec3_muladds(c->front, velocity, c->position);
    } break;
    case BACKWARD: {
      glm_vec3_mulsubs(c->front, velocity, c->position);
    } break;
    case LEFT: {
      glm_vec3_mulsubs(c->right, velocity, c->position);
    } break;
    case RIGHT: {
      glm_vec3_muladds(c->right, velocity, c->position);
    } break;
  }
}

void cameraProcessMouseMovement(Camera *c, f32 xoffset, f32 yoffset, bool constrain_pitch) {
  xoffset *= c->mouse_sensitivity; 
  yoffset *= c->mouse_sensitivity;

  c->yaw += xoffset;
  c->pitch += yoffset;

  if (constrain_pitch) {
    if (c->pitch > 89.0f) {
      c->pitch = 89.0f;
    }
    if (c->pitch < -89.0f) {
      c->pitch = -89.0f;
    }
  }
  updateCameraVectors(c);
}

void cameraProcessMouseScroll(Camera *c, f32 yoffset) {
  c->zoom -= yoffset;
  if (c->zoom < 1.0f) {
    c->zoom = 1.0f;
  }
  if (c->zoom > 45.0f) {
    c->zoom = 45.0;
  }
}
