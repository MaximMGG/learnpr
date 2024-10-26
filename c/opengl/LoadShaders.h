#ifndef __LOAD_SHADERS_H__
#define __LOAD_SHADERS_H__

#include <glad/glad.h>
#include <GL/gl.h>
#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    GLenum       type;
    const char  *filename;
    GLuint       shader;
} ShaderInfo;


GLuint LoadShaders(ShaderInfo *shader_info);


#ifdef __cplusplus
};
#endif

#endif //__LOAD_SHADERS_H__
