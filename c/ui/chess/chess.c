#include "chess.h"


#define WIDTH 1280
#define HEIGHT 720
#define WIN_NAME "Chess application"

GLFWwindow *window;

typedef struct {
    u32 VAO;
    u32 VBO;
    u32 EBO;
    u32 Prog;
}App;

App app = {0};

void key_callback(GLFWwindow *_window, int key, int scancode, int action, int mode) {
    (void)scancode;
    (void)mode;
    if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS) {
        glfwSetWindowShouldClose(_window, true);
    }
}

void setup_window() {
    glfwInit();

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 5);

    window = glfwCreateWindow(WIDTH, HEIGHT, WIN_NAME, null, null);
    if (window == null) {
        log(FATAL, "glfwCreateWindow failed");
        glfwTerminate();
        exit(1);
    }
    glfwSetKeyCallback(window, key_callback);
    glfwMakeContextCurrent(window);
    int major, minor = 0;
    glfwGetVersion(&major, &minor, NULL);

    printf("OpenGL Major: %d\nOpenGL Minor: %d\n", major, minor);

    int glewInit_res = glewInit();
    if (glewInit_res != 0 && glewInit_res != 4) {
        log(FATAL, "glewInit failed");
        glfwDestroyWindow(window);
        glfwTerminate();
        exit(1);
    }


    f32 vertices[] = {
        -0.5, -0.5,
        -0.5,  0.5,
         0.5,  0.5,
         0.5, -0.5
    };

    u32 indices[] = {
        0, 1, 2, 2, 3, 0
    };

    u32 VAO, VBO, EBO;

    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);

    glGenBuffers(1, &VBO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glGenBuffers(1, &EBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(f32) * 2, (void *)0);
    glEnableVertexAttribArray(0);

    u32 vertex = ui_compileShader("./vertex.glsl", GL_VERTEX_SHADER);
    u32 fragment = ui_compileShader("./fragment.glsl", GL_FRAGMENT_SHADER);
    u32 prog = ui_linkProgram(vertex, fragment);
    if (prog == 0) {
        log(FATAL, "Error prog linkeage");
        return;
    }
    glDeleteShader(vertex);
    glDeleteShader(fragment);

    app.VAO = VAO;
    app.VBO = VBO;
    app.EBO = EBO;
    app.Prog = prog;
}

void application_loop() {


    mat4 ortho = GLM_MAT4_IDENTITY_INIT;
    glm_ortho(0, 1280, 0, 720, 0, 100, ortho);
    mat4 tmp1 = GLM_MAT4_IDENTITY_INIT;
    mat4 tmp2 = GLM_MAT4_IDENTITY_INIT;
    glm_translate(tmp1, (vec3){100.0f, 100.0f, 0.0f});
    glm_scale(tmp2, (vec3){100.0f, 100.0f, 0.0f});
    mat4 model;
    glm_mat4_mul(tmp1, tmp2, model);

    glUseProgram(app.Prog);

    ui_setMat4(app.Prog, "proj", ortho);
    ui_setMat4(app.Prog, "model", model);

    while(!glfwWindowShouldClose(window)) {
        glClearColor(0.3, 0.2, 0.8, 1.0);
        glClear(GL_COLOR_BUFFER_BIT);

        glBindVertexArray(app.VAO);
        glUseProgram(app.Prog);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, NULL);

        mat4 tmp3 = GLM_MAT4_IDENTITY_INIT;
        glm_translate(tmp3, (vec3){200, 100, 0.0});
        glm_mul(tmp3, tmp2, model);

        // glUseProgram(app.Prog);
        // ui_setMat4(app.Prog, "model", model);
        // glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, NULL);

        glfwSwapBuffers(window);
        glfwPollEvents();
    }
}

void application_terminate() {

    glDeleteVertexArrays(1, &app.VAO);
    glDeleteBuffers(1, &app.VBO);
    glDeleteBuffers(1, &app.EBO);
    glDeleteProgram(app.Prog);

    glfwDestroyWindow(window);
    glfwTerminate();

}
