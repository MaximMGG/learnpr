#include "camera.h"
#include <string.h>


const f32 YAW = -90.0f;
const f32 PITCH = 0.0f;
const f32 SPEED = 2.5f;
const f32 SENSITIVITY = 0.0001f;
const f32 ZOOM = 45.0f;

static void updateCameraVectors(Camera *camera) {
  vec3 front;
  
  front[0] = cos(glm_rad(camera->yaw) * cos(glm_rad(camera->pitch)));
  front[1] = sin(glm_rad(camera->pitch));
  front[2] = sin(glm_rad(camera->yaw) * cos(glm_rad(camera->pitch)));

  glm_normalize(front);
  memcpy(camera->front, front, sizeof(vec3));

  vec3 tmp;
  glm_cross(camera->front, camera->world_up, tmp);
  glm_normalize(tmp);
  memcpy(camera->right, tmp, sizeof(vec3));
  glm_cross(camera->right, camera->front, tmp);
  glm_normalize(tmp);
  memcpy(camera->up, tmp, sizeof(vec3));
}


Camera *cameraCreateDefault() {
  Camera c = {.position = {0.0, 0.0, 0.0}, .world_up = {0.0f, 1.0f, 0.0f}, .yaw = YAW, .pitch = PITCH,
              .front = {0.0f, 0.0f, -1.0f}, .movementSpeed = SPEED, .mouseSenitivity = SENSITIVITY, .zoom = ZOOM};
  Camera *tmp = make(Camera);
  memcpy(tmp, &c, sizeof(Camera));
  return tmp;
}
Camera *cameraCreate(vec3 position, vec3 up, f32 yaw, f32 pitch) {
  Camera c = {.yaw = yaw, .pitch = pitch,
              .front = {0.0f, 0.0f, -1.0f}, .movementSpeed = SPEED, .mouseSenitivity = SENSITIVITY, .zoom = ZOOM};
  memcpy(c.position, position, sizeof(vec3));
  memcpy(c.world_up, up, sizeof(vec3));
  Camera *tmp = make(Camera);
  memcpy(tmp, &c, sizeof(Camera));
  return tmp;
}

Camera *cameraCreateScalar(f32 posx, f32 posy, f32 posz, f32 upx, f32 upy, f32 upz, f32 yaw, f32 pitch) {
  Camera c = {.position = {posx, posy, posz}, .world_up = {upx, upy, upz}, .yaw = yaw, .pitch = pitch,
              .front = {0.0f, 0.0f, -1.0f}, .movementSpeed = SPEED, .mouseSenitivity = SENSITIVITY, .zoom = ZOOM};
  Camera *tmp = make(Camera);
  memcpy(tmp, &c, sizeof(Camera));
  return tmp;
}

vec4 *cameraGetViewMatrix(Camera *camera) {
  mat4 *tmp = make(mat4);
  vec3 sum_vec;
  glm_vec3_add(camera->position, camera->front, sum_vec);

  glm_lookat(camera->position, sum_vec, camera->up, *tmp);
  return *tmp;
}

void cameraProcessKeyboard(Camera *camera, CameraMovement direction, f32 deltaTime) {
  f32 velocity = camera->movementSpeed * deltaTime;
  if (direction == FORWARD) {
    vec3 dest;
    glm_vec3_scale(camera->front, velocity, dest);
    vec3 pos;
    glm_vec3_add(camera->position, dest, pos);
    memcpy(camera->position, pos, sizeof(vec3));
  }
  if (direction == BACKWARD) {
    vec3 dest;
    glm_vec3_scale(camera->front, velocity, dest);
    vec3 pos;
    glm_vec3_sub(camera->position, dest, pos);
    memcpy(camera->position, pos, sizeof(vec3));
  }
  if (direction == LEFT) {
    vec3 dest;
    glm_vec3_scale(camera->right, velocity, dest);
    vec3 pos;
    glm_vec3_sub(camera->position, dest, pos);
    memcpy(camera->position, pos, sizeof(vec3));
  }
  if (direction == RIGHT) {
    vec3 dest;
    glm_vec3_scale(camera->right, velocity, dest);
    vec3 pos;
    glm_vec3_add(camera->position, dest, pos);
    memcpy(camera->position, pos, sizeof(vec3));
  }
}

void cameraProcessMouseMovement(Camera *camera, f32 xoffset, f32 yoffset, bool constraintPitch) {
  xoffset *= camera->mouseSenitivity;
  yoffset *= camera->mouseSenitivity;

  camera->yaw += xoffset;
  camera->pitch += yoffset;

  if (constraintPitch) {
    if (camera->pitch > 89.0f) {
      camera->pitch = 89.0f;
    }
    if (camera->pitch < -89.0f) {
      camera->pitch = -89.0f;
    }
  }
  updateCameraVectors(camera);
}

void cameraProcessMouseScroll(Camera *camera, f32 yoffset) {
  camera->zoom -= yoffset;
  if (camera->zoom < 1.0f)
    camera->zoom = 1.0f;
  if (camera->zoom > 45.0f)
    camera->zoom = 45.0f;
}
void cameraDestroy(Camera *camera) {
  dealloc(camera);
}
