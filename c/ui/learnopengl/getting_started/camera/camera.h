#ifndef CAMERA_H
#define CAMERA_H

#include <cstdext/core.h>
#include <cglm/cglm.h>

typedef enum {
  FORWARD,
  BACKWARD,
  LEFT,
  RIGHT
} CameraMovement;


#define YAW -90.0f;
#define PITCH 0.0f;
#define SPEED 2.5f;
#define SENSITIVITY 0.1f;
#define ZOOM 45.0f;

typedef struct {
  vec3 position;
  vec3 front;
  vec3 up;
  vec3 right;
  vec3 world_up;

  f32 yaw;
  f32 pitch;
  f32 movement_speed;
  f32 mouse_sensitivity;
  f32 zoom;
} Camera;

Camera cameraCreate(vec3 position, vec3 up, f32 yaw, f32 pitch);
void cameraGetViewMatrix(Camera *c, mat4 *lookat_mat);
void cameraProcessKeyboard(Camera *c, CameraMovement direction, f32 delta_time);
void cameraProcessMouseMovement(Camera *c, f32 xoffset, f32 yoffset, bool constrain_pitch);
void cameraProcessMouseScroll(Camera *c, f32 yoffset);

#endif // CAMERA_H
