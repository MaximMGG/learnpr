#ifndef CAMERA_H
#define CAMERA_H
#include <cglm/cglm.h>
#include <cstdext/core.h>


typedef enum {
    FORWARD, BACKWARD, LEFT, RIGHT
} CameraMovement;

typedef struct {
    vec3 position;
    vec3 front;
    vec3 up;
    vec3 right;
    vec3 world_up;

    f32 yaw;
    f32 pitch;
    f32 movement_speed;
    f32 mouse_sentitivity;
    f32 zoom;
} Camera;

extern const f32 YAW;
extern const f32 PITCH;
extern const f32 SPEED;
extern const f32 SENSITIVITY;
extern const f32 ZOOM;

Camera cameraCreate(vec3 position, vec3 up, f32 yaw, f32 pitch);
Camera cameraCreateScalar(f32 posX, f32 posY, f32 posZ, f32 upX, f32 upY, f32 upZ, f32 yaw, f32 pitch);

mat4 *cameraGetMatrixView(Camera *camera);
void cameraProcessKeyboard(Camera *camera, CameraMovement direction, f32 deltaTime);
void cameraProcessMouseMovement(Camera *camera, f32 xoffset, f32 yoffset, bool constrainPitch);
void cameraProcessMouseScroll(Camera *camera, f32 yoffset);

#endif //CAMERA_H
