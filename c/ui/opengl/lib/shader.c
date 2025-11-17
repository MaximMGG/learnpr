#include "shader.h"

static bool programCheckStatus(u32 shader, u32 type) {
    if (type == GL_VERTEX_SHADER || type == GL_FRAGMENT_SHADER) {
        i32 res;
        GLCall(glGetShaderiv(shader, GL_COMPILE_STATUS, &res));
        if (res == GL_FALSE) {
            i32 len;
            GLCall(glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len));
            byte *err_msg = alloc(len + 1);
            GLCall(glGetShaderInfoLog(shader, len, &len, err_msg));
            str shader_type = type == GL_VERTEX_SHADER ? "vertex" : "fragment";
            log(ERROR, "Compile %s shader error: %s", shader_type, err_msg);
            dealloc(err_msg);
            return false;
        }
    } else if (type == GL_PROGRAM) {
        i32 res;
        GLCall(glGetProgramiv(shader, GL_LINK_STATUS, &res));
        if (res == GL_FALSE) {
            i32 len;
            GLCall(glGetProgramiv(shader, GL_INFO_LOG_LENGTH, &len));
            byte *err_msg = alloc(len + 1);
            GLCall(glGetProgramInfoLog(shader, len, &len, err_msg));
            log(ERROR, "Link program error: %s", err_msg);
            dealloc(err_msg);
            return false;
        }
    }

    return true;
}

u32 programCompileShader(char *path, u32 type) {
    reader *r = reader_create_from_file(path);
    u32 shader;
    GLCall(shader = glCreateShader(type));
    GLCall(glShaderSource(shader, 1, (const char *const *)&r->buf, null));
    GLCall(glCompileShader(shader));
    reader_destroy(r);
    if (!programCheckStatus(shader, type)) {
        GLCall(glDeleteShader(shader));
        return 0;
    }
    return shader;
}

u32 programCreate(const char *v_path, const char *f_path) {
    u32 v_shader = programCompileShader((char *)v_path, GL_VERTEX_SHADER);
    u32 f_shader = programCompileShader((char *)f_path, GL_FRAGMENT_SHADER);
    u32 program;
    GLCall(program = glCreateProgram());
    GLCall(glAttachShader(program, v_shader));
    GLCall(glAttachShader(program, f_shader));
    GLCall(glLinkProgram(program));
    GLCall(glDeleteShader(v_shader));
    GLCall(glDeleteShader(f_shader));
    if (!programCheckStatus(program, GL_PROGRAM)) {
        GLCall(glDeleteProgram(program));
        return 0;
    }
    GLCall(glValidateProgram(program));
    return program;
}

void programUse(u32 program) {
    GLCall(glUseProgram(program));
}
void programUnuse(u32 program) {
    GLCall(glUseProgram(0));
}

void programDestroy(u32 program) {
    GLCall(glDeleteProgram(program));
}

void programSetI(u32 program, const char *name, i32 value) {
    i32 loc;
    GLCall(glGetUniformLocation(program, name));
    if (loc != -1) {
        GLCall(glUniform1i(loc, value));
    } else {
        log(ERROR, "Can not find location: %s", name);
    }
}

void programSetMat4(u32 program, const char *name, mat4 value) {
    i32 loc;
    GLCall(loc = glGetUniformLocation(program, name));
    if (loc != -1) {
        GLCall(glUniformMatrix4fv(loc, 1, GL_FALSE, &value[0][0]));
    } else {
        log(ERROR, "Can not find location: %s", name);
    }
}

