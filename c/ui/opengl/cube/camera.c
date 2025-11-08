#include "camera.h"
#include <string.h>

const f32 YAW = -90.0;
const f32 PITCH = 0.0;
const f32 SPEED = 2.5;
const f32 SENSITIVITY = 0.1;
const f32 ZOOM = 45.0;

static void updateCameraVectors(Camera *camera) {
    vec3 front;
    front[0] = (f32)cos(glm_rad(camera->yaw)) * cos(glm_rad(camera->pitch));
    front[1] = (f32)sin(glm_rad(camera->pitch));
    front[2] = (f32)sin(glm_rad(camera->yaw)) * cos(glm_rad(camera->pitch));
    glm_vec3_normalize(front);
    glm_cross(camera->front, camera->world_up, camera->right);
    glm_cross(camera->right, camera->front, camera->up);
}

Camera cameraCreate(vec3 position, vec3 up, f32 yaw, f32 pitch) {
    Camera camera;
    glm_vec3_copy(camera.position, position);
    glm_vec3_copy(camera.up, up);
    glm_vec3_copy(camera.front, (vec3){0.0, 0.0, -1.0});
    camera.movement_speed = SPEED;
    camera.mouse_sentitivity = SENSITIVITY;
    camera.zoom = ZOOM;
    camera.yaw = yaw;
    camera.pitch = pitch;
    updateCameraVectors(&camera);
    return camera;
}

Camera cameraCreateScalar(f32 posX, f32 posY, f32 posZ, f32 upX, f32 upY, f32 upZ, f32 yaw, f32 pitch) {
    Camera camera;
    glm_vec3_copy(camera.position, (vec3){posX, posY, posZ});
    glm_vec3_copy(camera.up, (vec3){upX, upY, upZ});
    glm_vec3_copy(camera.front, (vec3){0.0, 0.0, -1.0});
    camera.movement_speed = SPEED;
    camera.mouse_sentitivity = SENSITIVITY;
    camera.zoom = ZOOM;
    camera.yaw = yaw;
    camera.pitch = pitch;
    updateCameraVectors(&camera);
    return camera;
}

mat4 *cameraGetMatrixView(Camera *camera) {
    mat4 a;
    vec3 center;
    glm_vec3_add(camera->position, camera->front, center);
    mat4 *res = alloc(sizeof(mat4));
    glm_lookat(camera->position, center, camera->up, *res);

    return res;
}

void cameraProcessKeyboard(Camera *camera, CameraMovement direction, f32 deltaTime) {
    f32 velosity = camera->movement_speed * deltaTime;
    if (direction == FORWARD) {
        vec3 tmp;
        glm_vec3_scale(camera->front, velosity, tmp);
        glm_vec3_add(camera->position, tmp, camera->position);
    }
    if (direction == BACKWARD) {
        vec3 tmp;
        glm_vec3_scale(camera->front, velosity, tmp);
        glm_vec3_sub(camera->position, tmp, camera->position);
    }
    if (direction == LEFT) {
        vec3 tmp;
        glm_vec3_scale(camera->right, velosity, tmp);
        glm_vec3_sub(camera->position, tmp, camera->position);
    }
    if (direction == RIGHT) {
        vec3 tmp;
        glm_vec3_scale(camera->right, velosity, tmp);
        glm_vec3_add(camera->position, tmp, camera->position);
    }
}

void cameraProcessMouseMovement(Camera *camera, f32 xoffset, f32 yoffset, bool constrainPitch) {
    xoffset *= camera->mouse_sentitivity;
    yoffset *= camera->mouse_sentitivity;

    camera->yaw += xoffset;
    camera->pitch += yoffset;

    if (constrainPitch) {
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
    if (camera->zoom < 1.0f) {
        camera->zoom = 1.0f;
    }
    if (camera->zoom > 45.0f) {
        camera->zoom = 45.0f;
    }
}
