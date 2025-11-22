#ifndef CAMERA_H
#define CAMERA_H
#include "../lib/util.h"

typedef enum {
  FORWARD, BACKWARD, LEFT, RIGHT
} CameraMovement;


extern const f32 YAW;
extern const f32 PITCH;
extern const f32 SPEED;
extern const f32 SENSITIVITY;
extern const f32 ZOOM;
typedef struct {
  vec3 position;
  vec3 front;
  vec3 up;
  vec3 right;
  vec3 world_up;

  f32 yaw;
  f32 pitch;

  f32 movementSpeed;
  f32 mouseSenitivity;
  f32 zoom;
} Camera;


Camera *cameraCreateDefault();
Camera *cameraCreate(vec3 postion, vec3 up, f32 yaw, f32 pitch);
Camera *cameraCreateScalar(f32 posx, f32 posy, f32 posz, f32 upx, f32 upy, f32 upz, f32 yaw, f32 pitch);

vec4 *cameraGetViewMatrix(Camera *camera);
void cameraProcessKeyboard(Camera *camera, CameraMovement direction, f32 delatTime);
void cameraProcessMouseMovement(Camera *camera, f32 xoffset, f32 yoffset, bool constraintPitch);
void cameraProcessMouseScroll(Camera *camera, f32 yofset);

#endif //CAMERA_H
