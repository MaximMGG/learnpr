#ifndef CAMERA_H
#define CAMERA_H

#include <cstdext/core.h>
#include <cglm/cglm.h>

#define YAW         -90.0f
#define PITCH       0.0f
#define SPEED       2.5f
#define SENSITIVITY 0.1f
#define ZOOM        45.0f


typedef enum {
  FORWARD, BACKWARD, LEFT, RIGHT
} CameraMovement;

typedef struct {
  vec3 position, front, up, right, world_up;
  f32 yaw, pitch, movement_speed, mouse_sensitivity, zoom;
} Camera;

Camera cameraCreateDefault();
Camera cameraCreateVec(vec3 position);
void cameraProcessKeyboard(Camera *c, CameraMovement directioon, f32 delta_time);
void cameraProcessMouseScroll(Camera *c, f32 yoffset);
void cameraProcessMouseMovement(Camera *c, f32 xoffset, f32 yoffset, bool constraint_pitch);
void cameraGetViewMatrix(Camera *c, mat4 dest);


#endif //CAMERA_H
