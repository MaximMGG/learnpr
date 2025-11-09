#ifndef CAMERA_HPP
#define CAMERA_HPP

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

enum CameraMovement {
    FORWARD, BACKWARD, LEFT, RIGHT
};

const float YAW = -90.0f;
const float PITCH = 0.0f;
const float SPEED = 0.5f;
const float SENSITIVITY = 0.01f;
const float ZOOM = 45.0f;


class Camera {
public:
    glm::vec3 position;
    glm::vec3 front;
    glm::vec3 up;
    glm::vec3 right;
    glm::vec3 world_up;

    float yaw;
    float pitch;
    float movement_speed;
    float mouse_senitivity;
    float zoom;

    Camera(glm::vec3 position = glm::vec3(0.0f, 0.0f, 0.0f), glm::vec3 up = glm::vec3(0.0f, 1.0f, 0.0f), float yaw = YAW, float pitch = PITCH) :
            front(glm::vec3(0.0f, 0.0f, -1.0f)), movement_speed(SPEED), mouse_senitivity(SENSITIVITY), zoom(ZOOM) 
    {
        this->position = position;
        this->world_up = up;
        this->yaw = yaw;
        this->pitch = pitch;
        updateCameraVectors();
    }

    Camera(float posX, float posY, float posZ, float upX, float upY, float upZ, float yaw, float pitch) : 
        front(glm::vec3(0.0f, 0.0f, -1.0f)), movement_speed(SPEED), mouse_senitivity(SENSITIVITY), zoom(ZOOM) 
    {
        this->position = glm::vec3(posX, posY, posZ);
        this->world_up = glm::vec3(upX, upY, upZ);
        this->yaw = yaw;
        this->pitch = pitch;
        updateCameraVectors();
    }
    glm::mat4 getViewMatrix() {
        return glm::lookAt(this->position, this->position + this->front, this->up);
    }
    void processKeyboar(CameraMovement direction, float deltaTime) {
        float velocity = movement_speed * deltaTime;

        if (direction == FORWARD)
            position += front * velocity;
        if (direction == BACKWARD)
            position -= front * velocity;
        if (direction == LEFT)
            position -= right * velocity;
        if (direction == RIGHT)
            position += right * velocity;
    }
    void processMouseMovement(float xoffset, float yoffset, bool constrainPitch = true) {
        xoffset *= mouse_senitivity;
        yoffset *= mouse_senitivity;

        yaw += xoffset;
        pitch += yoffset;

        if (constrainPitch) {
            if (pitch > 89.0f)
                pitch = 89.0f;
            if (pitch < -89.0f)
                pitch = -89.0f;
        }
        updateCameraVectors();
    }

    void processMouseScroll(float yoffset) {
        zoom -= yoffset;
        if (zoom < 1.0f)
            zoom = 1.0f;
        if (zoom > 45.0f)
            zoom = 45.0f;
    }

private:
    void updateCameraVectors() {
        glm::vec3 _front;
        _front.x = cos(glm::radians(yaw)) * cos(glm::radians(pitch));
        _front.y = sin(glm::radians(pitch));
        _front.z = sin(glm::radians(yaw)) * cos(glm::radians(pitch));
        this->front = glm::normalize(_front);
        right = glm::normalize(glm::cross(front, world_up));
        up = glm::normalize(glm::cross(right, front));
    }
};
#endif
