#include "LoadShaders.h"
#include <glad/glad.h>
#include <stdlib.h>
#include <stdio.h>

#ifdef __cplusplus
extern "C" {

#endif

static const GLchar *ReadShader(const char *filename) {
    FILE *infile = fopen(filename, "rb");

    fseek(infile, 0, SEEK_END);
    int len = ftell(infile);
    fseek(infile, 0, SEEK_SET);
    GLchar *source = malloc(sizeof(GLchar) * len + 1);
    fread(source, 1, len, infile);
    fclose(infile);
    source[len] = 0;

    return source;
}

GLuint LoadShaders(ShaderInfo *shaders) {
    if (shaders == NULL) return 0;

    GLuint program = glCreateProgram();
    ShaderInfo *entry = shaders;
    while(entry->type !=GL_NONE) {
        GLuint shader = glCreateShader(entry->type);

        entry->shader = shader;

        const GLchar *source = ReadShader(entry->filename);
        if (source == NULL) {
            for(entry = shaders; entry->type != GL_NONE; ++entry) {
                glDeleteShader(entry->shader);
                entry->shader = 0;
            }
            return 0;
        }

        glShaderSource(shader, 1, &source, NULL);
        free((void *)source);

        glCompileShader(shader);

        GLint compiled;
        glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);
        if (!compiled) {
#ifdef __DEBUG
            GLsizei len;
            glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);

            GLchar *log = malloc(sizeof(GLchar) & len + 1);
            glGetShaderInfoLog(shader, len, &len, log);
            fprintf(stderr, "Shader compilateion failed: %s\n", log);
            free((void *)log);

#endif
            return 0;
        }
        glAttachShader(program, shader);

        ++entry;

    }

    glLinkProgram(program);

    GLint linked;
    glGetProgramiv(program, GL_LINK_STATUS, &linked);
    if (!linked) {
#ifdef __DEBUG

#endif
        for (entry = shaders; entry->type != GL_NONE; ++entry) {
            glDeleteShader(entry->shader);
            entry->shader = 0;
        }
        return 0;
    }
    return program;

}


#ifdef __cplusplus
}
#endif
