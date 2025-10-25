#include "drawing.hpp"

std::vector<float> drawCircle(float x, float y, float radius, int sides) {
    std::vector<float> vertices;
    for(int i = 0; i < sides; i++) {
        float theta = 2.0f * 3.1415926f * float(i) / float(sides);
        float vx = x + radius * cosf(theta);
        float vy = y + radius * sinf(theta);
        vertices.push_back(vx);
        vertices.push_back(vy);
    }

    return vertices;
}

unsigned int createVertexArrayObject() {
    unsigned int VAO;
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);
    return VAO;
}


unsigned int createVertexBufferObject(std::vector<float> &vertices) {
    unsigned int VBO;
    glGenBuffers(1, &VBO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, vertices.size() * sizeof(float), vertices.data(), GL_STATIC_DRAW);
    return VBO;
}

void renderCircle(unsigned int VAO, unsigned int VBO, std::vector<float> &vertices, unsigned int mode) {
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void *)0);
    glBufferData(GL_ARRAY_BUFFER, vertices.size() * sizeof(float), vertices.data(), GL_STATIC_DRAW);
    glDrawArrays(mode, 0, vertices.size() / 2);
    glDisableVertexAttribArray(0);
    glBindVertexArray(0);
}
