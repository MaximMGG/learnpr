#include "camera.h"
#include <string.h>

static void cameraUpdateVectors(Camera *c) {
  vec3 front;

  front[0] = cos(glm_rad(c->yaw)) * cos(glm_rad(c->pitch));
  front[1] = sin(glm_rad(c->pitch));
  front[2] = sin(glm_rad(c->yaw)) * cos(glm_rad(c->pitch));
  glm_normalize(front);
  memcpy(c->front, front, sizeof(vec3));

  vec3 res;
  glm_cross(c->front, c->world_up, res);
  glm_normalize(res);
  memcpy(c->right, res, sizeof(vec3));
  glm_cross(c->right, c->front, res);
  glm_normalize(res);
  memcpy(c->up, res, sizeof(vec3));
}

Camera cameraCreateDefault() {
  Camera c = {};
  memcpy(c.position, (vec3){0.0, 0.0, 0.0}, sizeof(vec3));
  memcpy(c.world_up, (vec3){0.0, 1.0, 0.0}, sizeof(vec3));
  memcpy(c.front, (vec3){0.0f, 0.0f, -1.0f}, sizeof(vec3));
  c.yaw = YAW;
  c.pitch = PITCH;
  c.movement_speed = SPEED;
  c.mouse_sensitivity = SENSITIVITY;
  c.zoom = ZOOM;
  cameraUpdateVectors(&c);
  return c;
}
Camera cameraCreateVec(vec3 position) {
  Camera c = {};
  memcpy(c.position, position, sizeof(vec3));
  memcpy(c.world_up, (vec3){0.0, 1.0, 0.0}, sizeof(vec3));
  memcpy(c.front, (vec3){0.0f, 0.0f, -1.0f}, sizeof(vec3));
  c.yaw = YAW;
  c.pitch = PITCH;
  c.movement_speed = SPEED;
  c.mouse_sensitivity = SENSITIVITY;
  c.zoom = ZOOM;
  cameraUpdateVectors(&c);
  return c;
}

void cameraProcessKeyboard(Camera *c, CameraMovement direction, f32 delta_time) {
  f32 velocity = c->movement_speed * delta_time;
  if (direction == FORWARD) {
    glm_vec3_muladds(c->front, velocity, c->position);
  }
  if (direction == BACKWARD) {
    glm_vec3_mulsubs(c->front, velocity, c->position);
  }
  if (direction == LEFT) {
    glm_vec3_mulsubs(c->right, velocity, c->position);
  }
  if (direction == RIGHT) {
    glm_vec3_muladds(c->right, velocity, c->position);
  }
}

void cameraProcessMouseScroll(Camera *c, f32 yoffset) {
  c->zoom -= yoffset;
  if (c->zoom < 1.0f) c->zoom = 1.0f;
  if (c->zoom > 45.0f) c->zoom = 45.0f;
}

void cameraProcessMouseMovement(Camera *c, f32 xoffset, f32 yoffset, bool constraint_pitch) {
  xoffset *= c->mouse_sensitivity;
  yoffset *= c->mouse_sensitivity;

  c->yaw += xoffset;
  c->pitch += yoffset;

  if (constraint_pitch) {
    if (c->pitch > 89.0f) c->pitch = 89.0f;
    if (c->pitch < -89.0f) c->pitch = -89.0f;
  }
  cameraUpdateVectors(c);
}

void cameraGetViewMatrix(Camera *c, mat4 dest) {
  vec3 pf;
  glm_vec3_add(c->position, c->front, pf);
  glm_lookat(c->position, pf, c->up, dest);
}
