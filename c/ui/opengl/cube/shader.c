#include "shader.h"
#include <cstdext/io/reader.h>
#include <cstdext/io/logger.h>
#include <stdio.h>

static bool ShaderCheckStatus(unsigned int shader, unsigned int shader_type) {
    switch(shader_type) {
        case GL_VERTEX_SHADER:
        case GL_FRAGMENT_SHADER: {
            int res;
            glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
            if (res == GL_FALSE) {
                int len;
                glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
                str err_msg = alloc(len);
                glGetShaderInfoLog(shader, len, &len, err_msg);
                fprintf(stderr, "Compile %s shader failed: %s\n", shader_type == GL_VERTEX_SHADER ? 
                                                            "vertex" : "fragment", err_msg);
                dealloc(err_msg);
                return false;
            }

        } break;
        case GL_PROGRAM: {
            int res;
            glGetProgramiv(shader, GL_LINK_STATUS, &res);
            if (res == GL_FALSE) {
                int len;
                glGetProgramiv(shader, GL_INFO_LOG_LENGTH, &len);
                str err_msg = alloc(len);
                glGetProgramInfoLog(shader, len, &len, err_msg);
                fprintf(stderr, "Compile progrm failed: %s\n", err_msg);
                dealloc(err_msg);
                return false;
            }
        }
    }
    return true;
}

static unsigned int ShaderCompileShader(const char *shader_path, unsigned int shader_type) {
    reader *r = reader_create_from_file((char *)shader_path);
    unsigned int shader = glCreateShader(shader_type); 
    glShaderSource(shader, 1, (const char * const *)&r->buf, null);
    glCompileShader(shader);
    if (!ShaderCheckStatus(shader, shader_type)) {
        log(ERROR, "Shader compile failed");
    }
    reader_destroy(r);
    return shader;
}


Shader ShaderCreate(const char *vertex_path, const char *fragment_path) {
    unsigned int vertex_shader = ShaderCompileShader(vertex_path, GL_VERTEX_SHADER);
    unsigned int fragment_shader = ShaderCompileShader(fragment_path, GL_FRAGMENT_SHADER);
    Shader p = glCreateProgram();
    glAttachShader(p, vertex_shader);
    glAttachShader(p, fragment_shader);
    glLinkProgram(p);
    if (!ShaderCheckStatus(p, GL_PROGRAM)) {
        log(ERROR, "Program linkage failed");
    }
    glValidateProgram(p);
    glDeleteShader(vertex_shader);
    glDeleteShader(fragment_shader);

    return p;
}

void ShaderDestroy(Shader shader) {
    glDeleteProgram(shader);
}


void ShaderUse(Shader shader) {
    glUseProgram(shader);
}

void ShaderSetInt(Shader shader, const char *name, const int value) {
    int loc = glGetUniformLocation(shader, name);
    if (loc != -1) {
        glUniform1i(loc, value);
    }
}

void ShaderSetMat4(Shader shader, const char *name, mat4 value) {
    int loc = glGetUniformLocation(shader, name);
    if (loc != -1) {
        glUniformMatrix4fv(loc, 1, GL_FALSE, &value[0][0]);
    }

}

