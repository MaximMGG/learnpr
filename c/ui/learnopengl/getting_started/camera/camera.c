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

Camera cameraCreate(vec3 position, vec3 up, f32 yaw, f32 pitch) {
  Camera c;
  memcpy(c.position, position, sizeof(vec3));
  memcpy(c.world_up, up, sizeof(vec3));
  c.yaw = yaw;
  c.pitch = pitch;
  memcpy(c.front, (vec3){0.0f, 0.0f, -1.0f}, sizeof(vec3));
  c.movement_speed = SPEED;
  c.mouse_sensitivity = SENSITIVITY;
  c.zoom = ZOOM;
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

    } break;
    case LEFT: {

    } break;
    case RIGHT: {

    } break;
  }


}
void cameraProcessMouseMovement(Camera *c, f32 xoffset, f32 yoffset, bool constrain_pitch);
void cameraProcessMouseScroll(Camera *c, f32 yoffset);
