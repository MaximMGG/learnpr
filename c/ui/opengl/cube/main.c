#include <GL/glew.h>
#include <GLFW/glfw3.h>
#define STB_IMAGE_IMPLEMENTATION
#include "../lib/util.h"
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <cglm/cglm.h>

#define WIDTH 1280
#define HEIGHT 720
#define PROG_NAME "Cube"


int main() {
    glfwInit();

    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, PROG_NAME, null, null);
    if (window == null) {
        log(FATAL, "glfwCreateWindow failed");
        glfwTerminate();
        return 1;
    }

    glfwMakeContextCurrent(window);

    i32 glew_res = glewInit();
    printf("glew: %d\n", glew_res);
    if (glew_res != 0 && glew_res != 4) {
        log(FATAL, "glewInit failed");
        glfwDestroyWindow(window);
        glfwTerminate();
    }

    glEnable(GL_DEPTH_TEST);

    float vertices[] = {
        -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,
        0.5f, -0.5f, -0.5f,  1.0f, 0.0f,
        0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,

        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
        0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
        0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
        0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
        -0.5f,  0.5f,  0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,

        -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
        -0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
        -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,

        0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
        0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
        0.5f,  0.5f,  0.5f,  1.0f, 0.0f,

        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        0.5f, -0.5f, -0.5f,  1.0f, 1.0f,
        0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
        0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,

        -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
        0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
        0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
        -0.5f,  0.5f,  0.5f,  0.0f, 0.0f,
        -0.5f,  0.5f, -0.5f,  0.0f, 1.0f
    };

    vec3 cubePositions[] = {
        { 0.0f,  0.0f,  0.0f},
        { 2.0f,  5.0f, -15.0f},
        {-1.5f, -2.2f, -2.5f},
        {-3.8f, -2.0f, -12.3f},
        { 2.4f, -0.4f, -3.5f},
        {-1.7f,  3.0f, -7.5f},
        { 1.3f, -2.0f, -2.5f},
        { 1.5f,  2.0f, -2.5f},
        { 1.5f,  0.2f, -1.5f},
        {-1.3f,  1.0f, -1.5f}
    };

    u32 VAO = vertexArrayCreate();
    vertexArrayBind(VAO);
    u32 VBO = arrayBufferCreate(sizeof(vertices), vertices);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(f32) * 5, (void *)0);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, sizeof(f32) * 5, (void *)(sizeof(f32) * 3));
    glEnableVertexAttribArray(1);

    vertexArrayUnbind();

    u32 prog = programCreate("./vertex.glsl", "./fragment.glsl");
    u32 texture = textureLoad("./crate.png");
    programUse(prog);

    programSetI(prog, "texture1", 0);

    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        int res = 1;
        while(res != 0) {
            res = glGetError();
            char *err = glewGetErrorString(res);
            printf("Error: %x - %s\n", res, err);
        }
        glActiveTexture(GL_TEXTURE0);
        textureBind(texture);
        programUse(prog);

        mat4 view = GLM_MAT4_IDENTITY_INIT;
        mat4 projection = GLM_MAT4_IDENTITY_INIT;

        glm_perspective(glm_rad(45.0f), (f32)WIDTH / (f32)HEIGHT, 0.1f, 100.0f, projection);
        glm_translate(view, (vec3){0.0f, 0.0f, -3.0f});

        programSetMat4(prog, "projection", projection);
        programSetMat4(prog, "view", view);

        vertexArrayBind(VAO);


        for(u32 i = 0; i < 10; i++) {
            mat4 model = GLM_MAT4_IDENTITY_INIT;
            glm_translate(model, cubePositions[i]);
            glm_rotate(model, glm_rad((f32)glfwGetTime()), (vec3){1.0f, 3.0f, 0.5f});
            programSetMat4(prog, "model", model);

            glDrawArrays(GL_TRIANGLES, 0, 36);
        }


        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    vertexArrayDestroy(&VAO);
    arrayBufferDestroy(&VBO);

    return 0;
}
