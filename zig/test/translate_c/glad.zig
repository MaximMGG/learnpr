const __root = @This();
pub const __builtin = @import("std").zig.c_translation.builtins;
pub const __helpers = @import("std").zig.c_translation.helpers;
pub const struct_gladGLversionStruct = extern struct {
    major: c_int = 0,
    minor: c_int = 0,
};
pub const GLADloadproc = ?*const fn (name: [*c]const u8) callconv(.c) ?*anyopaque;
pub extern var GLVersion: struct_gladGLversionStruct;
pub extern fn gladLoadGL() c_int;
pub extern fn gladLoadGLLoader(GLADloadproc) c_int;
pub const int_least64_t = i64;
pub const uint_least64_t = u64;
pub const int_fast64_t = i64;
pub const uint_fast64_t = u64;
pub const int_least32_t = i32;
pub const uint_least32_t = u32;
pub const int_fast32_t = i32;
pub const uint_fast32_t = u32;
pub const int_least16_t = i16;
pub const uint_least16_t = u16;
pub const int_fast16_t = i16;
pub const uint_fast16_t = u16;
pub const int_least8_t = i8;
pub const uint_least8_t = u8;
pub const int_fast8_t = i8;
pub const uint_fast8_t = u8;
pub const intmax_t = c_long;
pub const uintmax_t = c_ulong;
pub const khronos_int32_t = i32;
pub const khronos_uint32_t = u32;
pub const khronos_int64_t = i64;
pub const khronos_uint64_t = u64;
pub const khronos_int8_t = i8;
pub const khronos_uint8_t = u8;
pub const khronos_int16_t = c_short;
pub const khronos_uint16_t = c_ushort;
pub const khronos_intptr_t = c_long;
pub const khronos_uintptr_t = c_ulong;
pub const khronos_ssize_t = c_long;
pub const khronos_usize_t = c_ulong;
pub const khronos_float_t = f32;
pub const khronos_utime_nanoseconds_t = khronos_uint64_t;
pub const khronos_stime_nanoseconds_t = khronos_int64_t;
pub const KHRONOS_FALSE: c_int = 0;
pub const KHRONOS_TRUE: c_int = 1;
pub const KHRONOS_BOOLEAN_ENUM_FORCE_SIZE: c_int = 2147483647;
pub const khronos_boolean_enum_t = c_uint;
pub const GLenum = c_uint;
pub const GLboolean = u8;
pub const GLbitfield = c_uint;
pub const GLvoid = anyopaque;
pub const GLbyte = khronos_int8_t;
pub const GLubyte = khronos_uint8_t;
pub const GLshort = khronos_int16_t;
pub const GLushort = khronos_uint16_t;
pub const GLint = c_int;
pub const GLuint = c_uint;
pub const GLclampx = khronos_int32_t;
pub const GLsizei = c_int;
pub const GLfloat = khronos_float_t;
pub const GLclampf = khronos_float_t;
pub const GLdouble = f64;
pub const GLclampd = f64;
pub const GLeglClientBufferEXT = ?*anyopaque;
pub const GLeglImageOES = ?*anyopaque;
pub const GLchar = u8;
pub const GLcharARB = u8;
pub const GLhandleARB = c_uint;
pub const GLhalf = khronos_uint16_t;
pub const GLhalfARB = khronos_uint16_t;
pub const GLfixed = khronos_int32_t;
pub const GLintptr = khronos_intptr_t;
pub const GLintptrARB = khronos_intptr_t;
pub const GLsizeiptr = khronos_ssize_t;
pub const GLsizeiptrARB = khronos_ssize_t;
pub const GLint64 = khronos_int64_t;
pub const GLint64EXT = khronos_int64_t;
pub const GLuint64 = khronos_uint64_t;
pub const GLuint64EXT = khronos_uint64_t;
pub const struct___GLsync = opaque {};
pub const GLsync = ?*struct___GLsync;
pub const struct__cl_context = opaque {};
pub const struct__cl_event = opaque {};
pub const GLDEBUGPROC = ?*const fn (source: GLenum, @"type": GLenum, id: GLuint, severity: GLenum, length: GLsizei, message: [*c]const GLchar, userParam: ?*const anyopaque) callconv(.c) void;
pub const GLDEBUGPROCARB = ?*const fn (source: GLenum, @"type": GLenum, id: GLuint, severity: GLenum, length: GLsizei, message: [*c]const GLchar, userParam: ?*const anyopaque) callconv(.c) void;
pub const GLDEBUGPROCKHR = ?*const fn (source: GLenum, @"type": GLenum, id: GLuint, severity: GLenum, length: GLsizei, message: [*c]const GLchar, userParam: ?*const anyopaque) callconv(.c) void;
pub const GLDEBUGPROCAMD = ?*const fn (id: GLuint, category: GLenum, severity: GLenum, length: GLsizei, message: [*c]const GLchar, userParam: ?*anyopaque) callconv(.c) void;
pub const GLhalfNV = c_ushort;
pub const GLvdpauSurfaceNV = GLintptr;
pub const GLVULKANPROCNV = ?*const fn () callconv(.c) void;
pub extern var GLAD_GL_VERSION_1_0: c_int;
pub const PFNGLCULLFACEPROC = ?*const fn (mode: GLenum) callconv(.c) void;
pub extern var glad_glCullFace: PFNGLCULLFACEPROC;
pub const PFNGLFRONTFACEPROC = ?*const fn (mode: GLenum) callconv(.c) void;
pub extern var glad_glFrontFace: PFNGLFRONTFACEPROC;
pub const PFNGLHINTPROC = ?*const fn (target: GLenum, mode: GLenum) callconv(.c) void;
pub extern var glad_glHint: PFNGLHINTPROC;
pub const PFNGLLINEWIDTHPROC = ?*const fn (width: GLfloat) callconv(.c) void;
pub extern var glad_glLineWidth: PFNGLLINEWIDTHPROC;
pub const PFNGLPOINTSIZEPROC = ?*const fn (size: GLfloat) callconv(.c) void;
pub extern var glad_glPointSize: PFNGLPOINTSIZEPROC;
pub const PFNGLPOLYGONMODEPROC = ?*const fn (face: GLenum, mode: GLenum) callconv(.c) void;
pub extern var glad_glPolygonMode: PFNGLPOLYGONMODEPROC;
pub const PFNGLSCISSORPROC = ?*const fn (x: GLint, y: GLint, width: GLsizei, height: GLsizei) callconv(.c) void;
pub extern var glad_glScissor: PFNGLSCISSORPROC;
pub const PFNGLTEXPARAMETERFPROC = ?*const fn (target: GLenum, pname: GLenum, param: GLfloat) callconv(.c) void;
pub extern var glad_glTexParameterf: PFNGLTEXPARAMETERFPROC;
pub const PFNGLTEXPARAMETERFVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glTexParameterfv: PFNGLTEXPARAMETERFVPROC;
pub const PFNGLTEXPARAMETERIPROC = ?*const fn (target: GLenum, pname: GLenum, param: GLint) callconv(.c) void;
pub extern var glad_glTexParameteri: PFNGLTEXPARAMETERIPROC;
pub const PFNGLTEXPARAMETERIVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]const GLint) callconv(.c) void;
pub extern var glad_glTexParameteriv: PFNGLTEXPARAMETERIVPROC;
pub const PFNGLTEXIMAGE1DPROC = ?*const fn (target: GLenum, level: GLint, internalformat: GLint, width: GLsizei, border: GLint, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glTexImage1D: PFNGLTEXIMAGE1DPROC;
pub const PFNGLTEXIMAGE2DPROC = ?*const fn (target: GLenum, level: GLint, internalformat: GLint, width: GLsizei, height: GLsizei, border: GLint, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glTexImage2D: PFNGLTEXIMAGE2DPROC;
pub const PFNGLDRAWBUFFERPROC = ?*const fn (buf: GLenum) callconv(.c) void;
pub extern var glad_glDrawBuffer: PFNGLDRAWBUFFERPROC;
pub const PFNGLCLEARPROC = ?*const fn (mask: GLbitfield) callconv(.c) void;
pub extern var glad_glClear: PFNGLCLEARPROC;
pub const PFNGLCLEARCOLORPROC = ?*const fn (red: GLfloat, green: GLfloat, blue: GLfloat, alpha: GLfloat) callconv(.c) void;
pub extern var glad_glClearColor: PFNGLCLEARCOLORPROC;
pub const PFNGLCLEARSTENCILPROC = ?*const fn (s: GLint) callconv(.c) void;
pub extern var glad_glClearStencil: PFNGLCLEARSTENCILPROC;
pub const PFNGLCLEARDEPTHPROC = ?*const fn (depth: GLdouble) callconv(.c) void;
pub extern var glad_glClearDepth: PFNGLCLEARDEPTHPROC;
pub const PFNGLSTENCILMASKPROC = ?*const fn (mask: GLuint) callconv(.c) void;
pub extern var glad_glStencilMask: PFNGLSTENCILMASKPROC;
pub const PFNGLCOLORMASKPROC = ?*const fn (red: GLboolean, green: GLboolean, blue: GLboolean, alpha: GLboolean) callconv(.c) void;
pub extern var glad_glColorMask: PFNGLCOLORMASKPROC;
pub const PFNGLDEPTHMASKPROC = ?*const fn (flag: GLboolean) callconv(.c) void;
pub extern var glad_glDepthMask: PFNGLDEPTHMASKPROC;
pub const PFNGLDISABLEPROC = ?*const fn (cap: GLenum) callconv(.c) void;
pub extern var glad_glDisable: PFNGLDISABLEPROC;
pub const PFNGLENABLEPROC = ?*const fn (cap: GLenum) callconv(.c) void;
pub extern var glad_glEnable: PFNGLENABLEPROC;
pub const PFNGLFINISHPROC = ?*const fn () callconv(.c) void;
pub extern var glad_glFinish: PFNGLFINISHPROC;
pub const PFNGLFLUSHPROC = ?*const fn () callconv(.c) void;
pub extern var glad_glFlush: PFNGLFLUSHPROC;
pub const PFNGLBLENDFUNCPROC = ?*const fn (sfactor: GLenum, dfactor: GLenum) callconv(.c) void;
pub extern var glad_glBlendFunc: PFNGLBLENDFUNCPROC;
pub const PFNGLLOGICOPPROC = ?*const fn (opcode: GLenum) callconv(.c) void;
pub extern var glad_glLogicOp: PFNGLLOGICOPPROC;
pub const PFNGLSTENCILFUNCPROC = ?*const fn (func: GLenum, ref: GLint, mask: GLuint) callconv(.c) void;
pub extern var glad_glStencilFunc: PFNGLSTENCILFUNCPROC;
pub const PFNGLSTENCILOPPROC = ?*const fn (fail: GLenum, zfail: GLenum, zpass: GLenum) callconv(.c) void;
pub extern var glad_glStencilOp: PFNGLSTENCILOPPROC;
pub const PFNGLDEPTHFUNCPROC = ?*const fn (func: GLenum) callconv(.c) void;
pub extern var glad_glDepthFunc: PFNGLDEPTHFUNCPROC;
pub const PFNGLPIXELSTOREFPROC = ?*const fn (pname: GLenum, param: GLfloat) callconv(.c) void;
pub extern var glad_glPixelStoref: PFNGLPIXELSTOREFPROC;
pub const PFNGLPIXELSTOREIPROC = ?*const fn (pname: GLenum, param: GLint) callconv(.c) void;
pub extern var glad_glPixelStorei: PFNGLPIXELSTOREIPROC;
pub const PFNGLREADBUFFERPROC = ?*const fn (src: GLenum) callconv(.c) void;
pub extern var glad_glReadBuffer: PFNGLREADBUFFERPROC;
pub const PFNGLREADPIXELSPROC = ?*const fn (x: GLint, y: GLint, width: GLsizei, height: GLsizei, format: GLenum, @"type": GLenum, pixels: ?*anyopaque) callconv(.c) void;
pub extern var glad_glReadPixels: PFNGLREADPIXELSPROC;
pub const PFNGLGETBOOLEANVPROC = ?*const fn (pname: GLenum, data: [*c]GLboolean) callconv(.c) void;
pub extern var glad_glGetBooleanv: PFNGLGETBOOLEANVPROC;
pub const PFNGLGETDOUBLEVPROC = ?*const fn (pname: GLenum, data: [*c]GLdouble) callconv(.c) void;
pub extern var glad_glGetDoublev: PFNGLGETDOUBLEVPROC;
pub const PFNGLGETERRORPROC = ?*const fn () callconv(.c) GLenum;
pub extern var glad_glGetError: PFNGLGETERRORPROC;
pub const PFNGLGETFLOATVPROC = ?*const fn (pname: GLenum, data: [*c]GLfloat) callconv(.c) void;
pub extern var glad_glGetFloatv: PFNGLGETFLOATVPROC;
pub const PFNGLGETINTEGERVPROC = ?*const fn (pname: GLenum, data: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetIntegerv: PFNGLGETINTEGERVPROC;
pub const PFNGLGETSTRINGPROC = ?*const fn (name: GLenum) callconv(.c) [*c]const GLubyte;
pub extern var glad_glGetString: PFNGLGETSTRINGPROC;
pub const PFNGLGETTEXIMAGEPROC = ?*const fn (target: GLenum, level: GLint, format: GLenum, @"type": GLenum, pixels: ?*anyopaque) callconv(.c) void;
pub extern var glad_glGetTexImage: PFNGLGETTEXIMAGEPROC;
pub const PFNGLGETTEXPARAMETERFVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]GLfloat) callconv(.c) void;
pub extern var glad_glGetTexParameterfv: PFNGLGETTEXPARAMETERFVPROC;
pub const PFNGLGETTEXPARAMETERIVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetTexParameteriv: PFNGLGETTEXPARAMETERIVPROC;
pub const PFNGLGETTEXLEVELPARAMETERFVPROC = ?*const fn (target: GLenum, level: GLint, pname: GLenum, params: [*c]GLfloat) callconv(.c) void;
pub extern var glad_glGetTexLevelParameterfv: PFNGLGETTEXLEVELPARAMETERFVPROC;
pub const PFNGLGETTEXLEVELPARAMETERIVPROC = ?*const fn (target: GLenum, level: GLint, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetTexLevelParameteriv: PFNGLGETTEXLEVELPARAMETERIVPROC;
pub const PFNGLISENABLEDPROC = ?*const fn (cap: GLenum) callconv(.c) GLboolean;
pub extern var glad_glIsEnabled: PFNGLISENABLEDPROC;
pub const PFNGLDEPTHRANGEPROC = ?*const fn (n: GLdouble, f: GLdouble) callconv(.c) void;
pub extern var glad_glDepthRange: PFNGLDEPTHRANGEPROC;
pub const PFNGLVIEWPORTPROC = ?*const fn (x: GLint, y: GLint, width: GLsizei, height: GLsizei) callconv(.c) void;
pub extern var glad_glViewport: PFNGLVIEWPORTPROC;
pub extern var GLAD_GL_VERSION_1_1: c_int;
pub const PFNGLDRAWARRAYSPROC = ?*const fn (mode: GLenum, first: GLint, count: GLsizei) callconv(.c) void;
pub extern var glad_glDrawArrays: PFNGLDRAWARRAYSPROC;
pub const PFNGLDRAWELEMENTSPROC = ?*const fn (mode: GLenum, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glDrawElements: PFNGLDRAWELEMENTSPROC;
pub const PFNGLPOLYGONOFFSETPROC = ?*const fn (factor: GLfloat, units: GLfloat) callconv(.c) void;
pub extern var glad_glPolygonOffset: PFNGLPOLYGONOFFSETPROC;
pub const PFNGLCOPYTEXIMAGE1DPROC = ?*const fn (target: GLenum, level: GLint, internalformat: GLenum, x: GLint, y: GLint, width: GLsizei, border: GLint) callconv(.c) void;
pub extern var glad_glCopyTexImage1D: PFNGLCOPYTEXIMAGE1DPROC;
pub const PFNGLCOPYTEXIMAGE2DPROC = ?*const fn (target: GLenum, level: GLint, internalformat: GLenum, x: GLint, y: GLint, width: GLsizei, height: GLsizei, border: GLint) callconv(.c) void;
pub extern var glad_glCopyTexImage2D: PFNGLCOPYTEXIMAGE2DPROC;
pub const PFNGLCOPYTEXSUBIMAGE1DPROC = ?*const fn (target: GLenum, level: GLint, xoffset: GLint, x: GLint, y: GLint, width: GLsizei) callconv(.c) void;
pub extern var glad_glCopyTexSubImage1D: PFNGLCOPYTEXSUBIMAGE1DPROC;
pub const PFNGLCOPYTEXSUBIMAGE2DPROC = ?*const fn (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, x: GLint, y: GLint, width: GLsizei, height: GLsizei) callconv(.c) void;
pub extern var glad_glCopyTexSubImage2D: PFNGLCOPYTEXSUBIMAGE2DPROC;
pub const PFNGLTEXSUBIMAGE1DPROC = ?*const fn (target: GLenum, level: GLint, xoffset: GLint, width: GLsizei, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glTexSubImage1D: PFNGLTEXSUBIMAGE1DPROC;
pub const PFNGLTEXSUBIMAGE2DPROC = ?*const fn (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, width: GLsizei, height: GLsizei, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glTexSubImage2D: PFNGLTEXSUBIMAGE2DPROC;
pub const PFNGLBINDTEXTUREPROC = ?*const fn (target: GLenum, texture: GLuint) callconv(.c) void;
pub extern var glad_glBindTexture: PFNGLBINDTEXTUREPROC;
pub const PFNGLDELETETEXTURESPROC = ?*const fn (n: GLsizei, textures: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glDeleteTextures: PFNGLDELETETEXTURESPROC;
pub const PFNGLGENTEXTURESPROC = ?*const fn (n: GLsizei, textures: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGenTextures: PFNGLGENTEXTURESPROC;
pub const PFNGLISTEXTUREPROC = ?*const fn (texture: GLuint) callconv(.c) GLboolean;
pub extern var glad_glIsTexture: PFNGLISTEXTUREPROC;
pub extern var GLAD_GL_VERSION_1_2: c_int;
pub const PFNGLDRAWRANGEELEMENTSPROC = ?*const fn (mode: GLenum, start: GLuint, end: GLuint, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glDrawRangeElements: PFNGLDRAWRANGEELEMENTSPROC;
pub const PFNGLTEXIMAGE3DPROC = ?*const fn (target: GLenum, level: GLint, internalformat: GLint, width: GLsizei, height: GLsizei, depth: GLsizei, border: GLint, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glTexImage3D: PFNGLTEXIMAGE3DPROC;
pub const PFNGLTEXSUBIMAGE3DPROC = ?*const fn (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, zoffset: GLint, width: GLsizei, height: GLsizei, depth: GLsizei, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glTexSubImage3D: PFNGLTEXSUBIMAGE3DPROC;
pub const PFNGLCOPYTEXSUBIMAGE3DPROC = ?*const fn (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, zoffset: GLint, x: GLint, y: GLint, width: GLsizei, height: GLsizei) callconv(.c) void;
pub extern var glad_glCopyTexSubImage3D: PFNGLCOPYTEXSUBIMAGE3DPROC;
pub extern var GLAD_GL_VERSION_1_3: c_int;
pub const PFNGLACTIVETEXTUREPROC = ?*const fn (texture: GLenum) callconv(.c) void;
pub extern var glad_glActiveTexture: PFNGLACTIVETEXTUREPROC;
pub const PFNGLSAMPLECOVERAGEPROC = ?*const fn (value: GLfloat, invert: GLboolean) callconv(.c) void;
pub extern var glad_glSampleCoverage: PFNGLSAMPLECOVERAGEPROC;
pub const PFNGLCOMPRESSEDTEXIMAGE3DPROC = ?*const fn (target: GLenum, level: GLint, internalformat: GLenum, width: GLsizei, height: GLsizei, depth: GLsizei, border: GLint, imageSize: GLsizei, data: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glCompressedTexImage3D: PFNGLCOMPRESSEDTEXIMAGE3DPROC;
pub const PFNGLCOMPRESSEDTEXIMAGE2DPROC = ?*const fn (target: GLenum, level: GLint, internalformat: GLenum, width: GLsizei, height: GLsizei, border: GLint, imageSize: GLsizei, data: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glCompressedTexImage2D: PFNGLCOMPRESSEDTEXIMAGE2DPROC;
pub const PFNGLCOMPRESSEDTEXIMAGE1DPROC = ?*const fn (target: GLenum, level: GLint, internalformat: GLenum, width: GLsizei, border: GLint, imageSize: GLsizei, data: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glCompressedTexImage1D: PFNGLCOMPRESSEDTEXIMAGE1DPROC;
pub const PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC = ?*const fn (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, zoffset: GLint, width: GLsizei, height: GLsizei, depth: GLsizei, format: GLenum, imageSize: GLsizei, data: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glCompressedTexSubImage3D: PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC;
pub const PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC = ?*const fn (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, width: GLsizei, height: GLsizei, format: GLenum, imageSize: GLsizei, data: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glCompressedTexSubImage2D: PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC;
pub const PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC = ?*const fn (target: GLenum, level: GLint, xoffset: GLint, width: GLsizei, format: GLenum, imageSize: GLsizei, data: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glCompressedTexSubImage1D: PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC;
pub const PFNGLGETCOMPRESSEDTEXIMAGEPROC = ?*const fn (target: GLenum, level: GLint, img: ?*anyopaque) callconv(.c) void;
pub extern var glad_glGetCompressedTexImage: PFNGLGETCOMPRESSEDTEXIMAGEPROC;
pub extern var GLAD_GL_VERSION_1_4: c_int;
pub const PFNGLBLENDFUNCSEPARATEPROC = ?*const fn (sfactorRGB: GLenum, dfactorRGB: GLenum, sfactorAlpha: GLenum, dfactorAlpha: GLenum) callconv(.c) void;
pub extern var glad_glBlendFuncSeparate: PFNGLBLENDFUNCSEPARATEPROC;
pub const PFNGLMULTIDRAWARRAYSPROC = ?*const fn (mode: GLenum, first: [*c]const GLint, count: [*c]const GLsizei, drawcount: GLsizei) callconv(.c) void;
pub extern var glad_glMultiDrawArrays: PFNGLMULTIDRAWARRAYSPROC;
pub const PFNGLMULTIDRAWELEMENTSPROC = ?*const fn (mode: GLenum, count: [*c]const GLsizei, @"type": GLenum, indices: [*c]const ?*const anyopaque, drawcount: GLsizei) callconv(.c) void;
pub extern var glad_glMultiDrawElements: PFNGLMULTIDRAWELEMENTSPROC;
pub const PFNGLPOINTPARAMETERFPROC = ?*const fn (pname: GLenum, param: GLfloat) callconv(.c) void;
pub extern var glad_glPointParameterf: PFNGLPOINTPARAMETERFPROC;
pub const PFNGLPOINTPARAMETERFVPROC = ?*const fn (pname: GLenum, params: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glPointParameterfv: PFNGLPOINTPARAMETERFVPROC;
pub const PFNGLPOINTPARAMETERIPROC = ?*const fn (pname: GLenum, param: GLint) callconv(.c) void;
pub extern var glad_glPointParameteri: PFNGLPOINTPARAMETERIPROC;
pub const PFNGLPOINTPARAMETERIVPROC = ?*const fn (pname: GLenum, params: [*c]const GLint) callconv(.c) void;
pub extern var glad_glPointParameteriv: PFNGLPOINTPARAMETERIVPROC;
pub const PFNGLBLENDCOLORPROC = ?*const fn (red: GLfloat, green: GLfloat, blue: GLfloat, alpha: GLfloat) callconv(.c) void;
pub extern var glad_glBlendColor: PFNGLBLENDCOLORPROC;
pub const PFNGLBLENDEQUATIONPROC = ?*const fn (mode: GLenum) callconv(.c) void;
pub extern var glad_glBlendEquation: PFNGLBLENDEQUATIONPROC;
pub extern var GLAD_GL_VERSION_1_5: c_int;
pub const PFNGLGENQUERIESPROC = ?*const fn (n: GLsizei, ids: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGenQueries: PFNGLGENQUERIESPROC;
pub const PFNGLDELETEQUERIESPROC = ?*const fn (n: GLsizei, ids: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glDeleteQueries: PFNGLDELETEQUERIESPROC;
pub const PFNGLISQUERYPROC = ?*const fn (id: GLuint) callconv(.c) GLboolean;
pub extern var glad_glIsQuery: PFNGLISQUERYPROC;
pub const PFNGLBEGINQUERYPROC = ?*const fn (target: GLenum, id: GLuint) callconv(.c) void;
pub extern var glad_glBeginQuery: PFNGLBEGINQUERYPROC;
pub const PFNGLENDQUERYPROC = ?*const fn (target: GLenum) callconv(.c) void;
pub extern var glad_glEndQuery: PFNGLENDQUERYPROC;
pub const PFNGLGETQUERYIVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetQueryiv: PFNGLGETQUERYIVPROC;
pub const PFNGLGETQUERYOBJECTIVPROC = ?*const fn (id: GLuint, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetQueryObjectiv: PFNGLGETQUERYOBJECTIVPROC;
pub const PFNGLGETQUERYOBJECTUIVPROC = ?*const fn (id: GLuint, pname: GLenum, params: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGetQueryObjectuiv: PFNGLGETQUERYOBJECTUIVPROC;
pub const PFNGLBINDBUFFERPROC = ?*const fn (target: GLenum, buffer: GLuint) callconv(.c) void;
pub extern var glad_glBindBuffer: PFNGLBINDBUFFERPROC;
pub const PFNGLDELETEBUFFERSPROC = ?*const fn (n: GLsizei, buffers: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glDeleteBuffers: PFNGLDELETEBUFFERSPROC;
pub const PFNGLGENBUFFERSPROC = ?*const fn (n: GLsizei, buffers: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGenBuffers: PFNGLGENBUFFERSPROC;
pub const PFNGLISBUFFERPROC = ?*const fn (buffer: GLuint) callconv(.c) GLboolean;
pub extern var glad_glIsBuffer: PFNGLISBUFFERPROC;
pub const PFNGLBUFFERDATAPROC = ?*const fn (target: GLenum, size: GLsizeiptr, data: ?*const anyopaque, usage: GLenum) callconv(.c) void;
pub extern var glad_glBufferData: PFNGLBUFFERDATAPROC;
pub const PFNGLBUFFERSUBDATAPROC = ?*const fn (target: GLenum, offset: GLintptr, size: GLsizeiptr, data: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glBufferSubData: PFNGLBUFFERSUBDATAPROC;
pub const PFNGLGETBUFFERSUBDATAPROC = ?*const fn (target: GLenum, offset: GLintptr, size: GLsizeiptr, data: ?*anyopaque) callconv(.c) void;
pub extern var glad_glGetBufferSubData: PFNGLGETBUFFERSUBDATAPROC;
pub const PFNGLMAPBUFFERPROC = ?*const fn (target: GLenum, access: GLenum) callconv(.c) ?*anyopaque;
pub extern var glad_glMapBuffer: PFNGLMAPBUFFERPROC;
pub const PFNGLUNMAPBUFFERPROC = ?*const fn (target: GLenum) callconv(.c) GLboolean;
pub extern var glad_glUnmapBuffer: PFNGLUNMAPBUFFERPROC;
pub const PFNGLGETBUFFERPARAMETERIVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetBufferParameteriv: PFNGLGETBUFFERPARAMETERIVPROC;
pub const PFNGLGETBUFFERPOINTERVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]?*anyopaque) callconv(.c) void;
pub extern var glad_glGetBufferPointerv: PFNGLGETBUFFERPOINTERVPROC;
pub extern var GLAD_GL_VERSION_2_0: c_int;
pub const PFNGLBLENDEQUATIONSEPARATEPROC = ?*const fn (modeRGB: GLenum, modeAlpha: GLenum) callconv(.c) void;
pub extern var glad_glBlendEquationSeparate: PFNGLBLENDEQUATIONSEPARATEPROC;
pub const PFNGLDRAWBUFFERSPROC = ?*const fn (n: GLsizei, bufs: [*c]const GLenum) callconv(.c) void;
pub extern var glad_glDrawBuffers: PFNGLDRAWBUFFERSPROC;
pub const PFNGLSTENCILOPSEPARATEPROC = ?*const fn (face: GLenum, sfail: GLenum, dpfail: GLenum, dppass: GLenum) callconv(.c) void;
pub extern var glad_glStencilOpSeparate: PFNGLSTENCILOPSEPARATEPROC;
pub const PFNGLSTENCILFUNCSEPARATEPROC = ?*const fn (face: GLenum, func: GLenum, ref: GLint, mask: GLuint) callconv(.c) void;
pub extern var glad_glStencilFuncSeparate: PFNGLSTENCILFUNCSEPARATEPROC;
pub const PFNGLSTENCILMASKSEPARATEPROC = ?*const fn (face: GLenum, mask: GLuint) callconv(.c) void;
pub extern var glad_glStencilMaskSeparate: PFNGLSTENCILMASKSEPARATEPROC;
pub const PFNGLATTACHSHADERPROC = ?*const fn (program: GLuint, shader: GLuint) callconv(.c) void;
pub extern var glad_glAttachShader: PFNGLATTACHSHADERPROC;
pub const PFNGLBINDATTRIBLOCATIONPROC = ?*const fn (program: GLuint, index: GLuint, name: [*c]const GLchar) callconv(.c) void;
pub extern var glad_glBindAttribLocation: PFNGLBINDATTRIBLOCATIONPROC;
pub const PFNGLCOMPILESHADERPROC = ?*const fn (shader: GLuint) callconv(.c) void;
pub extern var glad_glCompileShader: PFNGLCOMPILESHADERPROC;
pub const PFNGLCREATEPROGRAMPROC = ?*const fn () callconv(.c) GLuint;
pub extern var glad_glCreateProgram: PFNGLCREATEPROGRAMPROC;
pub const PFNGLCREATESHADERPROC = ?*const fn (@"type": GLenum) callconv(.c) GLuint;
pub extern var glad_glCreateShader: PFNGLCREATESHADERPROC;
pub const PFNGLDELETEPROGRAMPROC = ?*const fn (program: GLuint) callconv(.c) void;
pub extern var glad_glDeleteProgram: PFNGLDELETEPROGRAMPROC;
pub const PFNGLDELETESHADERPROC = ?*const fn (shader: GLuint) callconv(.c) void;
pub extern var glad_glDeleteShader: PFNGLDELETESHADERPROC;
pub const PFNGLDETACHSHADERPROC = ?*const fn (program: GLuint, shader: GLuint) callconv(.c) void;
pub extern var glad_glDetachShader: PFNGLDETACHSHADERPROC;
pub const PFNGLDISABLEVERTEXATTRIBARRAYPROC = ?*const fn (index: GLuint) callconv(.c) void;
pub extern var glad_glDisableVertexAttribArray: PFNGLDISABLEVERTEXATTRIBARRAYPROC;
pub const PFNGLENABLEVERTEXATTRIBARRAYPROC = ?*const fn (index: GLuint) callconv(.c) void;
pub extern var glad_glEnableVertexAttribArray: PFNGLENABLEVERTEXATTRIBARRAYPROC;
pub const PFNGLGETACTIVEATTRIBPROC = ?*const fn (program: GLuint, index: GLuint, bufSize: GLsizei, length: [*c]GLsizei, size: [*c]GLint, @"type": [*c]GLenum, name: [*c]GLchar) callconv(.c) void;
pub extern var glad_glGetActiveAttrib: PFNGLGETACTIVEATTRIBPROC;
pub const PFNGLGETACTIVEUNIFORMPROC = ?*const fn (program: GLuint, index: GLuint, bufSize: GLsizei, length: [*c]GLsizei, size: [*c]GLint, @"type": [*c]GLenum, name: [*c]GLchar) callconv(.c) void;
pub extern var glad_glGetActiveUniform: PFNGLGETACTIVEUNIFORMPROC;
pub const PFNGLGETATTACHEDSHADERSPROC = ?*const fn (program: GLuint, maxCount: GLsizei, count: [*c]GLsizei, shaders: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGetAttachedShaders: PFNGLGETATTACHEDSHADERSPROC;
pub const PFNGLGETATTRIBLOCATIONPROC = ?*const fn (program: GLuint, name: [*c]const GLchar) callconv(.c) GLint;
pub extern var glad_glGetAttribLocation: PFNGLGETATTRIBLOCATIONPROC;
pub const PFNGLGETPROGRAMIVPROC = ?*const fn (program: GLuint, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetProgramiv: PFNGLGETPROGRAMIVPROC;
pub const PFNGLGETPROGRAMINFOLOGPROC = ?*const fn (program: GLuint, bufSize: GLsizei, length: [*c]GLsizei, infoLog: [*c]GLchar) callconv(.c) void;
pub extern var glad_glGetProgramInfoLog: PFNGLGETPROGRAMINFOLOGPROC;
pub const PFNGLGETSHADERIVPROC = ?*const fn (shader: GLuint, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetShaderiv: PFNGLGETSHADERIVPROC;
pub const PFNGLGETSHADERINFOLOGPROC = ?*const fn (shader: GLuint, bufSize: GLsizei, length: [*c]GLsizei, infoLog: [*c]GLchar) callconv(.c) void;
pub extern var glad_glGetShaderInfoLog: PFNGLGETSHADERINFOLOGPROC;
pub const PFNGLGETSHADERSOURCEPROC = ?*const fn (shader: GLuint, bufSize: GLsizei, length: [*c]GLsizei, source: [*c]GLchar) callconv(.c) void;
pub extern var glad_glGetShaderSource: PFNGLGETSHADERSOURCEPROC;
pub const PFNGLGETUNIFORMLOCATIONPROC = ?*const fn (program: GLuint, name: [*c]const GLchar) callconv(.c) GLint;
pub extern var glad_glGetUniformLocation: PFNGLGETUNIFORMLOCATIONPROC;
pub const PFNGLGETUNIFORMFVPROC = ?*const fn (program: GLuint, location: GLint, params: [*c]GLfloat) callconv(.c) void;
pub extern var glad_glGetUniformfv: PFNGLGETUNIFORMFVPROC;
pub const PFNGLGETUNIFORMIVPROC = ?*const fn (program: GLuint, location: GLint, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetUniformiv: PFNGLGETUNIFORMIVPROC;
pub const PFNGLGETVERTEXATTRIBDVPROC = ?*const fn (index: GLuint, pname: GLenum, params: [*c]GLdouble) callconv(.c) void;
pub extern var glad_glGetVertexAttribdv: PFNGLGETVERTEXATTRIBDVPROC;
pub const PFNGLGETVERTEXATTRIBFVPROC = ?*const fn (index: GLuint, pname: GLenum, params: [*c]GLfloat) callconv(.c) void;
pub extern var glad_glGetVertexAttribfv: PFNGLGETVERTEXATTRIBFVPROC;
pub const PFNGLGETVERTEXATTRIBIVPROC = ?*const fn (index: GLuint, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetVertexAttribiv: PFNGLGETVERTEXATTRIBIVPROC;
pub const PFNGLGETVERTEXATTRIBPOINTERVPROC = ?*const fn (index: GLuint, pname: GLenum, pointer: [*c]?*anyopaque) callconv(.c) void;
pub extern var glad_glGetVertexAttribPointerv: PFNGLGETVERTEXATTRIBPOINTERVPROC;
pub const PFNGLISPROGRAMPROC = ?*const fn (program: GLuint) callconv(.c) GLboolean;
pub extern var glad_glIsProgram: PFNGLISPROGRAMPROC;
pub const PFNGLISSHADERPROC = ?*const fn (shader: GLuint) callconv(.c) GLboolean;
pub extern var glad_glIsShader: PFNGLISSHADERPROC;
pub const PFNGLLINKPROGRAMPROC = ?*const fn (program: GLuint) callconv(.c) void;
pub extern var glad_glLinkProgram: PFNGLLINKPROGRAMPROC;
pub const PFNGLSHADERSOURCEPROC = ?*const fn (shader: GLuint, count: GLsizei, string: [*c]const [*c]const GLchar, length: [*c]const GLint) callconv(.c) void;
pub extern var glad_glShaderSource: PFNGLSHADERSOURCEPROC;
pub const PFNGLUSEPROGRAMPROC = ?*const fn (program: GLuint) callconv(.c) void;
pub extern var glad_glUseProgram: PFNGLUSEPROGRAMPROC;
pub const PFNGLUNIFORM1FPROC = ?*const fn (location: GLint, v0: GLfloat) callconv(.c) void;
pub extern var glad_glUniform1f: PFNGLUNIFORM1FPROC;
pub const PFNGLUNIFORM2FPROC = ?*const fn (location: GLint, v0: GLfloat, v1: GLfloat) callconv(.c) void;
pub extern var glad_glUniform2f: PFNGLUNIFORM2FPROC;
pub const PFNGLUNIFORM3FPROC = ?*const fn (location: GLint, v0: GLfloat, v1: GLfloat, v2: GLfloat) callconv(.c) void;
pub extern var glad_glUniform3f: PFNGLUNIFORM3FPROC;
pub const PFNGLUNIFORM4FPROC = ?*const fn (location: GLint, v0: GLfloat, v1: GLfloat, v2: GLfloat, v3: GLfloat) callconv(.c) void;
pub extern var glad_glUniform4f: PFNGLUNIFORM4FPROC;
pub const PFNGLUNIFORM1IPROC = ?*const fn (location: GLint, v0: GLint) callconv(.c) void;
pub extern var glad_glUniform1i: PFNGLUNIFORM1IPROC;
pub const PFNGLUNIFORM2IPROC = ?*const fn (location: GLint, v0: GLint, v1: GLint) callconv(.c) void;
pub extern var glad_glUniform2i: PFNGLUNIFORM2IPROC;
pub const PFNGLUNIFORM3IPROC = ?*const fn (location: GLint, v0: GLint, v1: GLint, v2: GLint) callconv(.c) void;
pub extern var glad_glUniform3i: PFNGLUNIFORM3IPROC;
pub const PFNGLUNIFORM4IPROC = ?*const fn (location: GLint, v0: GLint, v1: GLint, v2: GLint, v3: GLint) callconv(.c) void;
pub extern var glad_glUniform4i: PFNGLUNIFORM4IPROC;
pub const PFNGLUNIFORM1FVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniform1fv: PFNGLUNIFORM1FVPROC;
pub const PFNGLUNIFORM2FVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniform2fv: PFNGLUNIFORM2FVPROC;
pub const PFNGLUNIFORM3FVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniform3fv: PFNGLUNIFORM3FVPROC;
pub const PFNGLUNIFORM4FVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniform4fv: PFNGLUNIFORM4FVPROC;
pub const PFNGLUNIFORM1IVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLint) callconv(.c) void;
pub extern var glad_glUniform1iv: PFNGLUNIFORM1IVPROC;
pub const PFNGLUNIFORM2IVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLint) callconv(.c) void;
pub extern var glad_glUniform2iv: PFNGLUNIFORM2IVPROC;
pub const PFNGLUNIFORM3IVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLint) callconv(.c) void;
pub extern var glad_glUniform3iv: PFNGLUNIFORM3IVPROC;
pub const PFNGLUNIFORM4IVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLint) callconv(.c) void;
pub extern var glad_glUniform4iv: PFNGLUNIFORM4IVPROC;
pub const PFNGLUNIFORMMATRIX2FVPROC = ?*const fn (location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniformMatrix2fv: PFNGLUNIFORMMATRIX2FVPROC;
pub const PFNGLUNIFORMMATRIX3FVPROC = ?*const fn (location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniformMatrix3fv: PFNGLUNIFORMMATRIX3FVPROC;
pub const PFNGLUNIFORMMATRIX4FVPROC = ?*const fn (location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniformMatrix4fv: PFNGLUNIFORMMATRIX4FVPROC;
pub const PFNGLVALIDATEPROGRAMPROC = ?*const fn (program: GLuint) callconv(.c) void;
pub extern var glad_glValidateProgram: PFNGLVALIDATEPROGRAMPROC;
pub const PFNGLVERTEXATTRIB1DPROC = ?*const fn (index: GLuint, x: GLdouble) callconv(.c) void;
pub extern var glad_glVertexAttrib1d: PFNGLVERTEXATTRIB1DPROC;
pub const PFNGLVERTEXATTRIB1DVPROC = ?*const fn (index: GLuint, v: [*c]const GLdouble) callconv(.c) void;
pub extern var glad_glVertexAttrib1dv: PFNGLVERTEXATTRIB1DVPROC;
pub const PFNGLVERTEXATTRIB1FPROC = ?*const fn (index: GLuint, x: GLfloat) callconv(.c) void;
pub extern var glad_glVertexAttrib1f: PFNGLVERTEXATTRIB1FPROC;
pub const PFNGLVERTEXATTRIB1FVPROC = ?*const fn (index: GLuint, v: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glVertexAttrib1fv: PFNGLVERTEXATTRIB1FVPROC;
pub const PFNGLVERTEXATTRIB1SPROC = ?*const fn (index: GLuint, x: GLshort) callconv(.c) void;
pub extern var glad_glVertexAttrib1s: PFNGLVERTEXATTRIB1SPROC;
pub const PFNGLVERTEXATTRIB1SVPROC = ?*const fn (index: GLuint, v: [*c]const GLshort) callconv(.c) void;
pub extern var glad_glVertexAttrib1sv: PFNGLVERTEXATTRIB1SVPROC;
pub const PFNGLVERTEXATTRIB2DPROC = ?*const fn (index: GLuint, x: GLdouble, y: GLdouble) callconv(.c) void;
pub extern var glad_glVertexAttrib2d: PFNGLVERTEXATTRIB2DPROC;
pub const PFNGLVERTEXATTRIB2DVPROC = ?*const fn (index: GLuint, v: [*c]const GLdouble) callconv(.c) void;
pub extern var glad_glVertexAttrib2dv: PFNGLVERTEXATTRIB2DVPROC;
pub const PFNGLVERTEXATTRIB2FPROC = ?*const fn (index: GLuint, x: GLfloat, y: GLfloat) callconv(.c) void;
pub extern var glad_glVertexAttrib2f: PFNGLVERTEXATTRIB2FPROC;
pub const PFNGLVERTEXATTRIB2FVPROC = ?*const fn (index: GLuint, v: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glVertexAttrib2fv: PFNGLVERTEXATTRIB2FVPROC;
pub const PFNGLVERTEXATTRIB2SPROC = ?*const fn (index: GLuint, x: GLshort, y: GLshort) callconv(.c) void;
pub extern var glad_glVertexAttrib2s: PFNGLVERTEXATTRIB2SPROC;
pub const PFNGLVERTEXATTRIB2SVPROC = ?*const fn (index: GLuint, v: [*c]const GLshort) callconv(.c) void;
pub extern var glad_glVertexAttrib2sv: PFNGLVERTEXATTRIB2SVPROC;
pub const PFNGLVERTEXATTRIB3DPROC = ?*const fn (index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble) callconv(.c) void;
pub extern var glad_glVertexAttrib3d: PFNGLVERTEXATTRIB3DPROC;
pub const PFNGLVERTEXATTRIB3DVPROC = ?*const fn (index: GLuint, v: [*c]const GLdouble) callconv(.c) void;
pub extern var glad_glVertexAttrib3dv: PFNGLVERTEXATTRIB3DVPROC;
pub const PFNGLVERTEXATTRIB3FPROC = ?*const fn (index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat) callconv(.c) void;
pub extern var glad_glVertexAttrib3f: PFNGLVERTEXATTRIB3FPROC;
pub const PFNGLVERTEXATTRIB3FVPROC = ?*const fn (index: GLuint, v: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glVertexAttrib3fv: PFNGLVERTEXATTRIB3FVPROC;
pub const PFNGLVERTEXATTRIB3SPROC = ?*const fn (index: GLuint, x: GLshort, y: GLshort, z: GLshort) callconv(.c) void;
pub extern var glad_glVertexAttrib3s: PFNGLVERTEXATTRIB3SPROC;
pub const PFNGLVERTEXATTRIB3SVPROC = ?*const fn (index: GLuint, v: [*c]const GLshort) callconv(.c) void;
pub extern var glad_glVertexAttrib3sv: PFNGLVERTEXATTRIB3SVPROC;
pub const PFNGLVERTEXATTRIB4NBVPROC = ?*const fn (index: GLuint, v: [*c]const GLbyte) callconv(.c) void;
pub extern var glad_glVertexAttrib4Nbv: PFNGLVERTEXATTRIB4NBVPROC;
pub const PFNGLVERTEXATTRIB4NIVPROC = ?*const fn (index: GLuint, v: [*c]const GLint) callconv(.c) void;
pub extern var glad_glVertexAttrib4Niv: PFNGLVERTEXATTRIB4NIVPROC;
pub const PFNGLVERTEXATTRIB4NSVPROC = ?*const fn (index: GLuint, v: [*c]const GLshort) callconv(.c) void;
pub extern var glad_glVertexAttrib4Nsv: PFNGLVERTEXATTRIB4NSVPROC;
pub const PFNGLVERTEXATTRIB4NUBPROC = ?*const fn (index: GLuint, x: GLubyte, y: GLubyte, z: GLubyte, w: GLubyte) callconv(.c) void;
pub extern var glad_glVertexAttrib4Nub: PFNGLVERTEXATTRIB4NUBPROC;
pub const PFNGLVERTEXATTRIB4NUBVPROC = ?*const fn (index: GLuint, v: [*c]const GLubyte) callconv(.c) void;
pub extern var glad_glVertexAttrib4Nubv: PFNGLVERTEXATTRIB4NUBVPROC;
pub const PFNGLVERTEXATTRIB4NUIVPROC = ?*const fn (index: GLuint, v: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexAttrib4Nuiv: PFNGLVERTEXATTRIB4NUIVPROC;
pub const PFNGLVERTEXATTRIB4NUSVPROC = ?*const fn (index: GLuint, v: [*c]const GLushort) callconv(.c) void;
pub extern var glad_glVertexAttrib4Nusv: PFNGLVERTEXATTRIB4NUSVPROC;
pub const PFNGLVERTEXATTRIB4BVPROC = ?*const fn (index: GLuint, v: [*c]const GLbyte) callconv(.c) void;
pub extern var glad_glVertexAttrib4bv: PFNGLVERTEXATTRIB4BVPROC;
pub const PFNGLVERTEXATTRIB4DPROC = ?*const fn (index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble, w: GLdouble) callconv(.c) void;
pub extern var glad_glVertexAttrib4d: PFNGLVERTEXATTRIB4DPROC;
pub const PFNGLVERTEXATTRIB4DVPROC = ?*const fn (index: GLuint, v: [*c]const GLdouble) callconv(.c) void;
pub extern var glad_glVertexAttrib4dv: PFNGLVERTEXATTRIB4DVPROC;
pub const PFNGLVERTEXATTRIB4FPROC = ?*const fn (index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat) callconv(.c) void;
pub extern var glad_glVertexAttrib4f: PFNGLVERTEXATTRIB4FPROC;
pub const PFNGLVERTEXATTRIB4FVPROC = ?*const fn (index: GLuint, v: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glVertexAttrib4fv: PFNGLVERTEXATTRIB4FVPROC;
pub const PFNGLVERTEXATTRIB4IVPROC = ?*const fn (index: GLuint, v: [*c]const GLint) callconv(.c) void;
pub extern var glad_glVertexAttrib4iv: PFNGLVERTEXATTRIB4IVPROC;
pub const PFNGLVERTEXATTRIB4SPROC = ?*const fn (index: GLuint, x: GLshort, y: GLshort, z: GLshort, w: GLshort) callconv(.c) void;
pub extern var glad_glVertexAttrib4s: PFNGLVERTEXATTRIB4SPROC;
pub const PFNGLVERTEXATTRIB4SVPROC = ?*const fn (index: GLuint, v: [*c]const GLshort) callconv(.c) void;
pub extern var glad_glVertexAttrib4sv: PFNGLVERTEXATTRIB4SVPROC;
pub const PFNGLVERTEXATTRIB4UBVPROC = ?*const fn (index: GLuint, v: [*c]const GLubyte) callconv(.c) void;
pub extern var glad_glVertexAttrib4ubv: PFNGLVERTEXATTRIB4UBVPROC;
pub const PFNGLVERTEXATTRIB4UIVPROC = ?*const fn (index: GLuint, v: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexAttrib4uiv: PFNGLVERTEXATTRIB4UIVPROC;
pub const PFNGLVERTEXATTRIB4USVPROC = ?*const fn (index: GLuint, v: [*c]const GLushort) callconv(.c) void;
pub extern var glad_glVertexAttrib4usv: PFNGLVERTEXATTRIB4USVPROC;
pub const PFNGLVERTEXATTRIBPOINTERPROC = ?*const fn (index: GLuint, size: GLint, @"type": GLenum, normalized: GLboolean, stride: GLsizei, pointer: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glVertexAttribPointer: PFNGLVERTEXATTRIBPOINTERPROC;
pub extern var GLAD_GL_VERSION_2_1: c_int;
pub const PFNGLUNIFORMMATRIX2X3FVPROC = ?*const fn (location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniformMatrix2x3fv: PFNGLUNIFORMMATRIX2X3FVPROC;
pub const PFNGLUNIFORMMATRIX3X2FVPROC = ?*const fn (location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniformMatrix3x2fv: PFNGLUNIFORMMATRIX3X2FVPROC;
pub const PFNGLUNIFORMMATRIX2X4FVPROC = ?*const fn (location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniformMatrix2x4fv: PFNGLUNIFORMMATRIX2X4FVPROC;
pub const PFNGLUNIFORMMATRIX4X2FVPROC = ?*const fn (location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniformMatrix4x2fv: PFNGLUNIFORMMATRIX4X2FVPROC;
pub const PFNGLUNIFORMMATRIX3X4FVPROC = ?*const fn (location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniformMatrix3x4fv: PFNGLUNIFORMMATRIX3X4FVPROC;
pub const PFNGLUNIFORMMATRIX4X3FVPROC = ?*const fn (location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glUniformMatrix4x3fv: PFNGLUNIFORMMATRIX4X3FVPROC;
pub extern var GLAD_GL_VERSION_3_0: c_int;
pub const PFNGLCOLORMASKIPROC = ?*const fn (index: GLuint, r: GLboolean, g: GLboolean, b: GLboolean, a: GLboolean) callconv(.c) void;
pub extern var glad_glColorMaski: PFNGLCOLORMASKIPROC;
pub const PFNGLGETBOOLEANI_VPROC = ?*const fn (target: GLenum, index: GLuint, data: [*c]GLboolean) callconv(.c) void;
pub extern var glad_glGetBooleani_v: PFNGLGETBOOLEANI_VPROC;
pub const PFNGLGETINTEGERI_VPROC = ?*const fn (target: GLenum, index: GLuint, data: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetIntegeri_v: PFNGLGETINTEGERI_VPROC;
pub const PFNGLENABLEIPROC = ?*const fn (target: GLenum, index: GLuint) callconv(.c) void;
pub extern var glad_glEnablei: PFNGLENABLEIPROC;
pub const PFNGLDISABLEIPROC = ?*const fn (target: GLenum, index: GLuint) callconv(.c) void;
pub extern var glad_glDisablei: PFNGLDISABLEIPROC;
pub const PFNGLISENABLEDIPROC = ?*const fn (target: GLenum, index: GLuint) callconv(.c) GLboolean;
pub extern var glad_glIsEnabledi: PFNGLISENABLEDIPROC;
pub const PFNGLBEGINTRANSFORMFEEDBACKPROC = ?*const fn (primitiveMode: GLenum) callconv(.c) void;
pub extern var glad_glBeginTransformFeedback: PFNGLBEGINTRANSFORMFEEDBACKPROC;
pub const PFNGLENDTRANSFORMFEEDBACKPROC = ?*const fn () callconv(.c) void;
pub extern var glad_glEndTransformFeedback: PFNGLENDTRANSFORMFEEDBACKPROC;
pub const PFNGLBINDBUFFERRANGEPROC = ?*const fn (target: GLenum, index: GLuint, buffer: GLuint, offset: GLintptr, size: GLsizeiptr) callconv(.c) void;
pub extern var glad_glBindBufferRange: PFNGLBINDBUFFERRANGEPROC;
pub const PFNGLBINDBUFFERBASEPROC = ?*const fn (target: GLenum, index: GLuint, buffer: GLuint) callconv(.c) void;
pub extern var glad_glBindBufferBase: PFNGLBINDBUFFERBASEPROC;
pub const PFNGLTRANSFORMFEEDBACKVARYINGSPROC = ?*const fn (program: GLuint, count: GLsizei, varyings: [*c]const [*c]const GLchar, bufferMode: GLenum) callconv(.c) void;
pub extern var glad_glTransformFeedbackVaryings: PFNGLTRANSFORMFEEDBACKVARYINGSPROC;
pub const PFNGLGETTRANSFORMFEEDBACKVARYINGPROC = ?*const fn (program: GLuint, index: GLuint, bufSize: GLsizei, length: [*c]GLsizei, size: [*c]GLsizei, @"type": [*c]GLenum, name: [*c]GLchar) callconv(.c) void;
pub extern var glad_glGetTransformFeedbackVarying: PFNGLGETTRANSFORMFEEDBACKVARYINGPROC;
pub const PFNGLCLAMPCOLORPROC = ?*const fn (target: GLenum, clamp: GLenum) callconv(.c) void;
pub extern var glad_glClampColor: PFNGLCLAMPCOLORPROC;
pub const PFNGLBEGINCONDITIONALRENDERPROC = ?*const fn (id: GLuint, mode: GLenum) callconv(.c) void;
pub extern var glad_glBeginConditionalRender: PFNGLBEGINCONDITIONALRENDERPROC;
pub const PFNGLENDCONDITIONALRENDERPROC = ?*const fn () callconv(.c) void;
pub extern var glad_glEndConditionalRender: PFNGLENDCONDITIONALRENDERPROC;
pub const PFNGLVERTEXATTRIBIPOINTERPROC = ?*const fn (index: GLuint, size: GLint, @"type": GLenum, stride: GLsizei, pointer: ?*const anyopaque) callconv(.c) void;
pub extern var glad_glVertexAttribIPointer: PFNGLVERTEXATTRIBIPOINTERPROC;
pub const PFNGLGETVERTEXATTRIBIIVPROC = ?*const fn (index: GLuint, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetVertexAttribIiv: PFNGLGETVERTEXATTRIBIIVPROC;
pub const PFNGLGETVERTEXATTRIBIUIVPROC = ?*const fn (index: GLuint, pname: GLenum, params: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGetVertexAttribIuiv: PFNGLGETVERTEXATTRIBIUIVPROC;
pub const PFNGLVERTEXATTRIBI1IPROC = ?*const fn (index: GLuint, x: GLint) callconv(.c) void;
pub extern var glad_glVertexAttribI1i: PFNGLVERTEXATTRIBI1IPROC;
pub const PFNGLVERTEXATTRIBI2IPROC = ?*const fn (index: GLuint, x: GLint, y: GLint) callconv(.c) void;
pub extern var glad_glVertexAttribI2i: PFNGLVERTEXATTRIBI2IPROC;
pub const PFNGLVERTEXATTRIBI3IPROC = ?*const fn (index: GLuint, x: GLint, y: GLint, z: GLint) callconv(.c) void;
pub extern var glad_glVertexAttribI3i: PFNGLVERTEXATTRIBI3IPROC;
pub const PFNGLVERTEXATTRIBI4IPROC = ?*const fn (index: GLuint, x: GLint, y: GLint, z: GLint, w: GLint) callconv(.c) void;
pub extern var glad_glVertexAttribI4i: PFNGLVERTEXATTRIBI4IPROC;
pub const PFNGLVERTEXATTRIBI1UIPROC = ?*const fn (index: GLuint, x: GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribI1ui: PFNGLVERTEXATTRIBI1UIPROC;
pub const PFNGLVERTEXATTRIBI2UIPROC = ?*const fn (index: GLuint, x: GLuint, y: GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribI2ui: PFNGLVERTEXATTRIBI2UIPROC;
pub const PFNGLVERTEXATTRIBI3UIPROC = ?*const fn (index: GLuint, x: GLuint, y: GLuint, z: GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribI3ui: PFNGLVERTEXATTRIBI3UIPROC;
pub const PFNGLVERTEXATTRIBI4UIPROC = ?*const fn (index: GLuint, x: GLuint, y: GLuint, z: GLuint, w: GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribI4ui: PFNGLVERTEXATTRIBI4UIPROC;
pub const PFNGLVERTEXATTRIBI1IVPROC = ?*const fn (index: GLuint, v: [*c]const GLint) callconv(.c) void;
pub extern var glad_glVertexAttribI1iv: PFNGLVERTEXATTRIBI1IVPROC;
pub const PFNGLVERTEXATTRIBI2IVPROC = ?*const fn (index: GLuint, v: [*c]const GLint) callconv(.c) void;
pub extern var glad_glVertexAttribI2iv: PFNGLVERTEXATTRIBI2IVPROC;
pub const PFNGLVERTEXATTRIBI3IVPROC = ?*const fn (index: GLuint, v: [*c]const GLint) callconv(.c) void;
pub extern var glad_glVertexAttribI3iv: PFNGLVERTEXATTRIBI3IVPROC;
pub const PFNGLVERTEXATTRIBI4IVPROC = ?*const fn (index: GLuint, v: [*c]const GLint) callconv(.c) void;
pub extern var glad_glVertexAttribI4iv: PFNGLVERTEXATTRIBI4IVPROC;
pub const PFNGLVERTEXATTRIBI1UIVPROC = ?*const fn (index: GLuint, v: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribI1uiv: PFNGLVERTEXATTRIBI1UIVPROC;
pub const PFNGLVERTEXATTRIBI2UIVPROC = ?*const fn (index: GLuint, v: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribI2uiv: PFNGLVERTEXATTRIBI2UIVPROC;
pub const PFNGLVERTEXATTRIBI3UIVPROC = ?*const fn (index: GLuint, v: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribI3uiv: PFNGLVERTEXATTRIBI3UIVPROC;
pub const PFNGLVERTEXATTRIBI4UIVPROC = ?*const fn (index: GLuint, v: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribI4uiv: PFNGLVERTEXATTRIBI4UIVPROC;
pub const PFNGLVERTEXATTRIBI4BVPROC = ?*const fn (index: GLuint, v: [*c]const GLbyte) callconv(.c) void;
pub extern var glad_glVertexAttribI4bv: PFNGLVERTEXATTRIBI4BVPROC;
pub const PFNGLVERTEXATTRIBI4SVPROC = ?*const fn (index: GLuint, v: [*c]const GLshort) callconv(.c) void;
pub extern var glad_glVertexAttribI4sv: PFNGLVERTEXATTRIBI4SVPROC;
pub const PFNGLVERTEXATTRIBI4UBVPROC = ?*const fn (index: GLuint, v: [*c]const GLubyte) callconv(.c) void;
pub extern var glad_glVertexAttribI4ubv: PFNGLVERTEXATTRIBI4UBVPROC;
pub const PFNGLVERTEXATTRIBI4USVPROC = ?*const fn (index: GLuint, v: [*c]const GLushort) callconv(.c) void;
pub extern var glad_glVertexAttribI4usv: PFNGLVERTEXATTRIBI4USVPROC;
pub const PFNGLGETUNIFORMUIVPROC = ?*const fn (program: GLuint, location: GLint, params: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGetUniformuiv: PFNGLGETUNIFORMUIVPROC;
pub const PFNGLBINDFRAGDATALOCATIONPROC = ?*const fn (program: GLuint, color: GLuint, name: [*c]const GLchar) callconv(.c) void;
pub extern var glad_glBindFragDataLocation: PFNGLBINDFRAGDATALOCATIONPROC;
pub const PFNGLGETFRAGDATALOCATIONPROC = ?*const fn (program: GLuint, name: [*c]const GLchar) callconv(.c) GLint;
pub extern var glad_glGetFragDataLocation: PFNGLGETFRAGDATALOCATIONPROC;
pub const PFNGLUNIFORM1UIPROC = ?*const fn (location: GLint, v0: GLuint) callconv(.c) void;
pub extern var glad_glUniform1ui: PFNGLUNIFORM1UIPROC;
pub const PFNGLUNIFORM2UIPROC = ?*const fn (location: GLint, v0: GLuint, v1: GLuint) callconv(.c) void;
pub extern var glad_glUniform2ui: PFNGLUNIFORM2UIPROC;
pub const PFNGLUNIFORM3UIPROC = ?*const fn (location: GLint, v0: GLuint, v1: GLuint, v2: GLuint) callconv(.c) void;
pub extern var glad_glUniform3ui: PFNGLUNIFORM3UIPROC;
pub const PFNGLUNIFORM4UIPROC = ?*const fn (location: GLint, v0: GLuint, v1: GLuint, v2: GLuint, v3: GLuint) callconv(.c) void;
pub extern var glad_glUniform4ui: PFNGLUNIFORM4UIPROC;
pub const PFNGLUNIFORM1UIVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glUniform1uiv: PFNGLUNIFORM1UIVPROC;
pub const PFNGLUNIFORM2UIVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glUniform2uiv: PFNGLUNIFORM2UIVPROC;
pub const PFNGLUNIFORM3UIVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glUniform3uiv: PFNGLUNIFORM3UIVPROC;
pub const PFNGLUNIFORM4UIVPROC = ?*const fn (location: GLint, count: GLsizei, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glUniform4uiv: PFNGLUNIFORM4UIVPROC;
pub const PFNGLTEXPARAMETERIIVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]const GLint) callconv(.c) void;
pub extern var glad_glTexParameterIiv: PFNGLTEXPARAMETERIIVPROC;
pub const PFNGLTEXPARAMETERIUIVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glTexParameterIuiv: PFNGLTEXPARAMETERIUIVPROC;
pub const PFNGLGETTEXPARAMETERIIVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetTexParameterIiv: PFNGLGETTEXPARAMETERIIVPROC;
pub const PFNGLGETTEXPARAMETERIUIVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGetTexParameterIuiv: PFNGLGETTEXPARAMETERIUIVPROC;
pub const PFNGLCLEARBUFFERIVPROC = ?*const fn (buffer: GLenum, drawbuffer: GLint, value: [*c]const GLint) callconv(.c) void;
pub extern var glad_glClearBufferiv: PFNGLCLEARBUFFERIVPROC;
pub const PFNGLCLEARBUFFERUIVPROC = ?*const fn (buffer: GLenum, drawbuffer: GLint, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glClearBufferuiv: PFNGLCLEARBUFFERUIVPROC;
pub const PFNGLCLEARBUFFERFVPROC = ?*const fn (buffer: GLenum, drawbuffer: GLint, value: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glClearBufferfv: PFNGLCLEARBUFFERFVPROC;
pub const PFNGLCLEARBUFFERFIPROC = ?*const fn (buffer: GLenum, drawbuffer: GLint, depth: GLfloat, stencil: GLint) callconv(.c) void;
pub extern var glad_glClearBufferfi: PFNGLCLEARBUFFERFIPROC;
pub const PFNGLGETSTRINGIPROC = ?*const fn (name: GLenum, index: GLuint) callconv(.c) [*c]const GLubyte;
pub extern var glad_glGetStringi: PFNGLGETSTRINGIPROC;
pub const PFNGLISRENDERBUFFERPROC = ?*const fn (renderbuffer: GLuint) callconv(.c) GLboolean;
pub extern var glad_glIsRenderbuffer: PFNGLISRENDERBUFFERPROC;
pub const PFNGLBINDRENDERBUFFERPROC = ?*const fn (target: GLenum, renderbuffer: GLuint) callconv(.c) void;
pub extern var glad_glBindRenderbuffer: PFNGLBINDRENDERBUFFERPROC;
pub const PFNGLDELETERENDERBUFFERSPROC = ?*const fn (n: GLsizei, renderbuffers: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glDeleteRenderbuffers: PFNGLDELETERENDERBUFFERSPROC;
pub const PFNGLGENRENDERBUFFERSPROC = ?*const fn (n: GLsizei, renderbuffers: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGenRenderbuffers: PFNGLGENRENDERBUFFERSPROC;
pub const PFNGLRENDERBUFFERSTORAGEPROC = ?*const fn (target: GLenum, internalformat: GLenum, width: GLsizei, height: GLsizei) callconv(.c) void;
pub extern var glad_glRenderbufferStorage: PFNGLRENDERBUFFERSTORAGEPROC;
pub const PFNGLGETRENDERBUFFERPARAMETERIVPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetRenderbufferParameteriv: PFNGLGETRENDERBUFFERPARAMETERIVPROC;
pub const PFNGLISFRAMEBUFFERPROC = ?*const fn (framebuffer: GLuint) callconv(.c) GLboolean;
pub extern var glad_glIsFramebuffer: PFNGLISFRAMEBUFFERPROC;
pub const PFNGLBINDFRAMEBUFFERPROC = ?*const fn (target: GLenum, framebuffer: GLuint) callconv(.c) void;
pub extern var glad_glBindFramebuffer: PFNGLBINDFRAMEBUFFERPROC;
pub const PFNGLDELETEFRAMEBUFFERSPROC = ?*const fn (n: GLsizei, framebuffers: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glDeleteFramebuffers: PFNGLDELETEFRAMEBUFFERSPROC;
pub const PFNGLGENFRAMEBUFFERSPROC = ?*const fn (n: GLsizei, framebuffers: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGenFramebuffers: PFNGLGENFRAMEBUFFERSPROC;
pub const PFNGLCHECKFRAMEBUFFERSTATUSPROC = ?*const fn (target: GLenum) callconv(.c) GLenum;
pub extern var glad_glCheckFramebufferStatus: PFNGLCHECKFRAMEBUFFERSTATUSPROC;
pub const PFNGLFRAMEBUFFERTEXTURE1DPROC = ?*const fn (target: GLenum, attachment: GLenum, textarget: GLenum, texture: GLuint, level: GLint) callconv(.c) void;
pub extern var glad_glFramebufferTexture1D: PFNGLFRAMEBUFFERTEXTURE1DPROC;
pub const PFNGLFRAMEBUFFERTEXTURE2DPROC = ?*const fn (target: GLenum, attachment: GLenum, textarget: GLenum, texture: GLuint, level: GLint) callconv(.c) void;
pub extern var glad_glFramebufferTexture2D: PFNGLFRAMEBUFFERTEXTURE2DPROC;
pub const PFNGLFRAMEBUFFERTEXTURE3DPROC = ?*const fn (target: GLenum, attachment: GLenum, textarget: GLenum, texture: GLuint, level: GLint, zoffset: GLint) callconv(.c) void;
pub extern var glad_glFramebufferTexture3D: PFNGLFRAMEBUFFERTEXTURE3DPROC;
pub const PFNGLFRAMEBUFFERRENDERBUFFERPROC = ?*const fn (target: GLenum, attachment: GLenum, renderbuffertarget: GLenum, renderbuffer: GLuint) callconv(.c) void;
pub extern var glad_glFramebufferRenderbuffer: PFNGLFRAMEBUFFERRENDERBUFFERPROC;
pub const PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC = ?*const fn (target: GLenum, attachment: GLenum, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetFramebufferAttachmentParameteriv: PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC;
pub const PFNGLGENERATEMIPMAPPROC = ?*const fn (target: GLenum) callconv(.c) void;
pub extern var glad_glGenerateMipmap: PFNGLGENERATEMIPMAPPROC;
pub const PFNGLBLITFRAMEBUFFERPROC = ?*const fn (srcX0: GLint, srcY0: GLint, srcX1: GLint, srcY1: GLint, dstX0: GLint, dstY0: GLint, dstX1: GLint, dstY1: GLint, mask: GLbitfield, filter: GLenum) callconv(.c) void;
pub extern var glad_glBlitFramebuffer: PFNGLBLITFRAMEBUFFERPROC;
pub const PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC = ?*const fn (target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei) callconv(.c) void;
pub extern var glad_glRenderbufferStorageMultisample: PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC;
pub const PFNGLFRAMEBUFFERTEXTURELAYERPROC = ?*const fn (target: GLenum, attachment: GLenum, texture: GLuint, level: GLint, layer: GLint) callconv(.c) void;
pub extern var glad_glFramebufferTextureLayer: PFNGLFRAMEBUFFERTEXTURELAYERPROC;
pub const PFNGLMAPBUFFERRANGEPROC = ?*const fn (target: GLenum, offset: GLintptr, length: GLsizeiptr, access: GLbitfield) callconv(.c) ?*anyopaque;
pub extern var glad_glMapBufferRange: PFNGLMAPBUFFERRANGEPROC;
pub const PFNGLFLUSHMAPPEDBUFFERRANGEPROC = ?*const fn (target: GLenum, offset: GLintptr, length: GLsizeiptr) callconv(.c) void;
pub extern var glad_glFlushMappedBufferRange: PFNGLFLUSHMAPPEDBUFFERRANGEPROC;
pub const PFNGLBINDVERTEXARRAYPROC = ?*const fn (array: GLuint) callconv(.c) void;
pub extern var glad_glBindVertexArray: PFNGLBINDVERTEXARRAYPROC;
pub const PFNGLDELETEVERTEXARRAYSPROC = ?*const fn (n: GLsizei, arrays: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glDeleteVertexArrays: PFNGLDELETEVERTEXARRAYSPROC;
pub const PFNGLGENVERTEXARRAYSPROC = ?*const fn (n: GLsizei, arrays: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGenVertexArrays: PFNGLGENVERTEXARRAYSPROC;
pub const PFNGLISVERTEXARRAYPROC = ?*const fn (array: GLuint) callconv(.c) GLboolean;
pub extern var glad_glIsVertexArray: PFNGLISVERTEXARRAYPROC;
pub extern var GLAD_GL_VERSION_3_1: c_int;
pub const PFNGLDRAWARRAYSINSTANCEDPROC = ?*const fn (mode: GLenum, first: GLint, count: GLsizei, instancecount: GLsizei) callconv(.c) void;
pub extern var glad_glDrawArraysInstanced: PFNGLDRAWARRAYSINSTANCEDPROC;
pub const PFNGLDRAWELEMENTSINSTANCEDPROC = ?*const fn (mode: GLenum, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque, instancecount: GLsizei) callconv(.c) void;
pub extern var glad_glDrawElementsInstanced: PFNGLDRAWELEMENTSINSTANCEDPROC;
pub const PFNGLTEXBUFFERPROC = ?*const fn (target: GLenum, internalformat: GLenum, buffer: GLuint) callconv(.c) void;
pub extern var glad_glTexBuffer: PFNGLTEXBUFFERPROC;
pub const PFNGLPRIMITIVERESTARTINDEXPROC = ?*const fn (index: GLuint) callconv(.c) void;
pub extern var glad_glPrimitiveRestartIndex: PFNGLPRIMITIVERESTARTINDEXPROC;
pub const PFNGLCOPYBUFFERSUBDATAPROC = ?*const fn (readTarget: GLenum, writeTarget: GLenum, readOffset: GLintptr, writeOffset: GLintptr, size: GLsizeiptr) callconv(.c) void;
pub extern var glad_glCopyBufferSubData: PFNGLCOPYBUFFERSUBDATAPROC;
pub const PFNGLGETUNIFORMINDICESPROC = ?*const fn (program: GLuint, uniformCount: GLsizei, uniformNames: [*c]const [*c]const GLchar, uniformIndices: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGetUniformIndices: PFNGLGETUNIFORMINDICESPROC;
pub const PFNGLGETACTIVEUNIFORMSIVPROC = ?*const fn (program: GLuint, uniformCount: GLsizei, uniformIndices: [*c]const GLuint, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetActiveUniformsiv: PFNGLGETACTIVEUNIFORMSIVPROC;
pub const PFNGLGETACTIVEUNIFORMNAMEPROC = ?*const fn (program: GLuint, uniformIndex: GLuint, bufSize: GLsizei, length: [*c]GLsizei, uniformName: [*c]GLchar) callconv(.c) void;
pub extern var glad_glGetActiveUniformName: PFNGLGETACTIVEUNIFORMNAMEPROC;
pub const PFNGLGETUNIFORMBLOCKINDEXPROC = ?*const fn (program: GLuint, uniformBlockName: [*c]const GLchar) callconv(.c) GLuint;
pub extern var glad_glGetUniformBlockIndex: PFNGLGETUNIFORMBLOCKINDEXPROC;
pub const PFNGLGETACTIVEUNIFORMBLOCKIVPROC = ?*const fn (program: GLuint, uniformBlockIndex: GLuint, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetActiveUniformBlockiv: PFNGLGETACTIVEUNIFORMBLOCKIVPROC;
pub const PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC = ?*const fn (program: GLuint, uniformBlockIndex: GLuint, bufSize: GLsizei, length: [*c]GLsizei, uniformBlockName: [*c]GLchar) callconv(.c) void;
pub extern var glad_glGetActiveUniformBlockName: PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC;
pub const PFNGLUNIFORMBLOCKBINDINGPROC = ?*const fn (program: GLuint, uniformBlockIndex: GLuint, uniformBlockBinding: GLuint) callconv(.c) void;
pub extern var glad_glUniformBlockBinding: PFNGLUNIFORMBLOCKBINDINGPROC;
pub extern var GLAD_GL_VERSION_3_2: c_int;
pub const PFNGLDRAWELEMENTSBASEVERTEXPROC = ?*const fn (mode: GLenum, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque, basevertex: GLint) callconv(.c) void;
pub extern var glad_glDrawElementsBaseVertex: PFNGLDRAWELEMENTSBASEVERTEXPROC;
pub const PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC = ?*const fn (mode: GLenum, start: GLuint, end: GLuint, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque, basevertex: GLint) callconv(.c) void;
pub extern var glad_glDrawRangeElementsBaseVertex: PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC;
pub const PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC = ?*const fn (mode: GLenum, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque, instancecount: GLsizei, basevertex: GLint) callconv(.c) void;
pub extern var glad_glDrawElementsInstancedBaseVertex: PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC;
pub const PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC = ?*const fn (mode: GLenum, count: [*c]const GLsizei, @"type": GLenum, indices: [*c]const ?*const anyopaque, drawcount: GLsizei, basevertex: [*c]const GLint) callconv(.c) void;
pub extern var glad_glMultiDrawElementsBaseVertex: PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC;
pub const PFNGLPROVOKINGVERTEXPROC = ?*const fn (mode: GLenum) callconv(.c) void;
pub extern var glad_glProvokingVertex: PFNGLPROVOKINGVERTEXPROC;
pub const PFNGLFENCESYNCPROC = ?*const fn (condition: GLenum, flags: GLbitfield) callconv(.c) GLsync;
pub extern var glad_glFenceSync: PFNGLFENCESYNCPROC;
pub const PFNGLISSYNCPROC = ?*const fn (sync: GLsync) callconv(.c) GLboolean;
pub extern var glad_glIsSync: PFNGLISSYNCPROC;
pub const PFNGLDELETESYNCPROC = ?*const fn (sync: GLsync) callconv(.c) void;
pub extern var glad_glDeleteSync: PFNGLDELETESYNCPROC;
pub const PFNGLCLIENTWAITSYNCPROC = ?*const fn (sync: GLsync, flags: GLbitfield, timeout: GLuint64) callconv(.c) GLenum;
pub extern var glad_glClientWaitSync: PFNGLCLIENTWAITSYNCPROC;
pub const PFNGLWAITSYNCPROC = ?*const fn (sync: GLsync, flags: GLbitfield, timeout: GLuint64) callconv(.c) void;
pub extern var glad_glWaitSync: PFNGLWAITSYNCPROC;
pub const PFNGLGETINTEGER64VPROC = ?*const fn (pname: GLenum, data: [*c]GLint64) callconv(.c) void;
pub extern var glad_glGetInteger64v: PFNGLGETINTEGER64VPROC;
pub const PFNGLGETSYNCIVPROC = ?*const fn (sync: GLsync, pname: GLenum, count: GLsizei, length: [*c]GLsizei, values: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetSynciv: PFNGLGETSYNCIVPROC;
pub const PFNGLGETINTEGER64I_VPROC = ?*const fn (target: GLenum, index: GLuint, data: [*c]GLint64) callconv(.c) void;
pub extern var glad_glGetInteger64i_v: PFNGLGETINTEGER64I_VPROC;
pub const PFNGLGETBUFFERPARAMETERI64VPROC = ?*const fn (target: GLenum, pname: GLenum, params: [*c]GLint64) callconv(.c) void;
pub extern var glad_glGetBufferParameteri64v: PFNGLGETBUFFERPARAMETERI64VPROC;
pub const PFNGLFRAMEBUFFERTEXTUREPROC = ?*const fn (target: GLenum, attachment: GLenum, texture: GLuint, level: GLint) callconv(.c) void;
pub extern var glad_glFramebufferTexture: PFNGLFRAMEBUFFERTEXTUREPROC;
pub const PFNGLTEXIMAGE2DMULTISAMPLEPROC = ?*const fn (target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei, fixedsamplelocations: GLboolean) callconv(.c) void;
pub extern var glad_glTexImage2DMultisample: PFNGLTEXIMAGE2DMULTISAMPLEPROC;
pub const PFNGLTEXIMAGE3DMULTISAMPLEPROC = ?*const fn (target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei, depth: GLsizei, fixedsamplelocations: GLboolean) callconv(.c) void;
pub extern var glad_glTexImage3DMultisample: PFNGLTEXIMAGE3DMULTISAMPLEPROC;
pub const PFNGLGETMULTISAMPLEFVPROC = ?*const fn (pname: GLenum, index: GLuint, val: [*c]GLfloat) callconv(.c) void;
pub extern var glad_glGetMultisamplefv: PFNGLGETMULTISAMPLEFVPROC;
pub const PFNGLSAMPLEMASKIPROC = ?*const fn (maskNumber: GLuint, mask: GLbitfield) callconv(.c) void;
pub extern var glad_glSampleMaski: PFNGLSAMPLEMASKIPROC;
pub extern var GLAD_GL_VERSION_3_3: c_int;
pub const PFNGLBINDFRAGDATALOCATIONINDEXEDPROC = ?*const fn (program: GLuint, colorNumber: GLuint, index: GLuint, name: [*c]const GLchar) callconv(.c) void;
pub extern var glad_glBindFragDataLocationIndexed: PFNGLBINDFRAGDATALOCATIONINDEXEDPROC;
pub const PFNGLGETFRAGDATAINDEXPROC = ?*const fn (program: GLuint, name: [*c]const GLchar) callconv(.c) GLint;
pub extern var glad_glGetFragDataIndex: PFNGLGETFRAGDATAINDEXPROC;
pub const PFNGLGENSAMPLERSPROC = ?*const fn (count: GLsizei, samplers: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGenSamplers: PFNGLGENSAMPLERSPROC;
pub const PFNGLDELETESAMPLERSPROC = ?*const fn (count: GLsizei, samplers: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glDeleteSamplers: PFNGLDELETESAMPLERSPROC;
pub const PFNGLISSAMPLERPROC = ?*const fn (sampler: GLuint) callconv(.c) GLboolean;
pub extern var glad_glIsSampler: PFNGLISSAMPLERPROC;
pub const PFNGLBINDSAMPLERPROC = ?*const fn (unit: GLuint, sampler: GLuint) callconv(.c) void;
pub extern var glad_glBindSampler: PFNGLBINDSAMPLERPROC;
pub const PFNGLSAMPLERPARAMETERIPROC = ?*const fn (sampler: GLuint, pname: GLenum, param: GLint) callconv(.c) void;
pub extern var glad_glSamplerParameteri: PFNGLSAMPLERPARAMETERIPROC;
pub const PFNGLSAMPLERPARAMETERIVPROC = ?*const fn (sampler: GLuint, pname: GLenum, param: [*c]const GLint) callconv(.c) void;
pub extern var glad_glSamplerParameteriv: PFNGLSAMPLERPARAMETERIVPROC;
pub const PFNGLSAMPLERPARAMETERFPROC = ?*const fn (sampler: GLuint, pname: GLenum, param: GLfloat) callconv(.c) void;
pub extern var glad_glSamplerParameterf: PFNGLSAMPLERPARAMETERFPROC;
pub const PFNGLSAMPLERPARAMETERFVPROC = ?*const fn (sampler: GLuint, pname: GLenum, param: [*c]const GLfloat) callconv(.c) void;
pub extern var glad_glSamplerParameterfv: PFNGLSAMPLERPARAMETERFVPROC;
pub const PFNGLSAMPLERPARAMETERIIVPROC = ?*const fn (sampler: GLuint, pname: GLenum, param: [*c]const GLint) callconv(.c) void;
pub extern var glad_glSamplerParameterIiv: PFNGLSAMPLERPARAMETERIIVPROC;
pub const PFNGLSAMPLERPARAMETERIUIVPROC = ?*const fn (sampler: GLuint, pname: GLenum, param: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glSamplerParameterIuiv: PFNGLSAMPLERPARAMETERIUIVPROC;
pub const PFNGLGETSAMPLERPARAMETERIVPROC = ?*const fn (sampler: GLuint, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetSamplerParameteriv: PFNGLGETSAMPLERPARAMETERIVPROC;
pub const PFNGLGETSAMPLERPARAMETERIIVPROC = ?*const fn (sampler: GLuint, pname: GLenum, params: [*c]GLint) callconv(.c) void;
pub extern var glad_glGetSamplerParameterIiv: PFNGLGETSAMPLERPARAMETERIIVPROC;
pub const PFNGLGETSAMPLERPARAMETERFVPROC = ?*const fn (sampler: GLuint, pname: GLenum, params: [*c]GLfloat) callconv(.c) void;
pub extern var glad_glGetSamplerParameterfv: PFNGLGETSAMPLERPARAMETERFVPROC;
pub const PFNGLGETSAMPLERPARAMETERIUIVPROC = ?*const fn (sampler: GLuint, pname: GLenum, params: [*c]GLuint) callconv(.c) void;
pub extern var glad_glGetSamplerParameterIuiv: PFNGLGETSAMPLERPARAMETERIUIVPROC;
pub const PFNGLQUERYCOUNTERPROC = ?*const fn (id: GLuint, target: GLenum) callconv(.c) void;
pub extern var glad_glQueryCounter: PFNGLQUERYCOUNTERPROC;
pub const PFNGLGETQUERYOBJECTI64VPROC = ?*const fn (id: GLuint, pname: GLenum, params: [*c]GLint64) callconv(.c) void;
pub extern var glad_glGetQueryObjecti64v: PFNGLGETQUERYOBJECTI64VPROC;
pub const PFNGLGETQUERYOBJECTUI64VPROC = ?*const fn (id: GLuint, pname: GLenum, params: [*c]GLuint64) callconv(.c) void;
pub extern var glad_glGetQueryObjectui64v: PFNGLGETQUERYOBJECTUI64VPROC;
pub const PFNGLVERTEXATTRIBDIVISORPROC = ?*const fn (index: GLuint, divisor: GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribDivisor: PFNGLVERTEXATTRIBDIVISORPROC;
pub const PFNGLVERTEXATTRIBP1UIPROC = ?*const fn (index: GLuint, @"type": GLenum, normalized: GLboolean, value: GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribP1ui: PFNGLVERTEXATTRIBP1UIPROC;
pub const PFNGLVERTEXATTRIBP1UIVPROC = ?*const fn (index: GLuint, @"type": GLenum, normalized: GLboolean, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribP1uiv: PFNGLVERTEXATTRIBP1UIVPROC;
pub const PFNGLVERTEXATTRIBP2UIPROC = ?*const fn (index: GLuint, @"type": GLenum, normalized: GLboolean, value: GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribP2ui: PFNGLVERTEXATTRIBP2UIPROC;
pub const PFNGLVERTEXATTRIBP2UIVPROC = ?*const fn (index: GLuint, @"type": GLenum, normalized: GLboolean, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribP2uiv: PFNGLVERTEXATTRIBP2UIVPROC;
pub const PFNGLVERTEXATTRIBP3UIPROC = ?*const fn (index: GLuint, @"type": GLenum, normalized: GLboolean, value: GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribP3ui: PFNGLVERTEXATTRIBP3UIPROC;
pub const PFNGLVERTEXATTRIBP3UIVPROC = ?*const fn (index: GLuint, @"type": GLenum, normalized: GLboolean, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribP3uiv: PFNGLVERTEXATTRIBP3UIVPROC;
pub const PFNGLVERTEXATTRIBP4UIPROC = ?*const fn (index: GLuint, @"type": GLenum, normalized: GLboolean, value: GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribP4ui: PFNGLVERTEXATTRIBP4UIPROC;
pub const PFNGLVERTEXATTRIBP4UIVPROC = ?*const fn (index: GLuint, @"type": GLenum, normalized: GLboolean, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexAttribP4uiv: PFNGLVERTEXATTRIBP4UIVPROC;
pub const PFNGLVERTEXP2UIPROC = ?*const fn (@"type": GLenum, value: GLuint) callconv(.c) void;
pub extern var glad_glVertexP2ui: PFNGLVERTEXP2UIPROC;
pub const PFNGLVERTEXP2UIVPROC = ?*const fn (@"type": GLenum, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexP2uiv: PFNGLVERTEXP2UIVPROC;
pub const PFNGLVERTEXP3UIPROC = ?*const fn (@"type": GLenum, value: GLuint) callconv(.c) void;
pub extern var glad_glVertexP3ui: PFNGLVERTEXP3UIPROC;
pub const PFNGLVERTEXP3UIVPROC = ?*const fn (@"type": GLenum, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexP3uiv: PFNGLVERTEXP3UIVPROC;
pub const PFNGLVERTEXP4UIPROC = ?*const fn (@"type": GLenum, value: GLuint) callconv(.c) void;
pub extern var glad_glVertexP4ui: PFNGLVERTEXP4UIPROC;
pub const PFNGLVERTEXP4UIVPROC = ?*const fn (@"type": GLenum, value: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glVertexP4uiv: PFNGLVERTEXP4UIVPROC;
pub const PFNGLTEXCOORDP1UIPROC = ?*const fn (@"type": GLenum, coords: GLuint) callconv(.c) void;
pub extern var glad_glTexCoordP1ui: PFNGLTEXCOORDP1UIPROC;
pub const PFNGLTEXCOORDP1UIVPROC = ?*const fn (@"type": GLenum, coords: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glTexCoordP1uiv: PFNGLTEXCOORDP1UIVPROC;
pub const PFNGLTEXCOORDP2UIPROC = ?*const fn (@"type": GLenum, coords: GLuint) callconv(.c) void;
pub extern var glad_glTexCoordP2ui: PFNGLTEXCOORDP2UIPROC;
pub const PFNGLTEXCOORDP2UIVPROC = ?*const fn (@"type": GLenum, coords: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glTexCoordP2uiv: PFNGLTEXCOORDP2UIVPROC;
pub const PFNGLTEXCOORDP3UIPROC = ?*const fn (@"type": GLenum, coords: GLuint) callconv(.c) void;
pub extern var glad_glTexCoordP3ui: PFNGLTEXCOORDP3UIPROC;
pub const PFNGLTEXCOORDP3UIVPROC = ?*const fn (@"type": GLenum, coords: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glTexCoordP3uiv: PFNGLTEXCOORDP3UIVPROC;
pub const PFNGLTEXCOORDP4UIPROC = ?*const fn (@"type": GLenum, coords: GLuint) callconv(.c) void;
pub extern var glad_glTexCoordP4ui: PFNGLTEXCOORDP4UIPROC;
pub const PFNGLTEXCOORDP4UIVPROC = ?*const fn (@"type": GLenum, coords: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glTexCoordP4uiv: PFNGLTEXCOORDP4UIVPROC;
pub const PFNGLMULTITEXCOORDP1UIPROC = ?*const fn (texture: GLenum, @"type": GLenum, coords: GLuint) callconv(.c) void;
pub extern var glad_glMultiTexCoordP1ui: PFNGLMULTITEXCOORDP1UIPROC;
pub const PFNGLMULTITEXCOORDP1UIVPROC = ?*const fn (texture: GLenum, @"type": GLenum, coords: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glMultiTexCoordP1uiv: PFNGLMULTITEXCOORDP1UIVPROC;
pub const PFNGLMULTITEXCOORDP2UIPROC = ?*const fn (texture: GLenum, @"type": GLenum, coords: GLuint) callconv(.c) void;
pub extern var glad_glMultiTexCoordP2ui: PFNGLMULTITEXCOORDP2UIPROC;
pub const PFNGLMULTITEXCOORDP2UIVPROC = ?*const fn (texture: GLenum, @"type": GLenum, coords: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glMultiTexCoordP2uiv: PFNGLMULTITEXCOORDP2UIVPROC;
pub const PFNGLMULTITEXCOORDP3UIPROC = ?*const fn (texture: GLenum, @"type": GLenum, coords: GLuint) callconv(.c) void;
pub extern var glad_glMultiTexCoordP3ui: PFNGLMULTITEXCOORDP3UIPROC;
pub const PFNGLMULTITEXCOORDP3UIVPROC = ?*const fn (texture: GLenum, @"type": GLenum, coords: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glMultiTexCoordP3uiv: PFNGLMULTITEXCOORDP3UIVPROC;
pub const PFNGLMULTITEXCOORDP4UIPROC = ?*const fn (texture: GLenum, @"type": GLenum, coords: GLuint) callconv(.c) void;
pub extern var glad_glMultiTexCoordP4ui: PFNGLMULTITEXCOORDP4UIPROC;
pub const PFNGLMULTITEXCOORDP4UIVPROC = ?*const fn (texture: GLenum, @"type": GLenum, coords: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glMultiTexCoordP4uiv: PFNGLMULTITEXCOORDP4UIVPROC;
pub const PFNGLNORMALP3UIPROC = ?*const fn (@"type": GLenum, coords: GLuint) callconv(.c) void;
pub extern var glad_glNormalP3ui: PFNGLNORMALP3UIPROC;
pub const PFNGLNORMALP3UIVPROC = ?*const fn (@"type": GLenum, coords: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glNormalP3uiv: PFNGLNORMALP3UIVPROC;
pub const PFNGLCOLORP3UIPROC = ?*const fn (@"type": GLenum, color: GLuint) callconv(.c) void;
pub extern var glad_glColorP3ui: PFNGLCOLORP3UIPROC;
pub const PFNGLCOLORP3UIVPROC = ?*const fn (@"type": GLenum, color: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glColorP3uiv: PFNGLCOLORP3UIVPROC;
pub const PFNGLCOLORP4UIPROC = ?*const fn (@"type": GLenum, color: GLuint) callconv(.c) void;
pub extern var glad_glColorP4ui: PFNGLCOLORP4UIPROC;
pub const PFNGLCOLORP4UIVPROC = ?*const fn (@"type": GLenum, color: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glColorP4uiv: PFNGLCOLORP4UIVPROC;
pub const PFNGLSECONDARYCOLORP3UIPROC = ?*const fn (@"type": GLenum, color: GLuint) callconv(.c) void;
pub extern var glad_glSecondaryColorP3ui: PFNGLSECONDARYCOLORP3UIPROC;
pub const PFNGLSECONDARYCOLORP3UIVPROC = ?*const fn (@"type": GLenum, color: [*c]const GLuint) callconv(.c) void;
pub extern var glad_glSecondaryColorP3uiv: PFNGLSECONDARYCOLORP3UIVPROC;

pub const __VERSION__ = "Aro aro-zig";
pub const __Aro__ = "";
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __STDC_EMBED_NOT_FOUND__ = @as(c_int, 0);
pub const __STDC_EMBED_FOUND__ = @as(c_int, 1);
pub const __STDC_EMBED_EMPTY__ = @as(c_int, 2);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __GNUC__ = @as(c_int, 7);
pub const __GNUC_MINOR__ = @as(c_int, 1);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 0);
pub const __ARO_EMULATE_NO__ = @as(c_int, 0);
pub const __ARO_EMULATE_CLANG__ = @as(c_int, 1);
pub const __ARO_EMULATE_GCC__ = @as(c_int, 2);
pub const __ARO_EMULATE_MSVC__ = @as(c_int, 3);
pub const __ARO_EMULATE__ = __ARO_EMULATE_GCC__;
pub inline fn __building_module(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub const linux = @as(c_int, 1);
pub const __linux = @as(c_int, 1);
pub const __linux__ = @as(c_int, 1);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `address_space`"); // <builtin>:33:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `address_space`"); // <builtin>:34:9
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __AES__ = @as(c_int, 1);
pub const __PCLMUL__ = @as(c_int, 1);
pub const __LZCNT__ = @as(c_int, 1);
pub const __RDRND__ = @as(c_int, 1);
pub const __FSGSBASE__ = @as(c_int, 1);
pub const __BMI__ = @as(c_int, 1);
pub const __BMI2__ = @as(c_int, 1);
pub const __POPCNT__ = @as(c_int, 1);
pub const __MOVBE__ = @as(c_int, 1);
pub const __FMA__ = @as(c_int, 1);
pub const __F16C__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __XSAVE__ = @as(c_int, 1);
pub const __XSAVEOPT__ = @as(c_int, 1);
pub const __INVPCID__ = @as(c_int, 1);
pub const __CRC32__ = @as(c_int, 1);
pub const __AVX2__ = @as(c_int, 1);
pub const __AVX__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const __ELF__ = @as(c_int, 1);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __ATOMIC_BOOL_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WINT_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_SHORT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_INT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LLONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_POINTER_LOCK_FREE = @as(c_int, 1);
pub const __WINT_UNSIGNED__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SCHAR_WIDTH__ = @as(c_int, 8);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __LONG_LONG_WIDTH__ = @as(c_int, 64);
pub const __WCHAR_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIG_ATOMIC_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __BITINT_MAXWIDTH__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 10);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTPTR_TYPE__ = c_long;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // <builtin>:139:9
pub const __INTMAX_C = __helpers.L_SUFFIX;
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // <builtin>:142:9
pub const __UINTMAX_C = __helpers.UL_SUFFIX;
pub const __PTRDIFF_TYPE__ = c_long;
pub const __SIZE_TYPE__ = c_ulong;
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_uint;
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub inline fn __INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub inline fn __INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub inline fn __INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT64_TYPE__ = c_long;
pub const __INT64_FMTd__ = "ld";
pub const __INT64_FMTi__ = "li";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // <builtin>:168:9
pub const __INT64_C = __helpers.L_SUFFIX;
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub inline fn __UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub inline fn __UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`"); // <builtin>:193:9
pub const __UINT32_C = __helpers.U_SUFFIX;
pub const __UINT32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulong;
pub const __UINT64_FMTo__ = "lo";
pub const __UINT64_FMTu__ = "lu";
pub const __UINT64_FMTx__ = "lx";
pub const __UINT64_FMTX__ = "lX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // <builtin>:202:9
pub const __UINT64_C = __helpers.UL_SUFFIX;
pub const __UINT64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __INT64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const INT_LEAST8_FMTd__ = "hhd";
pub const INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const UINT_LEAST8_FMTo__ = "hho";
pub const UINT_LEAST8_FMTu__ = "hhu";
pub const UINT_LEAST8_FMTx__ = "hhx";
pub const UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const INT_FAST8_FMTd__ = "hhd";
pub const INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const UINT_FAST8_FMTo__ = "hho";
pub const UINT_FAST8_FMTu__ = "hhu";
pub const UINT_FAST8_FMTx__ = "hhx";
pub const UINT_FAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const INT_LEAST16_FMTd__ = "hd";
pub const INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST16_FMTo__ = "ho";
pub const UINT_LEAST16_FMTu__ = "hu";
pub const UINT_LEAST16_FMTx__ = "hx";
pub const UINT_LEAST16_FMTX__ = "hX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const INT_FAST16_FMTd__ = "hd";
pub const INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_FAST16_FMTo__ = "ho";
pub const UINT_FAST16_FMTu__ = "hu";
pub const UINT_FAST16_FMTx__ = "hx";
pub const UINT_FAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const INT_LEAST32_FMTd__ = "d";
pub const INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST32_FMTo__ = "o";
pub const UINT_LEAST32_FMTu__ = "u";
pub const UINT_LEAST32_FMTx__ = "x";
pub const UINT_LEAST32_FMTX__ = "X";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const INT_FAST32_FMTd__ = "d";
pub const INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_FAST32_FMTo__ = "o";
pub const UINT_FAST32_FMTu__ = "u";
pub const UINT_FAST32_FMTx__ = "x";
pub const UINT_FAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const INT_LEAST64_FMTd__ = "ld";
pub const INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_LEAST64_FMTo__ = "lo";
pub const UINT_LEAST64_FMTu__ = "lu";
pub const UINT_LEAST64_FMTx__ = "lx";
pub const UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const INT_FAST64_FMTd__ = "ld";
pub const INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_FMTo__ = "lo";
pub const UINT_FAST64_FMTu__ = "lu";
pub const UINT_FAST64_FMTx__ = "lx";
pub const UINT_FAST64_FMTX__ = "lX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_HAS_DENORM__ = "";
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = "";
pub const __FLT16_HAS_QUIET_NAN__ = "";
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = "";
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = "";
pub const __FLT_HAS_QUIET_NAN__ = "";
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = "";
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = "";
pub const __DBL_HAS_QUIET_NAN__ = "";
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_HAS_DENORM__ = "";
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = "";
pub const __LDBL_HAS_QUIET_NAN__ = "";
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __FLT_EVAL_METHOD__ = @as(c_int, 0);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __glad_h_ = "";
pub const __gl_h_ = "";
pub const APIENTRY = "";
pub const APIENTRYP = @compileError("unable to translate C expr: unexpected token ''"); // glad.h:39:9
pub const GLAPIENTRY = "";
pub const GLAPI = @compileError("unable to translate C expr: unexpected token 'extern'"); // glad.h:79:11
pub const __khrplatform_h_ = "";
pub const KHRONOS_APICALL = "";
pub const KHRONOS_APIENTRY = "";
pub const KHRONOS_APIATTRIBUTES = "";
pub const __CLANG_STDINT_H = "";
pub const __int_least64_t = i64;
pub const __uint_least64_t = u64;
pub const __uint32_t_defined = "";
pub const __int_least32_t = i32;
pub const __uint_least32_t = u32;
pub const __int_least16_t = i16;
pub const __uint_least16_t = u16;
pub const __int_least8_t = i8;
pub const __uint_least8_t = u8;
pub const __int8_t_defined = "";
pub const __stdint_join3 = @compileError("unable to translate C expr: unexpected token '##'"); // /home/mhrun/progs/zig/lib/include/stdint.h:291:9
pub const __intptr_t_defined = "";
pub const _INTPTR_T = "";
pub const _UINTPTR_T = "";
pub inline fn INT64_C(v: anytype) @TypeOf(__INT64_C(v)) {
    _ = &v;
    return __INT64_C(v);
}
pub inline fn UINT64_C(v: anytype) @TypeOf(__UINT64_C(v)) {
    _ = &v;
    return __UINT64_C(v);
}
pub inline fn INT32_C(v: anytype) @TypeOf(__INT32_C(v)) {
    _ = &v;
    return __INT32_C(v);
}
pub inline fn UINT32_C(v: anytype) @TypeOf(__UINT32_C(v)) {
    _ = &v;
    return __UINT32_C(v);
}
pub inline fn INT16_C(v: anytype) @TypeOf(__INT16_C(v)) {
    _ = &v;
    return __INT16_C(v);
}
pub inline fn UINT16_C(v: anytype) @TypeOf(__UINT16_C(v)) {
    _ = &v;
    return __UINT16_C(v);
}
pub inline fn INT8_C(v: anytype) @TypeOf(__INT8_C(v)) {
    _ = &v;
    return __INT8_C(v);
}
pub inline fn UINT8_C(v: anytype) @TypeOf(__UINT8_C(v)) {
    _ = &v;
    return __UINT8_C(v);
}
pub const INT64_MAX = INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const INT64_MIN = -INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const UINT64_MAX = UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const __INT_LEAST64_MIN = INT64_MIN;
pub const __INT_LEAST64_MAX = INT64_MAX;
pub const __UINT_LEAST64_MAX = UINT64_MAX;
pub const INT_LEAST64_MIN = __INT_LEAST64_MIN;
pub const INT_LEAST64_MAX = __INT_LEAST64_MAX;
pub const UINT_LEAST64_MAX = __UINT_LEAST64_MAX;
pub const INT_FAST64_MIN = __INT_LEAST64_MIN;
pub const INT_FAST64_MAX = __INT_LEAST64_MAX;
pub const UINT_FAST64_MAX = __UINT_LEAST64_MAX;
pub const INT32_MAX = INT32_C(__helpers.promoteIntLiteral(c_int, 2147483647, .decimal));
pub const INT32_MIN = -INT32_C(__helpers.promoteIntLiteral(c_int, 2147483647, .decimal)) - @as(c_int, 1);
pub const UINT32_MAX = UINT32_C(__helpers.promoteIntLiteral(c_int, 4294967295, .decimal));
pub const __INT_LEAST32_MIN = INT32_MIN;
pub const __INT_LEAST32_MAX = INT32_MAX;
pub const __UINT_LEAST32_MAX = UINT32_MAX;
pub const INT_LEAST32_MIN = __INT_LEAST32_MIN;
pub const INT_LEAST32_MAX = __INT_LEAST32_MAX;
pub const UINT_LEAST32_MAX = __UINT_LEAST32_MAX;
pub const INT_FAST32_MIN = __INT_LEAST32_MIN;
pub const INT_FAST32_MAX = __INT_LEAST32_MAX;
pub const UINT_FAST32_MAX = __UINT_LEAST32_MAX;
pub const INT16_MAX = INT16_C(@as(c_int, 32767));
pub const INT16_MIN = -INT16_C(@as(c_int, 32767)) - @as(c_int, 1);
pub const UINT16_MAX = UINT16_C(__helpers.promoteIntLiteral(c_int, 65535, .decimal));
pub const __INT_LEAST16_MIN = INT16_MIN;
pub const __INT_LEAST16_MAX = INT16_MAX;
pub const __UINT_LEAST16_MAX = UINT16_MAX;
pub const INT_LEAST16_MIN = __INT_LEAST16_MIN;
pub const INT_LEAST16_MAX = __INT_LEAST16_MAX;
pub const UINT_LEAST16_MAX = __UINT_LEAST16_MAX;
pub const INT_FAST16_MIN = __INT_LEAST16_MIN;
pub const INT_FAST16_MAX = __INT_LEAST16_MAX;
pub const UINT_FAST16_MAX = __UINT_LEAST16_MAX;
pub const INT8_MAX = INT8_C(@as(c_int, 127));
pub const INT8_MIN = -INT8_C(@as(c_int, 127)) - @as(c_int, 1);
pub const UINT8_MAX = UINT8_C(@as(c_int, 255));
pub const __INT_LEAST8_MIN = INT8_MIN;
pub const __INT_LEAST8_MAX = INT8_MAX;
pub const __UINT_LEAST8_MAX = UINT8_MAX;
pub const INT_LEAST8_MIN = __INT_LEAST8_MIN;
pub const INT_LEAST8_MAX = __INT_LEAST8_MAX;
pub const UINT_LEAST8_MAX = __UINT_LEAST8_MAX;
pub const INT_FAST8_MIN = __INT_LEAST8_MIN;
pub const INT_FAST8_MAX = __INT_LEAST8_MAX;
pub const UINT_FAST8_MAX = __UINT_LEAST8_MAX;
pub const __INTN_MIN = @compileError("unable to translate macro: undefined identifier `INT`"); // /home/mhrun/progs/zig/lib/include/stdint.h:764:10
pub const __INTN_MAX = @compileError("unable to translate macro: undefined identifier `INT`"); // /home/mhrun/progs/zig/lib/include/stdint.h:765:10
pub const __UINTN_MAX = @compileError("unable to translate macro: undefined identifier `UINT`"); // /home/mhrun/progs/zig/lib/include/stdint.h:766:9
pub const __INTN_C = @compileError("unable to translate macro: undefined identifier `INT`"); // /home/mhrun/progs/zig/lib/include/stdint.h:767:10
pub const __UINTN_C = @compileError("unable to translate macro: undefined identifier `UINT`"); // /home/mhrun/progs/zig/lib/include/stdint.h:768:9
pub const INTPTR_MIN = -__INTPTR_MAX__ - @as(c_int, 1);
pub const INTPTR_MAX = __INTPTR_MAX__;
pub const UINTPTR_MAX = __UINTPTR_MAX__;
pub const PTRDIFF_MIN = -__PTRDIFF_MAX__ - @as(c_int, 1);
pub const PTRDIFF_MAX = __PTRDIFF_MAX__;
pub const SIZE_MAX = __SIZE_MAX__;
pub const INTMAX_MIN = -__INTMAX_MAX__ - @as(c_int, 1);
pub const INTMAX_MAX = __INTMAX_MAX__;
pub const UINTMAX_MAX = __UINTMAX_MAX__;
pub const SIG_ATOMIC_MIN = __INTN_MIN(__SIG_ATOMIC_WIDTH__);
pub const SIG_ATOMIC_MAX = __INTN_MAX(__SIG_ATOMIC_WIDTH__);
pub const WINT_MIN = __UINTN_C(__WINT_WIDTH__, @as(c_int, 0));
pub const WINT_MAX = __UINTN_MAX(__WINT_WIDTH__);
pub const WCHAR_MAX = __WCHAR_MAX__;
pub const WCHAR_MIN = __INTN_MIN(__WCHAR_WIDTH__);
pub inline fn INTMAX_C(v: anytype) @TypeOf(__INTMAX_C(v)) {
    _ = &v;
    return __INTMAX_C(v);
}
pub inline fn UINTMAX_C(v: anytype) @TypeOf(__UINTMAX_C(v)) {
    _ = &v;
    return __UINTMAX_C(v);
}
pub const KHRONOS_SUPPORT_INT64 = @as(c_int, 1);
pub const KHRONOS_SUPPORT_FLOAT = @as(c_int, 1);
pub const KHRONOS_MAX_ENUM = __helpers.promoteIntLiteral(c_int, 0x7FFFFFFF, .hex);
pub const GL_DEPTH_BUFFER_BIT = @as(c_int, 0x00000100);
pub const GL_STENCIL_BUFFER_BIT = @as(c_int, 0x00000400);
pub const GL_COLOR_BUFFER_BIT = @as(c_int, 0x00004000);
pub const GL_FALSE = @as(c_int, 0);
pub const GL_TRUE = @as(c_int, 1);
pub const GL_POINTS = @as(c_int, 0x0000);
pub const GL_LINES = @as(c_int, 0x0001);
pub const GL_LINE_LOOP = @as(c_int, 0x0002);
pub const GL_LINE_STRIP = @as(c_int, 0x0003);
pub const GL_TRIANGLES = @as(c_int, 0x0004);
pub const GL_TRIANGLE_STRIP = @as(c_int, 0x0005);
pub const GL_TRIANGLE_FAN = @as(c_int, 0x0006);
pub const GL_NEVER = @as(c_int, 0x0200);
pub const GL_LESS = @as(c_int, 0x0201);
pub const GL_EQUAL = @as(c_int, 0x0202);
pub const GL_LEQUAL = @as(c_int, 0x0203);
pub const GL_GREATER = @as(c_int, 0x0204);
pub const GL_NOTEQUAL = @as(c_int, 0x0205);
pub const GL_GEQUAL = @as(c_int, 0x0206);
pub const GL_ALWAYS = @as(c_int, 0x0207);
pub const GL_ZERO = @as(c_int, 0);
pub const GL_ONE = @as(c_int, 1);
pub const GL_SRC_COLOR = @as(c_int, 0x0300);
pub const GL_ONE_MINUS_SRC_COLOR = @as(c_int, 0x0301);
pub const GL_SRC_ALPHA = @as(c_int, 0x0302);
pub const GL_ONE_MINUS_SRC_ALPHA = @as(c_int, 0x0303);
pub const GL_DST_ALPHA = @as(c_int, 0x0304);
pub const GL_ONE_MINUS_DST_ALPHA = @as(c_int, 0x0305);
pub const GL_DST_COLOR = @as(c_int, 0x0306);
pub const GL_ONE_MINUS_DST_COLOR = @as(c_int, 0x0307);
pub const GL_SRC_ALPHA_SATURATE = @as(c_int, 0x0308);
pub const GL_NONE = @as(c_int, 0);
pub const GL_FRONT_LEFT = @as(c_int, 0x0400);
pub const GL_FRONT_RIGHT = @as(c_int, 0x0401);
pub const GL_BACK_LEFT = @as(c_int, 0x0402);
pub const GL_BACK_RIGHT = @as(c_int, 0x0403);
pub const GL_FRONT = @as(c_int, 0x0404);
pub const GL_BACK = @as(c_int, 0x0405);
pub const GL_LEFT = @as(c_int, 0x0406);
pub const GL_RIGHT = @as(c_int, 0x0407);
pub const GL_FRONT_AND_BACK = @as(c_int, 0x0408);
pub const GL_NO_ERROR = @as(c_int, 0);
pub const GL_INVALID_ENUM = @as(c_int, 0x0500);
pub const GL_INVALID_VALUE = @as(c_int, 0x0501);
pub const GL_INVALID_OPERATION = @as(c_int, 0x0502);
pub const GL_OUT_OF_MEMORY = @as(c_int, 0x0505);
pub const GL_CW = @as(c_int, 0x0900);
pub const GL_CCW = @as(c_int, 0x0901);
pub const GL_POINT_SIZE = @as(c_int, 0x0B11);
pub const GL_POINT_SIZE_RANGE = @as(c_int, 0x0B12);
pub const GL_POINT_SIZE_GRANULARITY = @as(c_int, 0x0B13);
pub const GL_LINE_SMOOTH = @as(c_int, 0x0B20);
pub const GL_LINE_WIDTH = @as(c_int, 0x0B21);
pub const GL_LINE_WIDTH_RANGE = @as(c_int, 0x0B22);
pub const GL_LINE_WIDTH_GRANULARITY = @as(c_int, 0x0B23);
pub const GL_POLYGON_MODE = @as(c_int, 0x0B40);
pub const GL_POLYGON_SMOOTH = @as(c_int, 0x0B41);
pub const GL_CULL_FACE = @as(c_int, 0x0B44);
pub const GL_CULL_FACE_MODE = @as(c_int, 0x0B45);
pub const GL_FRONT_FACE = @as(c_int, 0x0B46);
pub const GL_DEPTH_RANGE = @as(c_int, 0x0B70);
pub const GL_DEPTH_TEST = @as(c_int, 0x0B71);
pub const GL_DEPTH_WRITEMASK = @as(c_int, 0x0B72);
pub const GL_DEPTH_CLEAR_VALUE = @as(c_int, 0x0B73);
pub const GL_DEPTH_FUNC = @as(c_int, 0x0B74);
pub const GL_STENCIL_TEST = @as(c_int, 0x0B90);
pub const GL_STENCIL_CLEAR_VALUE = @as(c_int, 0x0B91);
pub const GL_STENCIL_FUNC = @as(c_int, 0x0B92);
pub const GL_STENCIL_VALUE_MASK = @as(c_int, 0x0B93);
pub const GL_STENCIL_FAIL = @as(c_int, 0x0B94);
pub const GL_STENCIL_PASS_DEPTH_FAIL = @as(c_int, 0x0B95);
pub const GL_STENCIL_PASS_DEPTH_PASS = @as(c_int, 0x0B96);
pub const GL_STENCIL_REF = @as(c_int, 0x0B97);
pub const GL_STENCIL_WRITEMASK = @as(c_int, 0x0B98);
pub const GL_VIEWPORT = @as(c_int, 0x0BA2);
pub const GL_DITHER = @as(c_int, 0x0BD0);
pub const GL_BLEND_DST = @as(c_int, 0x0BE0);
pub const GL_BLEND_SRC = @as(c_int, 0x0BE1);
pub const GL_BLEND = @as(c_int, 0x0BE2);
pub const GL_LOGIC_OP_MODE = @as(c_int, 0x0BF0);
pub const GL_DRAW_BUFFER = @as(c_int, 0x0C01);
pub const GL_READ_BUFFER = @as(c_int, 0x0C02);
pub const GL_SCISSOR_BOX = @as(c_int, 0x0C10);
pub const GL_SCISSOR_TEST = @as(c_int, 0x0C11);
pub const GL_COLOR_CLEAR_VALUE = @as(c_int, 0x0C22);
pub const GL_COLOR_WRITEMASK = @as(c_int, 0x0C23);
pub const GL_DOUBLEBUFFER = @as(c_int, 0x0C32);
pub const GL_STEREO = @as(c_int, 0x0C33);
pub const GL_LINE_SMOOTH_HINT = @as(c_int, 0x0C52);
pub const GL_POLYGON_SMOOTH_HINT = @as(c_int, 0x0C53);
pub const GL_UNPACK_SWAP_BYTES = @as(c_int, 0x0CF0);
pub const GL_UNPACK_LSB_FIRST = @as(c_int, 0x0CF1);
pub const GL_UNPACK_ROW_LENGTH = @as(c_int, 0x0CF2);
pub const GL_UNPACK_SKIP_ROWS = @as(c_int, 0x0CF3);
pub const GL_UNPACK_SKIP_PIXELS = @as(c_int, 0x0CF4);
pub const GL_UNPACK_ALIGNMENT = @as(c_int, 0x0CF5);
pub const GL_PACK_SWAP_BYTES = @as(c_int, 0x0D00);
pub const GL_PACK_LSB_FIRST = @as(c_int, 0x0D01);
pub const GL_PACK_ROW_LENGTH = @as(c_int, 0x0D02);
pub const GL_PACK_SKIP_ROWS = @as(c_int, 0x0D03);
pub const GL_PACK_SKIP_PIXELS = @as(c_int, 0x0D04);
pub const GL_PACK_ALIGNMENT = @as(c_int, 0x0D05);
pub const GL_MAX_TEXTURE_SIZE = @as(c_int, 0x0D33);
pub const GL_MAX_VIEWPORT_DIMS = @as(c_int, 0x0D3A);
pub const GL_SUBPIXEL_BITS = @as(c_int, 0x0D50);
pub const GL_TEXTURE_1D = @as(c_int, 0x0DE0);
pub const GL_TEXTURE_2D = @as(c_int, 0x0DE1);
pub const GL_TEXTURE_WIDTH = @as(c_int, 0x1000);
pub const GL_TEXTURE_HEIGHT = @as(c_int, 0x1001);
pub const GL_TEXTURE_BORDER_COLOR = @as(c_int, 0x1004);
pub const GL_DONT_CARE = @as(c_int, 0x1100);
pub const GL_FASTEST = @as(c_int, 0x1101);
pub const GL_NICEST = @as(c_int, 0x1102);
pub const GL_BYTE = @as(c_int, 0x1400);
pub const GL_UNSIGNED_BYTE = @as(c_int, 0x1401);
pub const GL_SHORT = @as(c_int, 0x1402);
pub const GL_UNSIGNED_SHORT = @as(c_int, 0x1403);
pub const GL_INT = @as(c_int, 0x1404);
pub const GL_UNSIGNED_INT = @as(c_int, 0x1405);
pub const GL_FLOAT = @as(c_int, 0x1406);
pub const GL_CLEAR = @as(c_int, 0x1500);
pub const GL_AND = @as(c_int, 0x1501);
pub const GL_AND_REVERSE = @as(c_int, 0x1502);
pub const GL_COPY = @as(c_int, 0x1503);
pub const GL_AND_INVERTED = @as(c_int, 0x1504);
pub const GL_NOOP = @as(c_int, 0x1505);
pub const GL_XOR = @as(c_int, 0x1506);
pub const GL_OR = @as(c_int, 0x1507);
pub const GL_NOR = @as(c_int, 0x1508);
pub const GL_EQUIV = @as(c_int, 0x1509);
pub const GL_INVERT = @as(c_int, 0x150A);
pub const GL_OR_REVERSE = @as(c_int, 0x150B);
pub const GL_COPY_INVERTED = @as(c_int, 0x150C);
pub const GL_OR_INVERTED = @as(c_int, 0x150D);
pub const GL_NAND = @as(c_int, 0x150E);
pub const GL_SET = @as(c_int, 0x150F);
pub const GL_TEXTURE = @as(c_int, 0x1702);
pub const GL_COLOR = @as(c_int, 0x1800);
pub const GL_DEPTH = @as(c_int, 0x1801);
pub const GL_STENCIL = @as(c_int, 0x1802);
pub const GL_STENCIL_INDEX = @as(c_int, 0x1901);
pub const GL_DEPTH_COMPONENT = @as(c_int, 0x1902);
pub const GL_RED = @as(c_int, 0x1903);
pub const GL_GREEN = @as(c_int, 0x1904);
pub const GL_BLUE = @as(c_int, 0x1905);
pub const GL_ALPHA = @as(c_int, 0x1906);
pub const GL_RGB = @as(c_int, 0x1907);
pub const GL_RGBA = @as(c_int, 0x1908);
pub const GL_POINT = @as(c_int, 0x1B00);
pub const GL_LINE = @as(c_int, 0x1B01);
pub const GL_FILL = @as(c_int, 0x1B02);
pub const GL_KEEP = @as(c_int, 0x1E00);
pub const GL_REPLACE = @as(c_int, 0x1E01);
pub const GL_INCR = @as(c_int, 0x1E02);
pub const GL_DECR = @as(c_int, 0x1E03);
pub const GL_VENDOR = @as(c_int, 0x1F00);
pub const GL_RENDERER = @as(c_int, 0x1F01);
pub const GL_VERSION = @as(c_int, 0x1F02);
pub const GL_EXTENSIONS = @as(c_int, 0x1F03);
pub const GL_NEAREST = @as(c_int, 0x2600);
pub const GL_LINEAR = @as(c_int, 0x2601);
pub const GL_NEAREST_MIPMAP_NEAREST = @as(c_int, 0x2700);
pub const GL_LINEAR_MIPMAP_NEAREST = @as(c_int, 0x2701);
pub const GL_NEAREST_MIPMAP_LINEAR = @as(c_int, 0x2702);
pub const GL_LINEAR_MIPMAP_LINEAR = @as(c_int, 0x2703);
pub const GL_TEXTURE_MAG_FILTER = @as(c_int, 0x2800);
pub const GL_TEXTURE_MIN_FILTER = @as(c_int, 0x2801);
pub const GL_TEXTURE_WRAP_S = @as(c_int, 0x2802);
pub const GL_TEXTURE_WRAP_T = @as(c_int, 0x2803);
pub const GL_REPEAT = @as(c_int, 0x2901);
pub const GL_COLOR_LOGIC_OP = @as(c_int, 0x0BF2);
pub const GL_POLYGON_OFFSET_UNITS = @as(c_int, 0x2A00);
pub const GL_POLYGON_OFFSET_POINT = @as(c_int, 0x2A01);
pub const GL_POLYGON_OFFSET_LINE = @as(c_int, 0x2A02);
pub const GL_POLYGON_OFFSET_FILL = __helpers.promoteIntLiteral(c_int, 0x8037, .hex);
pub const GL_POLYGON_OFFSET_FACTOR = __helpers.promoteIntLiteral(c_int, 0x8038, .hex);
pub const GL_TEXTURE_BINDING_1D = __helpers.promoteIntLiteral(c_int, 0x8068, .hex);
pub const GL_TEXTURE_BINDING_2D = __helpers.promoteIntLiteral(c_int, 0x8069, .hex);
pub const GL_TEXTURE_INTERNAL_FORMAT = @as(c_int, 0x1003);
pub const GL_TEXTURE_RED_SIZE = __helpers.promoteIntLiteral(c_int, 0x805C, .hex);
pub const GL_TEXTURE_GREEN_SIZE = __helpers.promoteIntLiteral(c_int, 0x805D, .hex);
pub const GL_TEXTURE_BLUE_SIZE = __helpers.promoteIntLiteral(c_int, 0x805E, .hex);
pub const GL_TEXTURE_ALPHA_SIZE = __helpers.promoteIntLiteral(c_int, 0x805F, .hex);
pub const GL_DOUBLE = @as(c_int, 0x140A);
pub const GL_PROXY_TEXTURE_1D = __helpers.promoteIntLiteral(c_int, 0x8063, .hex);
pub const GL_PROXY_TEXTURE_2D = __helpers.promoteIntLiteral(c_int, 0x8064, .hex);
pub const GL_R3_G3_B2 = @as(c_int, 0x2A10);
pub const GL_RGB4 = __helpers.promoteIntLiteral(c_int, 0x804F, .hex);
pub const GL_RGB5 = __helpers.promoteIntLiteral(c_int, 0x8050, .hex);
pub const GL_RGB8 = __helpers.promoteIntLiteral(c_int, 0x8051, .hex);
pub const GL_RGB10 = __helpers.promoteIntLiteral(c_int, 0x8052, .hex);
pub const GL_RGB12 = __helpers.promoteIntLiteral(c_int, 0x8053, .hex);
pub const GL_RGB16 = __helpers.promoteIntLiteral(c_int, 0x8054, .hex);
pub const GL_RGBA2 = __helpers.promoteIntLiteral(c_int, 0x8055, .hex);
pub const GL_RGBA4 = __helpers.promoteIntLiteral(c_int, 0x8056, .hex);
pub const GL_RGB5_A1 = __helpers.promoteIntLiteral(c_int, 0x8057, .hex);
pub const GL_RGBA8 = __helpers.promoteIntLiteral(c_int, 0x8058, .hex);
pub const GL_RGB10_A2 = __helpers.promoteIntLiteral(c_int, 0x8059, .hex);
pub const GL_RGBA12 = __helpers.promoteIntLiteral(c_int, 0x805A, .hex);
pub const GL_RGBA16 = __helpers.promoteIntLiteral(c_int, 0x805B, .hex);
pub const GL_UNSIGNED_BYTE_3_3_2 = __helpers.promoteIntLiteral(c_int, 0x8032, .hex);
pub const GL_UNSIGNED_SHORT_4_4_4_4 = __helpers.promoteIntLiteral(c_int, 0x8033, .hex);
pub const GL_UNSIGNED_SHORT_5_5_5_1 = __helpers.promoteIntLiteral(c_int, 0x8034, .hex);
pub const GL_UNSIGNED_INT_8_8_8_8 = __helpers.promoteIntLiteral(c_int, 0x8035, .hex);
pub const GL_UNSIGNED_INT_10_10_10_2 = __helpers.promoteIntLiteral(c_int, 0x8036, .hex);
pub const GL_TEXTURE_BINDING_3D = __helpers.promoteIntLiteral(c_int, 0x806A, .hex);
pub const GL_PACK_SKIP_IMAGES = __helpers.promoteIntLiteral(c_int, 0x806B, .hex);
pub const GL_PACK_IMAGE_HEIGHT = __helpers.promoteIntLiteral(c_int, 0x806C, .hex);
pub const GL_UNPACK_SKIP_IMAGES = __helpers.promoteIntLiteral(c_int, 0x806D, .hex);
pub const GL_UNPACK_IMAGE_HEIGHT = __helpers.promoteIntLiteral(c_int, 0x806E, .hex);
pub const GL_TEXTURE_3D = __helpers.promoteIntLiteral(c_int, 0x806F, .hex);
pub const GL_PROXY_TEXTURE_3D = __helpers.promoteIntLiteral(c_int, 0x8070, .hex);
pub const GL_TEXTURE_DEPTH = __helpers.promoteIntLiteral(c_int, 0x8071, .hex);
pub const GL_TEXTURE_WRAP_R = __helpers.promoteIntLiteral(c_int, 0x8072, .hex);
pub const GL_MAX_3D_TEXTURE_SIZE = __helpers.promoteIntLiteral(c_int, 0x8073, .hex);
pub const GL_UNSIGNED_BYTE_2_3_3_REV = __helpers.promoteIntLiteral(c_int, 0x8362, .hex);
pub const GL_UNSIGNED_SHORT_5_6_5 = __helpers.promoteIntLiteral(c_int, 0x8363, .hex);
pub const GL_UNSIGNED_SHORT_5_6_5_REV = __helpers.promoteIntLiteral(c_int, 0x8364, .hex);
pub const GL_UNSIGNED_SHORT_4_4_4_4_REV = __helpers.promoteIntLiteral(c_int, 0x8365, .hex);
pub const GL_UNSIGNED_SHORT_1_5_5_5_REV = __helpers.promoteIntLiteral(c_int, 0x8366, .hex);
pub const GL_UNSIGNED_INT_8_8_8_8_REV = __helpers.promoteIntLiteral(c_int, 0x8367, .hex);
pub const GL_UNSIGNED_INT_2_10_10_10_REV = __helpers.promoteIntLiteral(c_int, 0x8368, .hex);
pub const GL_BGR = __helpers.promoteIntLiteral(c_int, 0x80E0, .hex);
pub const GL_BGRA = __helpers.promoteIntLiteral(c_int, 0x80E1, .hex);
pub const GL_MAX_ELEMENTS_VERTICES = __helpers.promoteIntLiteral(c_int, 0x80E8, .hex);
pub const GL_MAX_ELEMENTS_INDICES = __helpers.promoteIntLiteral(c_int, 0x80E9, .hex);
pub const GL_CLAMP_TO_EDGE = __helpers.promoteIntLiteral(c_int, 0x812F, .hex);
pub const GL_TEXTURE_MIN_LOD = __helpers.promoteIntLiteral(c_int, 0x813A, .hex);
pub const GL_TEXTURE_MAX_LOD = __helpers.promoteIntLiteral(c_int, 0x813B, .hex);
pub const GL_TEXTURE_BASE_LEVEL = __helpers.promoteIntLiteral(c_int, 0x813C, .hex);
pub const GL_TEXTURE_MAX_LEVEL = __helpers.promoteIntLiteral(c_int, 0x813D, .hex);
pub const GL_SMOOTH_POINT_SIZE_RANGE = @as(c_int, 0x0B12);
pub const GL_SMOOTH_POINT_SIZE_GRANULARITY = @as(c_int, 0x0B13);
pub const GL_SMOOTH_LINE_WIDTH_RANGE = @as(c_int, 0x0B22);
pub const GL_SMOOTH_LINE_WIDTH_GRANULARITY = @as(c_int, 0x0B23);
pub const GL_ALIASED_LINE_WIDTH_RANGE = __helpers.promoteIntLiteral(c_int, 0x846E, .hex);
pub const GL_TEXTURE0 = __helpers.promoteIntLiteral(c_int, 0x84C0, .hex);
pub const GL_TEXTURE1 = __helpers.promoteIntLiteral(c_int, 0x84C1, .hex);
pub const GL_TEXTURE2 = __helpers.promoteIntLiteral(c_int, 0x84C2, .hex);
pub const GL_TEXTURE3 = __helpers.promoteIntLiteral(c_int, 0x84C3, .hex);
pub const GL_TEXTURE4 = __helpers.promoteIntLiteral(c_int, 0x84C4, .hex);
pub const GL_TEXTURE5 = __helpers.promoteIntLiteral(c_int, 0x84C5, .hex);
pub const GL_TEXTURE6 = __helpers.promoteIntLiteral(c_int, 0x84C6, .hex);
pub const GL_TEXTURE7 = __helpers.promoteIntLiteral(c_int, 0x84C7, .hex);
pub const GL_TEXTURE8 = __helpers.promoteIntLiteral(c_int, 0x84C8, .hex);
pub const GL_TEXTURE9 = __helpers.promoteIntLiteral(c_int, 0x84C9, .hex);
pub const GL_TEXTURE10 = __helpers.promoteIntLiteral(c_int, 0x84CA, .hex);
pub const GL_TEXTURE11 = __helpers.promoteIntLiteral(c_int, 0x84CB, .hex);
pub const GL_TEXTURE12 = __helpers.promoteIntLiteral(c_int, 0x84CC, .hex);
pub const GL_TEXTURE13 = __helpers.promoteIntLiteral(c_int, 0x84CD, .hex);
pub const GL_TEXTURE14 = __helpers.promoteIntLiteral(c_int, 0x84CE, .hex);
pub const GL_TEXTURE15 = __helpers.promoteIntLiteral(c_int, 0x84CF, .hex);
pub const GL_TEXTURE16 = __helpers.promoteIntLiteral(c_int, 0x84D0, .hex);
pub const GL_TEXTURE17 = __helpers.promoteIntLiteral(c_int, 0x84D1, .hex);
pub const GL_TEXTURE18 = __helpers.promoteIntLiteral(c_int, 0x84D2, .hex);
pub const GL_TEXTURE19 = __helpers.promoteIntLiteral(c_int, 0x84D3, .hex);
pub const GL_TEXTURE20 = __helpers.promoteIntLiteral(c_int, 0x84D4, .hex);
pub const GL_TEXTURE21 = __helpers.promoteIntLiteral(c_int, 0x84D5, .hex);
pub const GL_TEXTURE22 = __helpers.promoteIntLiteral(c_int, 0x84D6, .hex);
pub const GL_TEXTURE23 = __helpers.promoteIntLiteral(c_int, 0x84D7, .hex);
pub const GL_TEXTURE24 = __helpers.promoteIntLiteral(c_int, 0x84D8, .hex);
pub const GL_TEXTURE25 = __helpers.promoteIntLiteral(c_int, 0x84D9, .hex);
pub const GL_TEXTURE26 = __helpers.promoteIntLiteral(c_int, 0x84DA, .hex);
pub const GL_TEXTURE27 = __helpers.promoteIntLiteral(c_int, 0x84DB, .hex);
pub const GL_TEXTURE28 = __helpers.promoteIntLiteral(c_int, 0x84DC, .hex);
pub const GL_TEXTURE29 = __helpers.promoteIntLiteral(c_int, 0x84DD, .hex);
pub const GL_TEXTURE30 = __helpers.promoteIntLiteral(c_int, 0x84DE, .hex);
pub const GL_TEXTURE31 = __helpers.promoteIntLiteral(c_int, 0x84DF, .hex);
pub const GL_ACTIVE_TEXTURE = __helpers.promoteIntLiteral(c_int, 0x84E0, .hex);
pub const GL_MULTISAMPLE = __helpers.promoteIntLiteral(c_int, 0x809D, .hex);
pub const GL_SAMPLE_ALPHA_TO_COVERAGE = __helpers.promoteIntLiteral(c_int, 0x809E, .hex);
pub const GL_SAMPLE_ALPHA_TO_ONE = __helpers.promoteIntLiteral(c_int, 0x809F, .hex);
pub const GL_SAMPLE_COVERAGE = __helpers.promoteIntLiteral(c_int, 0x80A0, .hex);
pub const GL_SAMPLE_BUFFERS = __helpers.promoteIntLiteral(c_int, 0x80A8, .hex);
pub const GL_SAMPLES = __helpers.promoteIntLiteral(c_int, 0x80A9, .hex);
pub const GL_SAMPLE_COVERAGE_VALUE = __helpers.promoteIntLiteral(c_int, 0x80AA, .hex);
pub const GL_SAMPLE_COVERAGE_INVERT = __helpers.promoteIntLiteral(c_int, 0x80AB, .hex);
pub const GL_TEXTURE_CUBE_MAP = __helpers.promoteIntLiteral(c_int, 0x8513, .hex);
pub const GL_TEXTURE_BINDING_CUBE_MAP = __helpers.promoteIntLiteral(c_int, 0x8514, .hex);
pub const GL_TEXTURE_CUBE_MAP_POSITIVE_X = __helpers.promoteIntLiteral(c_int, 0x8515, .hex);
pub const GL_TEXTURE_CUBE_MAP_NEGATIVE_X = __helpers.promoteIntLiteral(c_int, 0x8516, .hex);
pub const GL_TEXTURE_CUBE_MAP_POSITIVE_Y = __helpers.promoteIntLiteral(c_int, 0x8517, .hex);
pub const GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = __helpers.promoteIntLiteral(c_int, 0x8518, .hex);
pub const GL_TEXTURE_CUBE_MAP_POSITIVE_Z = __helpers.promoteIntLiteral(c_int, 0x8519, .hex);
pub const GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = __helpers.promoteIntLiteral(c_int, 0x851A, .hex);
pub const GL_PROXY_TEXTURE_CUBE_MAP = __helpers.promoteIntLiteral(c_int, 0x851B, .hex);
pub const GL_MAX_CUBE_MAP_TEXTURE_SIZE = __helpers.promoteIntLiteral(c_int, 0x851C, .hex);
pub const GL_COMPRESSED_RGB = __helpers.promoteIntLiteral(c_int, 0x84ED, .hex);
pub const GL_COMPRESSED_RGBA = __helpers.promoteIntLiteral(c_int, 0x84EE, .hex);
pub const GL_TEXTURE_COMPRESSION_HINT = __helpers.promoteIntLiteral(c_int, 0x84EF, .hex);
pub const GL_TEXTURE_COMPRESSED_IMAGE_SIZE = __helpers.promoteIntLiteral(c_int, 0x86A0, .hex);
pub const GL_TEXTURE_COMPRESSED = __helpers.promoteIntLiteral(c_int, 0x86A1, .hex);
pub const GL_NUM_COMPRESSED_TEXTURE_FORMATS = __helpers.promoteIntLiteral(c_int, 0x86A2, .hex);
pub const GL_COMPRESSED_TEXTURE_FORMATS = __helpers.promoteIntLiteral(c_int, 0x86A3, .hex);
pub const GL_CLAMP_TO_BORDER = __helpers.promoteIntLiteral(c_int, 0x812D, .hex);
pub const GL_BLEND_DST_RGB = __helpers.promoteIntLiteral(c_int, 0x80C8, .hex);
pub const GL_BLEND_SRC_RGB = __helpers.promoteIntLiteral(c_int, 0x80C9, .hex);
pub const GL_BLEND_DST_ALPHA = __helpers.promoteIntLiteral(c_int, 0x80CA, .hex);
pub const GL_BLEND_SRC_ALPHA = __helpers.promoteIntLiteral(c_int, 0x80CB, .hex);
pub const GL_POINT_FADE_THRESHOLD_SIZE = __helpers.promoteIntLiteral(c_int, 0x8128, .hex);
pub const GL_DEPTH_COMPONENT16 = __helpers.promoteIntLiteral(c_int, 0x81A5, .hex);
pub const GL_DEPTH_COMPONENT24 = __helpers.promoteIntLiteral(c_int, 0x81A6, .hex);
pub const GL_DEPTH_COMPONENT32 = __helpers.promoteIntLiteral(c_int, 0x81A7, .hex);
pub const GL_MIRRORED_REPEAT = __helpers.promoteIntLiteral(c_int, 0x8370, .hex);
pub const GL_MAX_TEXTURE_LOD_BIAS = __helpers.promoteIntLiteral(c_int, 0x84FD, .hex);
pub const GL_TEXTURE_LOD_BIAS = __helpers.promoteIntLiteral(c_int, 0x8501, .hex);
pub const GL_INCR_WRAP = __helpers.promoteIntLiteral(c_int, 0x8507, .hex);
pub const GL_DECR_WRAP = __helpers.promoteIntLiteral(c_int, 0x8508, .hex);
pub const GL_TEXTURE_DEPTH_SIZE = __helpers.promoteIntLiteral(c_int, 0x884A, .hex);
pub const GL_TEXTURE_COMPARE_MODE = __helpers.promoteIntLiteral(c_int, 0x884C, .hex);
pub const GL_TEXTURE_COMPARE_FUNC = __helpers.promoteIntLiteral(c_int, 0x884D, .hex);
pub const GL_BLEND_COLOR = __helpers.promoteIntLiteral(c_int, 0x8005, .hex);
pub const GL_BLEND_EQUATION = __helpers.promoteIntLiteral(c_int, 0x8009, .hex);
pub const GL_CONSTANT_COLOR = __helpers.promoteIntLiteral(c_int, 0x8001, .hex);
pub const GL_ONE_MINUS_CONSTANT_COLOR = __helpers.promoteIntLiteral(c_int, 0x8002, .hex);
pub const GL_CONSTANT_ALPHA = __helpers.promoteIntLiteral(c_int, 0x8003, .hex);
pub const GL_ONE_MINUS_CONSTANT_ALPHA = __helpers.promoteIntLiteral(c_int, 0x8004, .hex);
pub const GL_FUNC_ADD = __helpers.promoteIntLiteral(c_int, 0x8006, .hex);
pub const GL_FUNC_REVERSE_SUBTRACT = __helpers.promoteIntLiteral(c_int, 0x800B, .hex);
pub const GL_FUNC_SUBTRACT = __helpers.promoteIntLiteral(c_int, 0x800A, .hex);
pub const GL_MIN = __helpers.promoteIntLiteral(c_int, 0x8007, .hex);
pub const GL_MAX = __helpers.promoteIntLiteral(c_int, 0x8008, .hex);
pub const GL_BUFFER_SIZE = __helpers.promoteIntLiteral(c_int, 0x8764, .hex);
pub const GL_BUFFER_USAGE = __helpers.promoteIntLiteral(c_int, 0x8765, .hex);
pub const GL_QUERY_COUNTER_BITS = __helpers.promoteIntLiteral(c_int, 0x8864, .hex);
pub const GL_CURRENT_QUERY = __helpers.promoteIntLiteral(c_int, 0x8865, .hex);
pub const GL_QUERY_RESULT = __helpers.promoteIntLiteral(c_int, 0x8866, .hex);
pub const GL_QUERY_RESULT_AVAILABLE = __helpers.promoteIntLiteral(c_int, 0x8867, .hex);
pub const GL_ARRAY_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8892, .hex);
pub const GL_ELEMENT_ARRAY_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8893, .hex);
pub const GL_ARRAY_BUFFER_BINDING = __helpers.promoteIntLiteral(c_int, 0x8894, .hex);
pub const GL_ELEMENT_ARRAY_BUFFER_BINDING = __helpers.promoteIntLiteral(c_int, 0x8895, .hex);
pub const GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = __helpers.promoteIntLiteral(c_int, 0x889F, .hex);
pub const GL_READ_ONLY = __helpers.promoteIntLiteral(c_int, 0x88B8, .hex);
pub const GL_WRITE_ONLY = __helpers.promoteIntLiteral(c_int, 0x88B9, .hex);
pub const GL_READ_WRITE = __helpers.promoteIntLiteral(c_int, 0x88BA, .hex);
pub const GL_BUFFER_ACCESS = __helpers.promoteIntLiteral(c_int, 0x88BB, .hex);
pub const GL_BUFFER_MAPPED = __helpers.promoteIntLiteral(c_int, 0x88BC, .hex);
pub const GL_BUFFER_MAP_POINTER = __helpers.promoteIntLiteral(c_int, 0x88BD, .hex);
pub const GL_STREAM_DRAW = __helpers.promoteIntLiteral(c_int, 0x88E0, .hex);
pub const GL_STREAM_READ = __helpers.promoteIntLiteral(c_int, 0x88E1, .hex);
pub const GL_STREAM_COPY = __helpers.promoteIntLiteral(c_int, 0x88E2, .hex);
pub const GL_STATIC_DRAW = __helpers.promoteIntLiteral(c_int, 0x88E4, .hex);
pub const GL_STATIC_READ = __helpers.promoteIntLiteral(c_int, 0x88E5, .hex);
pub const GL_STATIC_COPY = __helpers.promoteIntLiteral(c_int, 0x88E6, .hex);
pub const GL_DYNAMIC_DRAW = __helpers.promoteIntLiteral(c_int, 0x88E8, .hex);
pub const GL_DYNAMIC_READ = __helpers.promoteIntLiteral(c_int, 0x88E9, .hex);
pub const GL_DYNAMIC_COPY = __helpers.promoteIntLiteral(c_int, 0x88EA, .hex);
pub const GL_SAMPLES_PASSED = __helpers.promoteIntLiteral(c_int, 0x8914, .hex);
pub const GL_SRC1_ALPHA = __helpers.promoteIntLiteral(c_int, 0x8589, .hex);
pub const GL_BLEND_EQUATION_RGB = __helpers.promoteIntLiteral(c_int, 0x8009, .hex);
pub const GL_VERTEX_ATTRIB_ARRAY_ENABLED = __helpers.promoteIntLiteral(c_int, 0x8622, .hex);
pub const GL_VERTEX_ATTRIB_ARRAY_SIZE = __helpers.promoteIntLiteral(c_int, 0x8623, .hex);
pub const GL_VERTEX_ATTRIB_ARRAY_STRIDE = __helpers.promoteIntLiteral(c_int, 0x8624, .hex);
pub const GL_VERTEX_ATTRIB_ARRAY_TYPE = __helpers.promoteIntLiteral(c_int, 0x8625, .hex);
pub const GL_CURRENT_VERTEX_ATTRIB = __helpers.promoteIntLiteral(c_int, 0x8626, .hex);
pub const GL_VERTEX_PROGRAM_POINT_SIZE = __helpers.promoteIntLiteral(c_int, 0x8642, .hex);
pub const GL_VERTEX_ATTRIB_ARRAY_POINTER = __helpers.promoteIntLiteral(c_int, 0x8645, .hex);
pub const GL_STENCIL_BACK_FUNC = __helpers.promoteIntLiteral(c_int, 0x8800, .hex);
pub const GL_STENCIL_BACK_FAIL = __helpers.promoteIntLiteral(c_int, 0x8801, .hex);
pub const GL_STENCIL_BACK_PASS_DEPTH_FAIL = __helpers.promoteIntLiteral(c_int, 0x8802, .hex);
pub const GL_STENCIL_BACK_PASS_DEPTH_PASS = __helpers.promoteIntLiteral(c_int, 0x8803, .hex);
pub const GL_MAX_DRAW_BUFFERS = __helpers.promoteIntLiteral(c_int, 0x8824, .hex);
pub const GL_DRAW_BUFFER0 = __helpers.promoteIntLiteral(c_int, 0x8825, .hex);
pub const GL_DRAW_BUFFER1 = __helpers.promoteIntLiteral(c_int, 0x8826, .hex);
pub const GL_DRAW_BUFFER2 = __helpers.promoteIntLiteral(c_int, 0x8827, .hex);
pub const GL_DRAW_BUFFER3 = __helpers.promoteIntLiteral(c_int, 0x8828, .hex);
pub const GL_DRAW_BUFFER4 = __helpers.promoteIntLiteral(c_int, 0x8829, .hex);
pub const GL_DRAW_BUFFER5 = __helpers.promoteIntLiteral(c_int, 0x882A, .hex);
pub const GL_DRAW_BUFFER6 = __helpers.promoteIntLiteral(c_int, 0x882B, .hex);
pub const GL_DRAW_BUFFER7 = __helpers.promoteIntLiteral(c_int, 0x882C, .hex);
pub const GL_DRAW_BUFFER8 = __helpers.promoteIntLiteral(c_int, 0x882D, .hex);
pub const GL_DRAW_BUFFER9 = __helpers.promoteIntLiteral(c_int, 0x882E, .hex);
pub const GL_DRAW_BUFFER10 = __helpers.promoteIntLiteral(c_int, 0x882F, .hex);
pub const GL_DRAW_BUFFER11 = __helpers.promoteIntLiteral(c_int, 0x8830, .hex);
pub const GL_DRAW_BUFFER12 = __helpers.promoteIntLiteral(c_int, 0x8831, .hex);
pub const GL_DRAW_BUFFER13 = __helpers.promoteIntLiteral(c_int, 0x8832, .hex);
pub const GL_DRAW_BUFFER14 = __helpers.promoteIntLiteral(c_int, 0x8833, .hex);
pub const GL_DRAW_BUFFER15 = __helpers.promoteIntLiteral(c_int, 0x8834, .hex);
pub const GL_BLEND_EQUATION_ALPHA = __helpers.promoteIntLiteral(c_int, 0x883D, .hex);
pub const GL_MAX_VERTEX_ATTRIBS = __helpers.promoteIntLiteral(c_int, 0x8869, .hex);
pub const GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = __helpers.promoteIntLiteral(c_int, 0x886A, .hex);
pub const GL_MAX_TEXTURE_IMAGE_UNITS = __helpers.promoteIntLiteral(c_int, 0x8872, .hex);
pub const GL_FRAGMENT_SHADER = __helpers.promoteIntLiteral(c_int, 0x8B30, .hex);
pub const GL_VERTEX_SHADER = __helpers.promoteIntLiteral(c_int, 0x8B31, .hex);
pub const GL_MAX_FRAGMENT_UNIFORM_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x8B49, .hex);
pub const GL_MAX_VERTEX_UNIFORM_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x8B4A, .hex);
pub const GL_MAX_VARYING_FLOATS = __helpers.promoteIntLiteral(c_int, 0x8B4B, .hex);
pub const GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = __helpers.promoteIntLiteral(c_int, 0x8B4C, .hex);
pub const GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = __helpers.promoteIntLiteral(c_int, 0x8B4D, .hex);
pub const GL_SHADER_TYPE = __helpers.promoteIntLiteral(c_int, 0x8B4F, .hex);
pub const GL_FLOAT_VEC2 = __helpers.promoteIntLiteral(c_int, 0x8B50, .hex);
pub const GL_FLOAT_VEC3 = __helpers.promoteIntLiteral(c_int, 0x8B51, .hex);
pub const GL_FLOAT_VEC4 = __helpers.promoteIntLiteral(c_int, 0x8B52, .hex);
pub const GL_INT_VEC2 = __helpers.promoteIntLiteral(c_int, 0x8B53, .hex);
pub const GL_INT_VEC3 = __helpers.promoteIntLiteral(c_int, 0x8B54, .hex);
pub const GL_INT_VEC4 = __helpers.promoteIntLiteral(c_int, 0x8B55, .hex);
pub const GL_BOOL = __helpers.promoteIntLiteral(c_int, 0x8B56, .hex);
pub const GL_BOOL_VEC2 = __helpers.promoteIntLiteral(c_int, 0x8B57, .hex);
pub const GL_BOOL_VEC3 = __helpers.promoteIntLiteral(c_int, 0x8B58, .hex);
pub const GL_BOOL_VEC4 = __helpers.promoteIntLiteral(c_int, 0x8B59, .hex);
pub const GL_FLOAT_MAT2 = __helpers.promoteIntLiteral(c_int, 0x8B5A, .hex);
pub const GL_FLOAT_MAT3 = __helpers.promoteIntLiteral(c_int, 0x8B5B, .hex);
pub const GL_FLOAT_MAT4 = __helpers.promoteIntLiteral(c_int, 0x8B5C, .hex);
pub const GL_SAMPLER_1D = __helpers.promoteIntLiteral(c_int, 0x8B5D, .hex);
pub const GL_SAMPLER_2D = __helpers.promoteIntLiteral(c_int, 0x8B5E, .hex);
pub const GL_SAMPLER_3D = __helpers.promoteIntLiteral(c_int, 0x8B5F, .hex);
pub const GL_SAMPLER_CUBE = __helpers.promoteIntLiteral(c_int, 0x8B60, .hex);
pub const GL_SAMPLER_1D_SHADOW = __helpers.promoteIntLiteral(c_int, 0x8B61, .hex);
pub const GL_SAMPLER_2D_SHADOW = __helpers.promoteIntLiteral(c_int, 0x8B62, .hex);
pub const GL_DELETE_STATUS = __helpers.promoteIntLiteral(c_int, 0x8B80, .hex);
pub const GL_COMPILE_STATUS = __helpers.promoteIntLiteral(c_int, 0x8B81, .hex);
pub const GL_LINK_STATUS = __helpers.promoteIntLiteral(c_int, 0x8B82, .hex);
pub const GL_VALIDATE_STATUS = __helpers.promoteIntLiteral(c_int, 0x8B83, .hex);
pub const GL_INFO_LOG_LENGTH = __helpers.promoteIntLiteral(c_int, 0x8B84, .hex);
pub const GL_ATTACHED_SHADERS = __helpers.promoteIntLiteral(c_int, 0x8B85, .hex);
pub const GL_ACTIVE_UNIFORMS = __helpers.promoteIntLiteral(c_int, 0x8B86, .hex);
pub const GL_ACTIVE_UNIFORM_MAX_LENGTH = __helpers.promoteIntLiteral(c_int, 0x8B87, .hex);
pub const GL_SHADER_SOURCE_LENGTH = __helpers.promoteIntLiteral(c_int, 0x8B88, .hex);
pub const GL_ACTIVE_ATTRIBUTES = __helpers.promoteIntLiteral(c_int, 0x8B89, .hex);
pub const GL_ACTIVE_ATTRIBUTE_MAX_LENGTH = __helpers.promoteIntLiteral(c_int, 0x8B8A, .hex);
pub const GL_FRAGMENT_SHADER_DERIVATIVE_HINT = __helpers.promoteIntLiteral(c_int, 0x8B8B, .hex);
pub const GL_SHADING_LANGUAGE_VERSION = __helpers.promoteIntLiteral(c_int, 0x8B8C, .hex);
pub const GL_CURRENT_PROGRAM = __helpers.promoteIntLiteral(c_int, 0x8B8D, .hex);
pub const GL_POINT_SPRITE_COORD_ORIGIN = __helpers.promoteIntLiteral(c_int, 0x8CA0, .hex);
pub const GL_LOWER_LEFT = __helpers.promoteIntLiteral(c_int, 0x8CA1, .hex);
pub const GL_UPPER_LEFT = __helpers.promoteIntLiteral(c_int, 0x8CA2, .hex);
pub const GL_STENCIL_BACK_REF = __helpers.promoteIntLiteral(c_int, 0x8CA3, .hex);
pub const GL_STENCIL_BACK_VALUE_MASK = __helpers.promoteIntLiteral(c_int, 0x8CA4, .hex);
pub const GL_STENCIL_BACK_WRITEMASK = __helpers.promoteIntLiteral(c_int, 0x8CA5, .hex);
pub const GL_PIXEL_PACK_BUFFER = __helpers.promoteIntLiteral(c_int, 0x88EB, .hex);
pub const GL_PIXEL_UNPACK_BUFFER = __helpers.promoteIntLiteral(c_int, 0x88EC, .hex);
pub const GL_PIXEL_PACK_BUFFER_BINDING = __helpers.promoteIntLiteral(c_int, 0x88ED, .hex);
pub const GL_PIXEL_UNPACK_BUFFER_BINDING = __helpers.promoteIntLiteral(c_int, 0x88EF, .hex);
pub const GL_FLOAT_MAT2x3 = __helpers.promoteIntLiteral(c_int, 0x8B65, .hex);
pub const GL_FLOAT_MAT2x4 = __helpers.promoteIntLiteral(c_int, 0x8B66, .hex);
pub const GL_FLOAT_MAT3x2 = __helpers.promoteIntLiteral(c_int, 0x8B67, .hex);
pub const GL_FLOAT_MAT3x4 = __helpers.promoteIntLiteral(c_int, 0x8B68, .hex);
pub const GL_FLOAT_MAT4x2 = __helpers.promoteIntLiteral(c_int, 0x8B69, .hex);
pub const GL_FLOAT_MAT4x3 = __helpers.promoteIntLiteral(c_int, 0x8B6A, .hex);
pub const GL_SRGB = __helpers.promoteIntLiteral(c_int, 0x8C40, .hex);
pub const GL_SRGB8 = __helpers.promoteIntLiteral(c_int, 0x8C41, .hex);
pub const GL_SRGB_ALPHA = __helpers.promoteIntLiteral(c_int, 0x8C42, .hex);
pub const GL_SRGB8_ALPHA8 = __helpers.promoteIntLiteral(c_int, 0x8C43, .hex);
pub const GL_COMPRESSED_SRGB = __helpers.promoteIntLiteral(c_int, 0x8C48, .hex);
pub const GL_COMPRESSED_SRGB_ALPHA = __helpers.promoteIntLiteral(c_int, 0x8C49, .hex);
pub const GL_COMPARE_REF_TO_TEXTURE = __helpers.promoteIntLiteral(c_int, 0x884E, .hex);
pub const GL_CLIP_DISTANCE0 = @as(c_int, 0x3000);
pub const GL_CLIP_DISTANCE1 = @as(c_int, 0x3001);
pub const GL_CLIP_DISTANCE2 = @as(c_int, 0x3002);
pub const GL_CLIP_DISTANCE3 = @as(c_int, 0x3003);
pub const GL_CLIP_DISTANCE4 = @as(c_int, 0x3004);
pub const GL_CLIP_DISTANCE5 = @as(c_int, 0x3005);
pub const GL_CLIP_DISTANCE6 = @as(c_int, 0x3006);
pub const GL_CLIP_DISTANCE7 = @as(c_int, 0x3007);
pub const GL_MAX_CLIP_DISTANCES = @as(c_int, 0x0D32);
pub const GL_MAJOR_VERSION = __helpers.promoteIntLiteral(c_int, 0x821B, .hex);
pub const GL_MINOR_VERSION = __helpers.promoteIntLiteral(c_int, 0x821C, .hex);
pub const GL_NUM_EXTENSIONS = __helpers.promoteIntLiteral(c_int, 0x821D, .hex);
pub const GL_CONTEXT_FLAGS = __helpers.promoteIntLiteral(c_int, 0x821E, .hex);
pub const GL_COMPRESSED_RED = __helpers.promoteIntLiteral(c_int, 0x8225, .hex);
pub const GL_COMPRESSED_RG = __helpers.promoteIntLiteral(c_int, 0x8226, .hex);
pub const GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = @as(c_int, 0x00000001);
pub const GL_RGBA32F = __helpers.promoteIntLiteral(c_int, 0x8814, .hex);
pub const GL_RGB32F = __helpers.promoteIntLiteral(c_int, 0x8815, .hex);
pub const GL_RGBA16F = __helpers.promoteIntLiteral(c_int, 0x881A, .hex);
pub const GL_RGB16F = __helpers.promoteIntLiteral(c_int, 0x881B, .hex);
pub const GL_VERTEX_ATTRIB_ARRAY_INTEGER = __helpers.promoteIntLiteral(c_int, 0x88FD, .hex);
pub const GL_MAX_ARRAY_TEXTURE_LAYERS = __helpers.promoteIntLiteral(c_int, 0x88FF, .hex);
pub const GL_MIN_PROGRAM_TEXEL_OFFSET = __helpers.promoteIntLiteral(c_int, 0x8904, .hex);
pub const GL_MAX_PROGRAM_TEXEL_OFFSET = __helpers.promoteIntLiteral(c_int, 0x8905, .hex);
pub const GL_CLAMP_READ_COLOR = __helpers.promoteIntLiteral(c_int, 0x891C, .hex);
pub const GL_FIXED_ONLY = __helpers.promoteIntLiteral(c_int, 0x891D, .hex);
pub const GL_MAX_VARYING_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x8B4B, .hex);
pub const GL_TEXTURE_1D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8C18, .hex);
pub const GL_PROXY_TEXTURE_1D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8C19, .hex);
pub const GL_TEXTURE_2D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8C1A, .hex);
pub const GL_PROXY_TEXTURE_2D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8C1B, .hex);
pub const GL_TEXTURE_BINDING_1D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8C1C, .hex);
pub const GL_TEXTURE_BINDING_2D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8C1D, .hex);
pub const GL_R11F_G11F_B10F = __helpers.promoteIntLiteral(c_int, 0x8C3A, .hex);
pub const GL_UNSIGNED_INT_10F_11F_11F_REV = __helpers.promoteIntLiteral(c_int, 0x8C3B, .hex);
pub const GL_RGB9_E5 = __helpers.promoteIntLiteral(c_int, 0x8C3D, .hex);
pub const GL_UNSIGNED_INT_5_9_9_9_REV = __helpers.promoteIntLiteral(c_int, 0x8C3E, .hex);
pub const GL_TEXTURE_SHARED_SIZE = __helpers.promoteIntLiteral(c_int, 0x8C3F, .hex);
pub const GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = __helpers.promoteIntLiteral(c_int, 0x8C76, .hex);
pub const GL_TRANSFORM_FEEDBACK_BUFFER_MODE = __helpers.promoteIntLiteral(c_int, 0x8C7F, .hex);
pub const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x8C80, .hex);
pub const GL_TRANSFORM_FEEDBACK_VARYINGS = __helpers.promoteIntLiteral(c_int, 0x8C83, .hex);
pub const GL_TRANSFORM_FEEDBACK_BUFFER_START = __helpers.promoteIntLiteral(c_int, 0x8C84, .hex);
pub const GL_TRANSFORM_FEEDBACK_BUFFER_SIZE = __helpers.promoteIntLiteral(c_int, 0x8C85, .hex);
pub const GL_PRIMITIVES_GENERATED = __helpers.promoteIntLiteral(c_int, 0x8C87, .hex);
pub const GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = __helpers.promoteIntLiteral(c_int, 0x8C88, .hex);
pub const GL_RASTERIZER_DISCARD = __helpers.promoteIntLiteral(c_int, 0x8C89, .hex);
pub const GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x8C8A, .hex);
pub const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = __helpers.promoteIntLiteral(c_int, 0x8C8B, .hex);
pub const GL_INTERLEAVED_ATTRIBS = __helpers.promoteIntLiteral(c_int, 0x8C8C, .hex);
pub const GL_SEPARATE_ATTRIBS = __helpers.promoteIntLiteral(c_int, 0x8C8D, .hex);
pub const GL_TRANSFORM_FEEDBACK_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8C8E, .hex);
pub const GL_TRANSFORM_FEEDBACK_BUFFER_BINDING = __helpers.promoteIntLiteral(c_int, 0x8C8F, .hex);
pub const GL_RGBA32UI = __helpers.promoteIntLiteral(c_int, 0x8D70, .hex);
pub const GL_RGB32UI = __helpers.promoteIntLiteral(c_int, 0x8D71, .hex);
pub const GL_RGBA16UI = __helpers.promoteIntLiteral(c_int, 0x8D76, .hex);
pub const GL_RGB16UI = __helpers.promoteIntLiteral(c_int, 0x8D77, .hex);
pub const GL_RGBA8UI = __helpers.promoteIntLiteral(c_int, 0x8D7C, .hex);
pub const GL_RGB8UI = __helpers.promoteIntLiteral(c_int, 0x8D7D, .hex);
pub const GL_RGBA32I = __helpers.promoteIntLiteral(c_int, 0x8D82, .hex);
pub const GL_RGB32I = __helpers.promoteIntLiteral(c_int, 0x8D83, .hex);
pub const GL_RGBA16I = __helpers.promoteIntLiteral(c_int, 0x8D88, .hex);
pub const GL_RGB16I = __helpers.promoteIntLiteral(c_int, 0x8D89, .hex);
pub const GL_RGBA8I = __helpers.promoteIntLiteral(c_int, 0x8D8E, .hex);
pub const GL_RGB8I = __helpers.promoteIntLiteral(c_int, 0x8D8F, .hex);
pub const GL_RED_INTEGER = __helpers.promoteIntLiteral(c_int, 0x8D94, .hex);
pub const GL_GREEN_INTEGER = __helpers.promoteIntLiteral(c_int, 0x8D95, .hex);
pub const GL_BLUE_INTEGER = __helpers.promoteIntLiteral(c_int, 0x8D96, .hex);
pub const GL_RGB_INTEGER = __helpers.promoteIntLiteral(c_int, 0x8D98, .hex);
pub const GL_RGBA_INTEGER = __helpers.promoteIntLiteral(c_int, 0x8D99, .hex);
pub const GL_BGR_INTEGER = __helpers.promoteIntLiteral(c_int, 0x8D9A, .hex);
pub const GL_BGRA_INTEGER = __helpers.promoteIntLiteral(c_int, 0x8D9B, .hex);
pub const GL_SAMPLER_1D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8DC0, .hex);
pub const GL_SAMPLER_2D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8DC1, .hex);
pub const GL_SAMPLER_1D_ARRAY_SHADOW = __helpers.promoteIntLiteral(c_int, 0x8DC3, .hex);
pub const GL_SAMPLER_2D_ARRAY_SHADOW = __helpers.promoteIntLiteral(c_int, 0x8DC4, .hex);
pub const GL_SAMPLER_CUBE_SHADOW = __helpers.promoteIntLiteral(c_int, 0x8DC5, .hex);
pub const GL_UNSIGNED_INT_VEC2 = __helpers.promoteIntLiteral(c_int, 0x8DC6, .hex);
pub const GL_UNSIGNED_INT_VEC3 = __helpers.promoteIntLiteral(c_int, 0x8DC7, .hex);
pub const GL_UNSIGNED_INT_VEC4 = __helpers.promoteIntLiteral(c_int, 0x8DC8, .hex);
pub const GL_INT_SAMPLER_1D = __helpers.promoteIntLiteral(c_int, 0x8DC9, .hex);
pub const GL_INT_SAMPLER_2D = __helpers.promoteIntLiteral(c_int, 0x8DCA, .hex);
pub const GL_INT_SAMPLER_3D = __helpers.promoteIntLiteral(c_int, 0x8DCB, .hex);
pub const GL_INT_SAMPLER_CUBE = __helpers.promoteIntLiteral(c_int, 0x8DCC, .hex);
pub const GL_INT_SAMPLER_1D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8DCE, .hex);
pub const GL_INT_SAMPLER_2D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8DCF, .hex);
pub const GL_UNSIGNED_INT_SAMPLER_1D = __helpers.promoteIntLiteral(c_int, 0x8DD1, .hex);
pub const GL_UNSIGNED_INT_SAMPLER_2D = __helpers.promoteIntLiteral(c_int, 0x8DD2, .hex);
pub const GL_UNSIGNED_INT_SAMPLER_3D = __helpers.promoteIntLiteral(c_int, 0x8DD3, .hex);
pub const GL_UNSIGNED_INT_SAMPLER_CUBE = __helpers.promoteIntLiteral(c_int, 0x8DD4, .hex);
pub const GL_UNSIGNED_INT_SAMPLER_1D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8DD6, .hex);
pub const GL_UNSIGNED_INT_SAMPLER_2D_ARRAY = __helpers.promoteIntLiteral(c_int, 0x8DD7, .hex);
pub const GL_QUERY_WAIT = __helpers.promoteIntLiteral(c_int, 0x8E13, .hex);
pub const GL_QUERY_NO_WAIT = __helpers.promoteIntLiteral(c_int, 0x8E14, .hex);
pub const GL_QUERY_BY_REGION_WAIT = __helpers.promoteIntLiteral(c_int, 0x8E15, .hex);
pub const GL_QUERY_BY_REGION_NO_WAIT = __helpers.promoteIntLiteral(c_int, 0x8E16, .hex);
pub const GL_BUFFER_ACCESS_FLAGS = __helpers.promoteIntLiteral(c_int, 0x911F, .hex);
pub const GL_BUFFER_MAP_LENGTH = __helpers.promoteIntLiteral(c_int, 0x9120, .hex);
pub const GL_BUFFER_MAP_OFFSET = __helpers.promoteIntLiteral(c_int, 0x9121, .hex);
pub const GL_DEPTH_COMPONENT32F = __helpers.promoteIntLiteral(c_int, 0x8CAC, .hex);
pub const GL_DEPTH32F_STENCIL8 = __helpers.promoteIntLiteral(c_int, 0x8CAD, .hex);
pub const GL_FLOAT_32_UNSIGNED_INT_24_8_REV = __helpers.promoteIntLiteral(c_int, 0x8DAD, .hex);
pub const GL_INVALID_FRAMEBUFFER_OPERATION = @as(c_int, 0x0506);
pub const GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = __helpers.promoteIntLiteral(c_int, 0x8210, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = __helpers.promoteIntLiteral(c_int, 0x8211, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE = __helpers.promoteIntLiteral(c_int, 0x8212, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = __helpers.promoteIntLiteral(c_int, 0x8213, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = __helpers.promoteIntLiteral(c_int, 0x8214, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = __helpers.promoteIntLiteral(c_int, 0x8215, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = __helpers.promoteIntLiteral(c_int, 0x8216, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = __helpers.promoteIntLiteral(c_int, 0x8217, .hex);
pub const GL_FRAMEBUFFER_DEFAULT = __helpers.promoteIntLiteral(c_int, 0x8218, .hex);
pub const GL_FRAMEBUFFER_UNDEFINED = __helpers.promoteIntLiteral(c_int, 0x8219, .hex);
pub const GL_DEPTH_STENCIL_ATTACHMENT = __helpers.promoteIntLiteral(c_int, 0x821A, .hex);
pub const GL_MAX_RENDERBUFFER_SIZE = __helpers.promoteIntLiteral(c_int, 0x84E8, .hex);
pub const GL_DEPTH_STENCIL = __helpers.promoteIntLiteral(c_int, 0x84F9, .hex);
pub const GL_UNSIGNED_INT_24_8 = __helpers.promoteIntLiteral(c_int, 0x84FA, .hex);
pub const GL_DEPTH24_STENCIL8 = __helpers.promoteIntLiteral(c_int, 0x88F0, .hex);
pub const GL_TEXTURE_STENCIL_SIZE = __helpers.promoteIntLiteral(c_int, 0x88F1, .hex);
pub const GL_TEXTURE_RED_TYPE = __helpers.promoteIntLiteral(c_int, 0x8C10, .hex);
pub const GL_TEXTURE_GREEN_TYPE = __helpers.promoteIntLiteral(c_int, 0x8C11, .hex);
pub const GL_TEXTURE_BLUE_TYPE = __helpers.promoteIntLiteral(c_int, 0x8C12, .hex);
pub const GL_TEXTURE_ALPHA_TYPE = __helpers.promoteIntLiteral(c_int, 0x8C13, .hex);
pub const GL_TEXTURE_DEPTH_TYPE = __helpers.promoteIntLiteral(c_int, 0x8C16, .hex);
pub const GL_UNSIGNED_NORMALIZED = __helpers.promoteIntLiteral(c_int, 0x8C17, .hex);
pub const GL_FRAMEBUFFER_BINDING = __helpers.promoteIntLiteral(c_int, 0x8CA6, .hex);
pub const GL_DRAW_FRAMEBUFFER_BINDING = __helpers.promoteIntLiteral(c_int, 0x8CA6, .hex);
pub const GL_RENDERBUFFER_BINDING = __helpers.promoteIntLiteral(c_int, 0x8CA7, .hex);
pub const GL_READ_FRAMEBUFFER = __helpers.promoteIntLiteral(c_int, 0x8CA8, .hex);
pub const GL_DRAW_FRAMEBUFFER = __helpers.promoteIntLiteral(c_int, 0x8CA9, .hex);
pub const GL_READ_FRAMEBUFFER_BINDING = __helpers.promoteIntLiteral(c_int, 0x8CAA, .hex);
pub const GL_RENDERBUFFER_SAMPLES = __helpers.promoteIntLiteral(c_int, 0x8CAB, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = __helpers.promoteIntLiteral(c_int, 0x8CD0, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = __helpers.promoteIntLiteral(c_int, 0x8CD1, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = __helpers.promoteIntLiteral(c_int, 0x8CD2, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = __helpers.promoteIntLiteral(c_int, 0x8CD3, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = __helpers.promoteIntLiteral(c_int, 0x8CD4, .hex);
pub const GL_FRAMEBUFFER_COMPLETE = __helpers.promoteIntLiteral(c_int, 0x8CD5, .hex);
pub const GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = __helpers.promoteIntLiteral(c_int, 0x8CD6, .hex);
pub const GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = __helpers.promoteIntLiteral(c_int, 0x8CD7, .hex);
pub const GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8CDB, .hex);
pub const GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8CDC, .hex);
pub const GL_FRAMEBUFFER_UNSUPPORTED = __helpers.promoteIntLiteral(c_int, 0x8CDD, .hex);
pub const GL_MAX_COLOR_ATTACHMENTS = __helpers.promoteIntLiteral(c_int, 0x8CDF, .hex);
pub const GL_COLOR_ATTACHMENT0 = __helpers.promoteIntLiteral(c_int, 0x8CE0, .hex);
pub const GL_COLOR_ATTACHMENT1 = __helpers.promoteIntLiteral(c_int, 0x8CE1, .hex);
pub const GL_COLOR_ATTACHMENT2 = __helpers.promoteIntLiteral(c_int, 0x8CE2, .hex);
pub const GL_COLOR_ATTACHMENT3 = __helpers.promoteIntLiteral(c_int, 0x8CE3, .hex);
pub const GL_COLOR_ATTACHMENT4 = __helpers.promoteIntLiteral(c_int, 0x8CE4, .hex);
pub const GL_COLOR_ATTACHMENT5 = __helpers.promoteIntLiteral(c_int, 0x8CE5, .hex);
pub const GL_COLOR_ATTACHMENT6 = __helpers.promoteIntLiteral(c_int, 0x8CE6, .hex);
pub const GL_COLOR_ATTACHMENT7 = __helpers.promoteIntLiteral(c_int, 0x8CE7, .hex);
pub const GL_COLOR_ATTACHMENT8 = __helpers.promoteIntLiteral(c_int, 0x8CE8, .hex);
pub const GL_COLOR_ATTACHMENT9 = __helpers.promoteIntLiteral(c_int, 0x8CE9, .hex);
pub const GL_COLOR_ATTACHMENT10 = __helpers.promoteIntLiteral(c_int, 0x8CEA, .hex);
pub const GL_COLOR_ATTACHMENT11 = __helpers.promoteIntLiteral(c_int, 0x8CEB, .hex);
pub const GL_COLOR_ATTACHMENT12 = __helpers.promoteIntLiteral(c_int, 0x8CEC, .hex);
pub const GL_COLOR_ATTACHMENT13 = __helpers.promoteIntLiteral(c_int, 0x8CED, .hex);
pub const GL_COLOR_ATTACHMENT14 = __helpers.promoteIntLiteral(c_int, 0x8CEE, .hex);
pub const GL_COLOR_ATTACHMENT15 = __helpers.promoteIntLiteral(c_int, 0x8CEF, .hex);
pub const GL_COLOR_ATTACHMENT16 = __helpers.promoteIntLiteral(c_int, 0x8CF0, .hex);
pub const GL_COLOR_ATTACHMENT17 = __helpers.promoteIntLiteral(c_int, 0x8CF1, .hex);
pub const GL_COLOR_ATTACHMENT18 = __helpers.promoteIntLiteral(c_int, 0x8CF2, .hex);
pub const GL_COLOR_ATTACHMENT19 = __helpers.promoteIntLiteral(c_int, 0x8CF3, .hex);
pub const GL_COLOR_ATTACHMENT20 = __helpers.promoteIntLiteral(c_int, 0x8CF4, .hex);
pub const GL_COLOR_ATTACHMENT21 = __helpers.promoteIntLiteral(c_int, 0x8CF5, .hex);
pub const GL_COLOR_ATTACHMENT22 = __helpers.promoteIntLiteral(c_int, 0x8CF6, .hex);
pub const GL_COLOR_ATTACHMENT23 = __helpers.promoteIntLiteral(c_int, 0x8CF7, .hex);
pub const GL_COLOR_ATTACHMENT24 = __helpers.promoteIntLiteral(c_int, 0x8CF8, .hex);
pub const GL_COLOR_ATTACHMENT25 = __helpers.promoteIntLiteral(c_int, 0x8CF9, .hex);
pub const GL_COLOR_ATTACHMENT26 = __helpers.promoteIntLiteral(c_int, 0x8CFA, .hex);
pub const GL_COLOR_ATTACHMENT27 = __helpers.promoteIntLiteral(c_int, 0x8CFB, .hex);
pub const GL_COLOR_ATTACHMENT28 = __helpers.promoteIntLiteral(c_int, 0x8CFC, .hex);
pub const GL_COLOR_ATTACHMENT29 = __helpers.promoteIntLiteral(c_int, 0x8CFD, .hex);
pub const GL_COLOR_ATTACHMENT30 = __helpers.promoteIntLiteral(c_int, 0x8CFE, .hex);
pub const GL_COLOR_ATTACHMENT31 = __helpers.promoteIntLiteral(c_int, 0x8CFF, .hex);
pub const GL_DEPTH_ATTACHMENT = __helpers.promoteIntLiteral(c_int, 0x8D00, .hex);
pub const GL_STENCIL_ATTACHMENT = __helpers.promoteIntLiteral(c_int, 0x8D20, .hex);
pub const GL_FRAMEBUFFER = __helpers.promoteIntLiteral(c_int, 0x8D40, .hex);
pub const GL_RENDERBUFFER = __helpers.promoteIntLiteral(c_int, 0x8D41, .hex);
pub const GL_RENDERBUFFER_WIDTH = __helpers.promoteIntLiteral(c_int, 0x8D42, .hex);
pub const GL_RENDERBUFFER_HEIGHT = __helpers.promoteIntLiteral(c_int, 0x8D43, .hex);
pub const GL_RENDERBUFFER_INTERNAL_FORMAT = __helpers.promoteIntLiteral(c_int, 0x8D44, .hex);
pub const GL_STENCIL_INDEX1 = __helpers.promoteIntLiteral(c_int, 0x8D46, .hex);
pub const GL_STENCIL_INDEX4 = __helpers.promoteIntLiteral(c_int, 0x8D47, .hex);
pub const GL_STENCIL_INDEX8 = __helpers.promoteIntLiteral(c_int, 0x8D48, .hex);
pub const GL_STENCIL_INDEX16 = __helpers.promoteIntLiteral(c_int, 0x8D49, .hex);
pub const GL_RENDERBUFFER_RED_SIZE = __helpers.promoteIntLiteral(c_int, 0x8D50, .hex);
pub const GL_RENDERBUFFER_GREEN_SIZE = __helpers.promoteIntLiteral(c_int, 0x8D51, .hex);
pub const GL_RENDERBUFFER_BLUE_SIZE = __helpers.promoteIntLiteral(c_int, 0x8D52, .hex);
pub const GL_RENDERBUFFER_ALPHA_SIZE = __helpers.promoteIntLiteral(c_int, 0x8D53, .hex);
pub const GL_RENDERBUFFER_DEPTH_SIZE = __helpers.promoteIntLiteral(c_int, 0x8D54, .hex);
pub const GL_RENDERBUFFER_STENCIL_SIZE = __helpers.promoteIntLiteral(c_int, 0x8D55, .hex);
pub const GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = __helpers.promoteIntLiteral(c_int, 0x8D56, .hex);
pub const GL_MAX_SAMPLES = __helpers.promoteIntLiteral(c_int, 0x8D57, .hex);
pub const GL_FRAMEBUFFER_SRGB = __helpers.promoteIntLiteral(c_int, 0x8DB9, .hex);
pub const GL_HALF_FLOAT = @as(c_int, 0x140B);
pub const GL_MAP_READ_BIT = @as(c_int, 0x0001);
pub const GL_MAP_WRITE_BIT = @as(c_int, 0x0002);
pub const GL_MAP_INVALIDATE_RANGE_BIT = @as(c_int, 0x0004);
pub const GL_MAP_INVALIDATE_BUFFER_BIT = @as(c_int, 0x0008);
pub const GL_MAP_FLUSH_EXPLICIT_BIT = @as(c_int, 0x0010);
pub const GL_MAP_UNSYNCHRONIZED_BIT = @as(c_int, 0x0020);
pub const GL_COMPRESSED_RED_RGTC1 = __helpers.promoteIntLiteral(c_int, 0x8DBB, .hex);
pub const GL_COMPRESSED_SIGNED_RED_RGTC1 = __helpers.promoteIntLiteral(c_int, 0x8DBC, .hex);
pub const GL_COMPRESSED_RG_RGTC2 = __helpers.promoteIntLiteral(c_int, 0x8DBD, .hex);
pub const GL_COMPRESSED_SIGNED_RG_RGTC2 = __helpers.promoteIntLiteral(c_int, 0x8DBE, .hex);
pub const GL_RG = __helpers.promoteIntLiteral(c_int, 0x8227, .hex);
pub const GL_RG_INTEGER = __helpers.promoteIntLiteral(c_int, 0x8228, .hex);
pub const GL_R8 = __helpers.promoteIntLiteral(c_int, 0x8229, .hex);
pub const GL_R16 = __helpers.promoteIntLiteral(c_int, 0x822A, .hex);
pub const GL_RG8 = __helpers.promoteIntLiteral(c_int, 0x822B, .hex);
pub const GL_RG16 = __helpers.promoteIntLiteral(c_int, 0x822C, .hex);
pub const GL_R16F = __helpers.promoteIntLiteral(c_int, 0x822D, .hex);
pub const GL_R32F = __helpers.promoteIntLiteral(c_int, 0x822E, .hex);
pub const GL_RG16F = __helpers.promoteIntLiteral(c_int, 0x822F, .hex);
pub const GL_RG32F = __helpers.promoteIntLiteral(c_int, 0x8230, .hex);
pub const GL_R8I = __helpers.promoteIntLiteral(c_int, 0x8231, .hex);
pub const GL_R8UI = __helpers.promoteIntLiteral(c_int, 0x8232, .hex);
pub const GL_R16I = __helpers.promoteIntLiteral(c_int, 0x8233, .hex);
pub const GL_R16UI = __helpers.promoteIntLiteral(c_int, 0x8234, .hex);
pub const GL_R32I = __helpers.promoteIntLiteral(c_int, 0x8235, .hex);
pub const GL_R32UI = __helpers.promoteIntLiteral(c_int, 0x8236, .hex);
pub const GL_RG8I = __helpers.promoteIntLiteral(c_int, 0x8237, .hex);
pub const GL_RG8UI = __helpers.promoteIntLiteral(c_int, 0x8238, .hex);
pub const GL_RG16I = __helpers.promoteIntLiteral(c_int, 0x8239, .hex);
pub const GL_RG16UI = __helpers.promoteIntLiteral(c_int, 0x823A, .hex);
pub const GL_RG32I = __helpers.promoteIntLiteral(c_int, 0x823B, .hex);
pub const GL_RG32UI = __helpers.promoteIntLiteral(c_int, 0x823C, .hex);
pub const GL_VERTEX_ARRAY_BINDING = __helpers.promoteIntLiteral(c_int, 0x85B5, .hex);
pub const GL_SAMPLER_2D_RECT = __helpers.promoteIntLiteral(c_int, 0x8B63, .hex);
pub const GL_SAMPLER_2D_RECT_SHADOW = __helpers.promoteIntLiteral(c_int, 0x8B64, .hex);
pub const GL_SAMPLER_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8DC2, .hex);
pub const GL_INT_SAMPLER_2D_RECT = __helpers.promoteIntLiteral(c_int, 0x8DCD, .hex);
pub const GL_INT_SAMPLER_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8DD0, .hex);
pub const GL_UNSIGNED_INT_SAMPLER_2D_RECT = __helpers.promoteIntLiteral(c_int, 0x8DD5, .hex);
pub const GL_UNSIGNED_INT_SAMPLER_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8DD8, .hex);
pub const GL_TEXTURE_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8C2A, .hex);
pub const GL_MAX_TEXTURE_BUFFER_SIZE = __helpers.promoteIntLiteral(c_int, 0x8C2B, .hex);
pub const GL_TEXTURE_BINDING_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8C2C, .hex);
pub const GL_TEXTURE_BUFFER_DATA_STORE_BINDING = __helpers.promoteIntLiteral(c_int, 0x8C2D, .hex);
pub const GL_TEXTURE_RECTANGLE = __helpers.promoteIntLiteral(c_int, 0x84F5, .hex);
pub const GL_TEXTURE_BINDING_RECTANGLE = __helpers.promoteIntLiteral(c_int, 0x84F6, .hex);
pub const GL_PROXY_TEXTURE_RECTANGLE = __helpers.promoteIntLiteral(c_int, 0x84F7, .hex);
pub const GL_MAX_RECTANGLE_TEXTURE_SIZE = __helpers.promoteIntLiteral(c_int, 0x84F8, .hex);
pub const GL_R8_SNORM = __helpers.promoteIntLiteral(c_int, 0x8F94, .hex);
pub const GL_RG8_SNORM = __helpers.promoteIntLiteral(c_int, 0x8F95, .hex);
pub const GL_RGB8_SNORM = __helpers.promoteIntLiteral(c_int, 0x8F96, .hex);
pub const GL_RGBA8_SNORM = __helpers.promoteIntLiteral(c_int, 0x8F97, .hex);
pub const GL_R16_SNORM = __helpers.promoteIntLiteral(c_int, 0x8F98, .hex);
pub const GL_RG16_SNORM = __helpers.promoteIntLiteral(c_int, 0x8F99, .hex);
pub const GL_RGB16_SNORM = __helpers.promoteIntLiteral(c_int, 0x8F9A, .hex);
pub const GL_RGBA16_SNORM = __helpers.promoteIntLiteral(c_int, 0x8F9B, .hex);
pub const GL_SIGNED_NORMALIZED = __helpers.promoteIntLiteral(c_int, 0x8F9C, .hex);
pub const GL_PRIMITIVE_RESTART = __helpers.promoteIntLiteral(c_int, 0x8F9D, .hex);
pub const GL_PRIMITIVE_RESTART_INDEX = __helpers.promoteIntLiteral(c_int, 0x8F9E, .hex);
pub const GL_COPY_READ_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8F36, .hex);
pub const GL_COPY_WRITE_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8F37, .hex);
pub const GL_UNIFORM_BUFFER = __helpers.promoteIntLiteral(c_int, 0x8A11, .hex);
pub const GL_UNIFORM_BUFFER_BINDING = __helpers.promoteIntLiteral(c_int, 0x8A28, .hex);
pub const GL_UNIFORM_BUFFER_START = __helpers.promoteIntLiteral(c_int, 0x8A29, .hex);
pub const GL_UNIFORM_BUFFER_SIZE = __helpers.promoteIntLiteral(c_int, 0x8A2A, .hex);
pub const GL_MAX_VERTEX_UNIFORM_BLOCKS = __helpers.promoteIntLiteral(c_int, 0x8A2B, .hex);
pub const GL_MAX_GEOMETRY_UNIFORM_BLOCKS = __helpers.promoteIntLiteral(c_int, 0x8A2C, .hex);
pub const GL_MAX_FRAGMENT_UNIFORM_BLOCKS = __helpers.promoteIntLiteral(c_int, 0x8A2D, .hex);
pub const GL_MAX_COMBINED_UNIFORM_BLOCKS = __helpers.promoteIntLiteral(c_int, 0x8A2E, .hex);
pub const GL_MAX_UNIFORM_BUFFER_BINDINGS = __helpers.promoteIntLiteral(c_int, 0x8A2F, .hex);
pub const GL_MAX_UNIFORM_BLOCK_SIZE = __helpers.promoteIntLiteral(c_int, 0x8A30, .hex);
pub const GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x8A31, .hex);
pub const GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x8A32, .hex);
pub const GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x8A33, .hex);
pub const GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT = __helpers.promoteIntLiteral(c_int, 0x8A34, .hex);
pub const GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = __helpers.promoteIntLiteral(c_int, 0x8A35, .hex);
pub const GL_ACTIVE_UNIFORM_BLOCKS = __helpers.promoteIntLiteral(c_int, 0x8A36, .hex);
pub const GL_UNIFORM_TYPE = __helpers.promoteIntLiteral(c_int, 0x8A37, .hex);
pub const GL_UNIFORM_SIZE = __helpers.promoteIntLiteral(c_int, 0x8A38, .hex);
pub const GL_UNIFORM_NAME_LENGTH = __helpers.promoteIntLiteral(c_int, 0x8A39, .hex);
pub const GL_UNIFORM_BLOCK_INDEX = __helpers.promoteIntLiteral(c_int, 0x8A3A, .hex);
pub const GL_UNIFORM_OFFSET = __helpers.promoteIntLiteral(c_int, 0x8A3B, .hex);
pub const GL_UNIFORM_ARRAY_STRIDE = __helpers.promoteIntLiteral(c_int, 0x8A3C, .hex);
pub const GL_UNIFORM_MATRIX_STRIDE = __helpers.promoteIntLiteral(c_int, 0x8A3D, .hex);
pub const GL_UNIFORM_IS_ROW_MAJOR = __helpers.promoteIntLiteral(c_int, 0x8A3E, .hex);
pub const GL_UNIFORM_BLOCK_BINDING = __helpers.promoteIntLiteral(c_int, 0x8A3F, .hex);
pub const GL_UNIFORM_BLOCK_DATA_SIZE = __helpers.promoteIntLiteral(c_int, 0x8A40, .hex);
pub const GL_UNIFORM_BLOCK_NAME_LENGTH = __helpers.promoteIntLiteral(c_int, 0x8A41, .hex);
pub const GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS = __helpers.promoteIntLiteral(c_int, 0x8A42, .hex);
pub const GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = __helpers.promoteIntLiteral(c_int, 0x8A43, .hex);
pub const GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = __helpers.promoteIntLiteral(c_int, 0x8A44, .hex);
pub const GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = __helpers.promoteIntLiteral(c_int, 0x8A45, .hex);
pub const GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = __helpers.promoteIntLiteral(c_int, 0x8A46, .hex);
pub const GL_INVALID_INDEX = __helpers.promoteIntLiteral(c_int, 0xFFFFFFFF, .hex);
pub const GL_CONTEXT_CORE_PROFILE_BIT = @as(c_int, 0x00000001);
pub const GL_CONTEXT_COMPATIBILITY_PROFILE_BIT = @as(c_int, 0x00000002);
pub const GL_LINES_ADJACENCY = @as(c_int, 0x000A);
pub const GL_LINE_STRIP_ADJACENCY = @as(c_int, 0x000B);
pub const GL_TRIANGLES_ADJACENCY = @as(c_int, 0x000C);
pub const GL_TRIANGLE_STRIP_ADJACENCY = @as(c_int, 0x000D);
pub const GL_PROGRAM_POINT_SIZE = __helpers.promoteIntLiteral(c_int, 0x8642, .hex);
pub const GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = __helpers.promoteIntLiteral(c_int, 0x8C29, .hex);
pub const GL_FRAMEBUFFER_ATTACHMENT_LAYERED = __helpers.promoteIntLiteral(c_int, 0x8DA7, .hex);
pub const GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = __helpers.promoteIntLiteral(c_int, 0x8DA8, .hex);
pub const GL_GEOMETRY_SHADER = __helpers.promoteIntLiteral(c_int, 0x8DD9, .hex);
pub const GL_GEOMETRY_VERTICES_OUT = __helpers.promoteIntLiteral(c_int, 0x8916, .hex);
pub const GL_GEOMETRY_INPUT_TYPE = __helpers.promoteIntLiteral(c_int, 0x8917, .hex);
pub const GL_GEOMETRY_OUTPUT_TYPE = __helpers.promoteIntLiteral(c_int, 0x8918, .hex);
pub const GL_MAX_GEOMETRY_UNIFORM_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x8DDF, .hex);
pub const GL_MAX_GEOMETRY_OUTPUT_VERTICES = __helpers.promoteIntLiteral(c_int, 0x8DE0, .hex);
pub const GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x8DE1, .hex);
pub const GL_MAX_VERTEX_OUTPUT_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x9122, .hex);
pub const GL_MAX_GEOMETRY_INPUT_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x9123, .hex);
pub const GL_MAX_GEOMETRY_OUTPUT_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x9124, .hex);
pub const GL_MAX_FRAGMENT_INPUT_COMPONENTS = __helpers.promoteIntLiteral(c_int, 0x9125, .hex);
pub const GL_CONTEXT_PROFILE_MASK = __helpers.promoteIntLiteral(c_int, 0x9126, .hex);
pub const GL_DEPTH_CLAMP = __helpers.promoteIntLiteral(c_int, 0x864F, .hex);
pub const GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = __helpers.promoteIntLiteral(c_int, 0x8E4C, .hex);
pub const GL_FIRST_VERTEX_CONVENTION = __helpers.promoteIntLiteral(c_int, 0x8E4D, .hex);
pub const GL_LAST_VERTEX_CONVENTION = __helpers.promoteIntLiteral(c_int, 0x8E4E, .hex);
pub const GL_PROVOKING_VERTEX = __helpers.promoteIntLiteral(c_int, 0x8E4F, .hex);
pub const GL_TEXTURE_CUBE_MAP_SEAMLESS = __helpers.promoteIntLiteral(c_int, 0x884F, .hex);
pub const GL_MAX_SERVER_WAIT_TIMEOUT = __helpers.promoteIntLiteral(c_int, 0x9111, .hex);
pub const GL_OBJECT_TYPE = __helpers.promoteIntLiteral(c_int, 0x9112, .hex);
pub const GL_SYNC_CONDITION = __helpers.promoteIntLiteral(c_int, 0x9113, .hex);
pub const GL_SYNC_STATUS = __helpers.promoteIntLiteral(c_int, 0x9114, .hex);
pub const GL_SYNC_FLAGS = __helpers.promoteIntLiteral(c_int, 0x9115, .hex);
pub const GL_SYNC_FENCE = __helpers.promoteIntLiteral(c_int, 0x9116, .hex);
pub const GL_SYNC_GPU_COMMANDS_COMPLETE = __helpers.promoteIntLiteral(c_int, 0x9117, .hex);
pub const GL_UNSIGNALED = __helpers.promoteIntLiteral(c_int, 0x9118, .hex);
pub const GL_SIGNALED = __helpers.promoteIntLiteral(c_int, 0x9119, .hex);
pub const GL_ALREADY_SIGNALED = __helpers.promoteIntLiteral(c_int, 0x911A, .hex);
pub const GL_TIMEOUT_EXPIRED = __helpers.promoteIntLiteral(c_int, 0x911B, .hex);
pub const GL_CONDITION_SATISFIED = __helpers.promoteIntLiteral(c_int, 0x911C, .hex);
pub const GL_WAIT_FAILED = __helpers.promoteIntLiteral(c_int, 0x911D, .hex);
pub const GL_TIMEOUT_IGNORED = __helpers.promoteIntLiteral(c_int, 0xFFFFFFFFFFFFFFFF, .hex);
pub const GL_SYNC_FLUSH_COMMANDS_BIT = @as(c_int, 0x00000001);
pub const GL_SAMPLE_POSITION = __helpers.promoteIntLiteral(c_int, 0x8E50, .hex);
pub const GL_SAMPLE_MASK = __helpers.promoteIntLiteral(c_int, 0x8E51, .hex);
pub const GL_SAMPLE_MASK_VALUE = __helpers.promoteIntLiteral(c_int, 0x8E52, .hex);
pub const GL_MAX_SAMPLE_MASK_WORDS = __helpers.promoteIntLiteral(c_int, 0x8E59, .hex);
pub const GL_TEXTURE_2D_MULTISAMPLE = __helpers.promoteIntLiteral(c_int, 0x9100, .hex);
pub const GL_PROXY_TEXTURE_2D_MULTISAMPLE = __helpers.promoteIntLiteral(c_int, 0x9101, .hex);
pub const GL_TEXTURE_2D_MULTISAMPLE_ARRAY = __helpers.promoteIntLiteral(c_int, 0x9102, .hex);
pub const GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY = __helpers.promoteIntLiteral(c_int, 0x9103, .hex);
pub const GL_TEXTURE_BINDING_2D_MULTISAMPLE = __helpers.promoteIntLiteral(c_int, 0x9104, .hex);
pub const GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY = __helpers.promoteIntLiteral(c_int, 0x9105, .hex);
pub const GL_TEXTURE_SAMPLES = __helpers.promoteIntLiteral(c_int, 0x9106, .hex);
pub const GL_TEXTURE_FIXED_SAMPLE_LOCATIONS = __helpers.promoteIntLiteral(c_int, 0x9107, .hex);
pub const GL_SAMPLER_2D_MULTISAMPLE = __helpers.promoteIntLiteral(c_int, 0x9108, .hex);
pub const GL_INT_SAMPLER_2D_MULTISAMPLE = __helpers.promoteIntLiteral(c_int, 0x9109, .hex);
pub const GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = __helpers.promoteIntLiteral(c_int, 0x910A, .hex);
pub const GL_SAMPLER_2D_MULTISAMPLE_ARRAY = __helpers.promoteIntLiteral(c_int, 0x910B, .hex);
pub const GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = __helpers.promoteIntLiteral(c_int, 0x910C, .hex);
pub const GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = __helpers.promoteIntLiteral(c_int, 0x910D, .hex);
pub const GL_MAX_COLOR_TEXTURE_SAMPLES = __helpers.promoteIntLiteral(c_int, 0x910E, .hex);
pub const GL_MAX_DEPTH_TEXTURE_SAMPLES = __helpers.promoteIntLiteral(c_int, 0x910F, .hex);
pub const GL_MAX_INTEGER_SAMPLES = __helpers.promoteIntLiteral(c_int, 0x9110, .hex);
pub const GL_VERTEX_ATTRIB_ARRAY_DIVISOR = __helpers.promoteIntLiteral(c_int, 0x88FE, .hex);
pub const GL_SRC1_COLOR = __helpers.promoteIntLiteral(c_int, 0x88F9, .hex);
pub const GL_ONE_MINUS_SRC1_COLOR = __helpers.promoteIntLiteral(c_int, 0x88FA, .hex);
pub const GL_ONE_MINUS_SRC1_ALPHA = __helpers.promoteIntLiteral(c_int, 0x88FB, .hex);
pub const GL_MAX_DUAL_SOURCE_DRAW_BUFFERS = __helpers.promoteIntLiteral(c_int, 0x88FC, .hex);
pub const GL_ANY_SAMPLES_PASSED = __helpers.promoteIntLiteral(c_int, 0x8C2F, .hex);
pub const GL_SAMPLER_BINDING = __helpers.promoteIntLiteral(c_int, 0x8919, .hex);
pub const GL_RGB10_A2UI = __helpers.promoteIntLiteral(c_int, 0x906F, .hex);
pub const GL_TEXTURE_SWIZZLE_R = __helpers.promoteIntLiteral(c_int, 0x8E42, .hex);
pub const GL_TEXTURE_SWIZZLE_G = __helpers.promoteIntLiteral(c_int, 0x8E43, .hex);
pub const GL_TEXTURE_SWIZZLE_B = __helpers.promoteIntLiteral(c_int, 0x8E44, .hex);
pub const GL_TEXTURE_SWIZZLE_A = __helpers.promoteIntLiteral(c_int, 0x8E45, .hex);
pub const GL_TEXTURE_SWIZZLE_RGBA = __helpers.promoteIntLiteral(c_int, 0x8E46, .hex);
pub const GL_TIME_ELAPSED = __helpers.promoteIntLiteral(c_int, 0x88BF, .hex);
pub const GL_TIMESTAMP = __helpers.promoteIntLiteral(c_int, 0x8E28, .hex);
pub const GL_INT_2_10_10_10_REV = __helpers.promoteIntLiteral(c_int, 0x8D9F, .hex);
pub const GL_VERSION_1_0 = @as(c_int, 1);
pub inline fn glCullFace(mode: GLenum) void {
    return glad_glCullFace.?(mode);
}
pub inline fn glFrontFace(mode: GLenum) void {
    return glad_glFrontFace.?(mode);
}
pub inline fn glHint(target: GLenum, mode: GLenum) void {
    return glad_glHint.?(target, mode);
}
pub inline fn glLineWidth(width: GLfloat) void {
    return glad_glLineWidth.?(width);
}
pub inline fn glPointSize(size: GLfloat) void {
    return glad_glPointSize.?(size);
}
pub inline fn glPolygonMode(face: GLenum, mode: GLenum) void {
    return glad_glPolygonMode.?(face, mode);
}
pub inline fn glScissor(x: GLint, y: GLint, width: GLsizei, height: GLsizei) void {
    return glad_glScissor.?(x, y, width, height);
}
pub inline fn glTexParameterf(target: GLenum, pname: GLenum, param: GLfloat) void {
    return glad_glTexParameterf.?(target, pname, param);
}
pub inline fn glTexParameterfv(target: GLenum, pname: GLenum, params: [*c]const GLfloat) void {
    return glad_glTexParameterfv.?(target, pname, params);
}
pub inline fn glTexParameteri(target: GLenum, pname: GLenum, param: GLint) void {
    return glad_glTexParameteri.?(target, pname, param);
}
pub inline fn glTexParameteriv(target: GLenum, pname: GLenum, params: [*c]const GLint) void {
    return glad_glTexParameteriv.?(target, pname, params);
}
pub inline fn glTexImage1D(target: GLenum, level: GLint, internalformat: GLint, width: GLsizei, border: GLint, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) void {
    return glad_glTexImage1D.?(target, level, internalformat, width, border, format, @"type", pixels);
}
pub inline fn glTexImage2D(target: GLenum, level: GLint, internalformat: GLint, width: GLsizei, height: GLsizei, border: GLint, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) void {
    return glad_glTexImage2D.?(target, level, internalformat, width, height, border, format, @"type", pixels);
}
pub inline fn glDrawBuffer(buf: GLenum) void {
    return glad_glDrawBuffer.?(buf);
}
pub inline fn glClear(mask: GLbitfield) void {
    return glad_glClear.?(mask);
}
pub inline fn glClearColor(red: GLfloat, green: GLfloat, blue: GLfloat, alpha: GLfloat) void {
    return glad_glClearColor.?(red, green, blue, alpha);
}
pub inline fn glClearStencil(s: GLint) void {
    return glad_glClearStencil.?(s);
}
pub inline fn glClearDepth(depth: GLdouble) void {
    return glad_glClearDepth.?(depth);
}
pub inline fn glStencilMask(mask: GLuint) void {
    return glad_glStencilMask.?(mask);
}
pub inline fn glColorMask(red: GLboolean, green: GLboolean, blue: GLboolean, alpha: GLboolean) void {
    return glad_glColorMask.?(red, green, blue, alpha);
}
pub inline fn glDepthMask(flag: GLboolean) void {
    return glad_glDepthMask.?(flag);
}
pub inline fn glDisable(cap: GLenum) void {
    return glad_glDisable.?(cap);
}
pub inline fn glEnable(cap: GLenum) void {
    return glad_glEnable.?(cap);
}
pub inline fn glFinish() void {
    return glad_glFinish.?();
}
pub inline fn glFlush() void {
    return glad_glFlush.?();
}
pub inline fn glBlendFunc(sfactor: GLenum, dfactor: GLenum) void {
    return glad_glBlendFunc.?(sfactor, dfactor);
}
pub inline fn glLogicOp(opcode: GLenum) void {
    return glad_glLogicOp.?(opcode);
}
pub inline fn glStencilFunc(func: GLenum, ref: GLint, mask: GLuint) void {
    return glad_glStencilFunc.?(func, ref, mask);
}
pub inline fn glStencilOp(fail: GLenum, zfail: GLenum, zpass: GLenum) void {
    return glad_glStencilOp.?(fail, zfail, zpass);
}
pub inline fn glDepthFunc(func: GLenum) void {
    return glad_glDepthFunc.?(func);
}
pub inline fn glPixelStoref(pname: GLenum, param: GLfloat) void {
    return glad_glPixelStoref.?(pname, param);
}
pub inline fn glPixelStorei(pname: GLenum, param: GLint) void {
    return glad_glPixelStorei.?(pname, param);
}
pub inline fn glReadBuffer(src: GLenum) void {
    return glad_glReadBuffer.?(src);
}
pub inline fn glReadPixels(x: GLint, y: GLint, width: GLsizei, height: GLsizei, format: GLenum, @"type": GLenum, pixels: ?*anyopaque) void {
    return glad_glReadPixels.?(x, y, width, height, format, @"type", pixels);
}
pub inline fn glGetBooleanv(pname: GLenum, data: [*c]GLboolean) void {
    return glad_glGetBooleanv.?(pname, data);
}
pub inline fn glGetDoublev(pname: GLenum, data: [*c]GLdouble) void {
    return glad_glGetDoublev.?(pname, data);
}
pub inline fn glGetError() GLenum {
    return glad_glGetError.?();
}
pub inline fn glGetFloatv(pname: GLenum, data: [*c]GLfloat) void {
    return glad_glGetFloatv.?(pname, data);
}
pub inline fn glGetIntegerv(pname: GLenum, data: [*c]GLint) void {
    return glad_glGetIntegerv.?(pname, data);
}
pub inline fn glGetString(name: GLenum) [*c]const GLubyte {
    return glad_glGetString.?(name);
}
pub inline fn glGetTexImage(target: GLenum, level: GLint, format: GLenum, @"type": GLenum, pixels: ?*anyopaque) void {
    return glad_glGetTexImage.?(target, level, format, @"type", pixels);
}
pub inline fn glGetTexParameterfv(target: GLenum, pname: GLenum, params: [*c]GLfloat) void {
    return glad_glGetTexParameterfv.?(target, pname, params);
}
pub inline fn glGetTexParameteriv(target: GLenum, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetTexParameteriv.?(target, pname, params);
}
pub inline fn glGetTexLevelParameterfv(target: GLenum, level: GLint, pname: GLenum, params: [*c]GLfloat) void {
    return glad_glGetTexLevelParameterfv.?(target, level, pname, params);
}
pub inline fn glGetTexLevelParameteriv(target: GLenum, level: GLint, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetTexLevelParameteriv.?(target, level, pname, params);
}
pub inline fn glIsEnabled(cap: GLenum) GLboolean {
    return glad_glIsEnabled.?(cap);
}
pub inline fn glDepthRange(n: GLdouble, f: GLdouble) void {
    return glad_glDepthRange.?(n, f);
}
pub inline fn glViewport(x: GLint, y: GLint, width: GLsizei, height: GLsizei) void {
    return glad_glViewport.?(x, y, width, height);
}
pub const GL_VERSION_1_1 = @as(c_int, 1);
pub inline fn glDrawArrays(mode: GLenum, first: GLint, count: GLsizei) void {
    return glad_glDrawArrays.?(mode, first, count);
}
pub inline fn glDrawElements(mode: GLenum, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque) void {
    return glad_glDrawElements.?(mode, count, @"type", indices);
}
pub inline fn glPolygonOffset(factor: GLfloat, units: GLfloat) void {
    return glad_glPolygonOffset.?(factor, units);
}
pub inline fn glCopyTexImage1D(target: GLenum, level: GLint, internalformat: GLenum, x: GLint, y: GLint, width: GLsizei, border: GLint) void {
    return glad_glCopyTexImage1D.?(target, level, internalformat, x, y, width, border);
}
pub inline fn glCopyTexImage2D(target: GLenum, level: GLint, internalformat: GLenum, x: GLint, y: GLint, width: GLsizei, height: GLsizei, border: GLint) void {
    return glad_glCopyTexImage2D.?(target, level, internalformat, x, y, width, height, border);
}
pub inline fn glCopyTexSubImage1D(target: GLenum, level: GLint, xoffset: GLint, x: GLint, y: GLint, width: GLsizei) void {
    return glad_glCopyTexSubImage1D.?(target, level, xoffset, x, y, width);
}
pub inline fn glCopyTexSubImage2D(target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, x: GLint, y: GLint, width: GLsizei, height: GLsizei) void {
    return glad_glCopyTexSubImage2D.?(target, level, xoffset, yoffset, x, y, width, height);
}
pub inline fn glTexSubImage1D(target: GLenum, level: GLint, xoffset: GLint, width: GLsizei, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) void {
    return glad_glTexSubImage1D.?(target, level, xoffset, width, format, @"type", pixels);
}
pub inline fn glTexSubImage2D(target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, width: GLsizei, height: GLsizei, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) void {
    return glad_glTexSubImage2D.?(target, level, xoffset, yoffset, width, height, format, @"type", pixels);
}
pub inline fn glBindTexture(target: GLenum, texture: GLuint) void {
    return glad_glBindTexture.?(target, texture);
}
pub inline fn glDeleteTextures(n: GLsizei, textures: [*c]const GLuint) void {
    return glad_glDeleteTextures.?(n, textures);
}
pub inline fn glGenTextures(n: GLsizei, textures: [*c]GLuint) void {
    return glad_glGenTextures.?(n, textures);
}
pub inline fn glIsTexture(texture: GLuint) GLboolean {
    return glad_glIsTexture.?(texture);
}
pub const GL_VERSION_1_2 = @as(c_int, 1);
pub inline fn glDrawRangeElements(mode: GLenum, start: GLuint, end: GLuint, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque) void {
    return glad_glDrawRangeElements.?(mode, start, end, count, @"type", indices);
}
pub inline fn glTexImage3D(target: GLenum, level: GLint, internalformat: GLint, width: GLsizei, height: GLsizei, depth: GLsizei, border: GLint, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) void {
    return glad_glTexImage3D.?(target, level, internalformat, width, height, depth, border, format, @"type", pixels);
}
pub inline fn glTexSubImage3D(target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, zoffset: GLint, width: GLsizei, height: GLsizei, depth: GLsizei, format: GLenum, @"type": GLenum, pixels: ?*const anyopaque) void {
    return glad_glTexSubImage3D.?(target, level, xoffset, yoffset, zoffset, width, height, depth, format, @"type", pixels);
}
pub inline fn glCopyTexSubImage3D(target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, zoffset: GLint, x: GLint, y: GLint, width: GLsizei, height: GLsizei) void {
    return glad_glCopyTexSubImage3D.?(target, level, xoffset, yoffset, zoffset, x, y, width, height);
}
pub const GL_VERSION_1_3 = @as(c_int, 1);
pub inline fn glActiveTexture(texture: GLenum) void {
    return glad_glActiveTexture.?(texture);
}
pub inline fn glSampleCoverage(value: GLfloat, invert: GLboolean) void {
    return glad_glSampleCoverage.?(value, invert);
}
pub inline fn glCompressedTexImage3D(target: GLenum, level: GLint, internalformat: GLenum, width: GLsizei, height: GLsizei, depth: GLsizei, border: GLint, imageSize: GLsizei, data: ?*const anyopaque) void {
    return glad_glCompressedTexImage3D.?(target, level, internalformat, width, height, depth, border, imageSize, data);
}
pub inline fn glCompressedTexImage2D(target: GLenum, level: GLint, internalformat: GLenum, width: GLsizei, height: GLsizei, border: GLint, imageSize: GLsizei, data: ?*const anyopaque) void {
    return glad_glCompressedTexImage2D.?(target, level, internalformat, width, height, border, imageSize, data);
}
pub inline fn glCompressedTexImage1D(target: GLenum, level: GLint, internalformat: GLenum, width: GLsizei, border: GLint, imageSize: GLsizei, data: ?*const anyopaque) void {
    return glad_glCompressedTexImage1D.?(target, level, internalformat, width, border, imageSize, data);
}
pub inline fn glCompressedTexSubImage3D(target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, zoffset: GLint, width: GLsizei, height: GLsizei, depth: GLsizei, format: GLenum, imageSize: GLsizei, data: ?*const anyopaque) void {
    return glad_glCompressedTexSubImage3D.?(target, level, xoffset, yoffset, zoffset, width, height, depth, format, imageSize, data);
}
pub inline fn glCompressedTexSubImage2D(target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, width: GLsizei, height: GLsizei, format: GLenum, imageSize: GLsizei, data: ?*const anyopaque) void {
    return glad_glCompressedTexSubImage2D.?(target, level, xoffset, yoffset, width, height, format, imageSize, data);
}
pub inline fn glCompressedTexSubImage1D(target: GLenum, level: GLint, xoffset: GLint, width: GLsizei, format: GLenum, imageSize: GLsizei, data: ?*const anyopaque) void {
    return glad_glCompressedTexSubImage1D.?(target, level, xoffset, width, format, imageSize, data);
}
pub inline fn glGetCompressedTexImage(target: GLenum, level: GLint, img: ?*anyopaque) void {
    return glad_glGetCompressedTexImage.?(target, level, img);
}
pub const GL_VERSION_1_4 = @as(c_int, 1);
pub inline fn glBlendFuncSeparate(sfactorRGB: GLenum, dfactorRGB: GLenum, sfactorAlpha: GLenum, dfactorAlpha: GLenum) void {
    return glad_glBlendFuncSeparate.?(sfactorRGB, dfactorRGB, sfactorAlpha, dfactorAlpha);
}
pub inline fn glMultiDrawArrays(mode: GLenum, first: [*c]const GLint, count: [*c]const GLsizei, drawcount: GLsizei) void {
    return glad_glMultiDrawArrays.?(mode, first, count, drawcount);
}
pub inline fn glMultiDrawElements(mode: GLenum, count: [*c]const GLsizei, @"type": GLenum, indices: [*c]const ?*const anyopaque, drawcount: GLsizei) void {
    return glad_glMultiDrawElements.?(mode, count, @"type", indices, drawcount);
}
pub inline fn glPointParameterf(pname: GLenum, param: GLfloat) void {
    return glad_glPointParameterf.?(pname, param);
}
pub inline fn glPointParameterfv(pname: GLenum, params: [*c]const GLfloat) void {
    return glad_glPointParameterfv.?(pname, params);
}
pub inline fn glPointParameteri(pname: GLenum, param: GLint) void {
    return glad_glPointParameteri.?(pname, param);
}
pub inline fn glPointParameteriv(pname: GLenum, params: [*c]const GLint) void {
    return glad_glPointParameteriv.?(pname, params);
}
pub inline fn glBlendColor(red: GLfloat, green: GLfloat, blue: GLfloat, alpha: GLfloat) void {
    return glad_glBlendColor.?(red, green, blue, alpha);
}
pub inline fn glBlendEquation(mode: GLenum) void {
    return glad_glBlendEquation.?(mode);
}
pub const GL_VERSION_1_5 = @as(c_int, 1);
pub inline fn glGenQueries(n: GLsizei, ids: [*c]GLuint) void {
    return glad_glGenQueries.?(n, ids);
}
pub inline fn glDeleteQueries(n: GLsizei, ids: [*c]const GLuint) void {
    return glad_glDeleteQueries.?(n, ids);
}
pub inline fn glIsQuery(id: GLuint) GLboolean {
    return glad_glIsQuery.?(id);
}
pub inline fn glBeginQuery(target: GLenum, id: GLuint) void {
    return glad_glBeginQuery.?(target, id);
}
pub inline fn glEndQuery(target: GLenum) void {
    return glad_glEndQuery.?(target);
}
pub inline fn glGetQueryiv(target: GLenum, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetQueryiv.?(target, pname, params);
}
pub inline fn glGetQueryObjectiv(id: GLuint, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetQueryObjectiv.?(id, pname, params);
}
pub inline fn glGetQueryObjectuiv(id: GLuint, pname: GLenum, params: [*c]GLuint) void {
    return glad_glGetQueryObjectuiv.?(id, pname, params);
}
pub inline fn glBindBuffer(target: GLenum, buffer: GLuint) void {
    return glad_glBindBuffer.?(target, buffer);
}
pub inline fn glDeleteBuffers(n: GLsizei, buffers: [*c]const GLuint) void {
    return glad_glDeleteBuffers.?(n, buffers);
}
pub inline fn glGenBuffers(n: GLsizei, buffers: [*c]GLuint) void {
    return glad_glGenBuffers.?(n, buffers);
}
pub inline fn glIsBuffer(buffer: GLuint) GLboolean {
    return glad_glIsBuffer.?(buffer);
}
pub inline fn glBufferData(target: GLenum, size: GLsizeiptr, data: ?*const anyopaque, usage: GLenum) void {
    return glad_glBufferData.?(target, size, data, usage);
}
pub inline fn glBufferSubData(target: GLenum, offset: GLintptr, size: GLsizeiptr, data: ?*const anyopaque) void {
    return glad_glBufferSubData.?(target, offset, size, data);
}
pub inline fn glGetBufferSubData(target: GLenum, offset: GLintptr, size: GLsizeiptr, data: ?*anyopaque) void {
    return glad_glGetBufferSubData.?(target, offset, size, data);
}
pub inline fn glMapBuffer(target: GLenum, access: GLenum) ?*anyopaque {
    return glad_glMapBuffer.?(target, access);
}
pub inline fn glUnmapBuffer(target: GLenum) GLboolean {
    return glad_glUnmapBuffer.?(target);
}
pub inline fn glGetBufferParameteriv(target: GLenum, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetBufferParameteriv.?(target, pname, params);
}
pub inline fn glGetBufferPointerv(target: GLenum, pname: GLenum, params: [*c]?*anyopaque) void {
    return glad_glGetBufferPointerv.?(target, pname, params);
}
pub const GL_VERSION_2_0 = @as(c_int, 1);
pub inline fn glBlendEquationSeparate(modeRGB: GLenum, modeAlpha: GLenum) void {
    return glad_glBlendEquationSeparate.?(modeRGB, modeAlpha);
}
pub inline fn glDrawBuffers(n: GLsizei, bufs: [*c]const GLenum) void {
    return glad_glDrawBuffers.?(n, bufs);
}
pub inline fn glStencilOpSeparate(face: GLenum, sfail: GLenum, dpfail: GLenum, dppass: GLenum) void {
    return glad_glStencilOpSeparate.?(face, sfail, dpfail, dppass);
}
pub inline fn glStencilFuncSeparate(face: GLenum, func: GLenum, ref: GLint, mask: GLuint) void {
    return glad_glStencilFuncSeparate.?(face, func, ref, mask);
}
pub inline fn glStencilMaskSeparate(face: GLenum, mask: GLuint) void {
    return glad_glStencilMaskSeparate.?(face, mask);
}
pub inline fn glAttachShader(program: GLuint, shader: GLuint) void {
    return glad_glAttachShader.?(program, shader);
}
pub inline fn glBindAttribLocation(program: GLuint, index: GLuint, name: [*c]const GLchar) void {
    return glad_glBindAttribLocation.?(program, index, name);
}
pub inline fn glCompileShader(shader: GLuint) void {
    return glad_glCompileShader.?(shader);
}
pub inline fn glCreateProgram() GLuint {
    return glad_glCreateProgram.?();
}
pub inline fn glCreateShader(@"type": GLenum) GLuint {
    return glad_glCreateShader.?(@"type");
}
pub inline fn glDeleteProgram(program: GLuint) void {
    return glad_glDeleteProgram.?(program);
}
pub inline fn glDeleteShader(shader: GLuint) void {
    return glad_glDeleteShader.?(shader);
}
pub inline fn glDetachShader(program: GLuint, shader: GLuint) void {
    return glad_glDetachShader.?(program, shader);
}
pub inline fn glDisableVertexAttribArray(index: GLuint) void {
    return glad_glDisableVertexAttribArray.?(index);
}
pub inline fn glEnableVertexAttribArray(index: GLuint) void {
    return glad_glEnableVertexAttribArray.?(index);
}
pub inline fn glGetActiveAttrib(program: GLuint, index: GLuint, bufSize: GLsizei, length: [*c]GLsizei, size: [*c]GLint, @"type": [*c]GLenum, name: [*c]GLchar) void {
    return glad_glGetActiveAttrib.?(program, index, bufSize, length, size, @"type", name);
}
pub inline fn glGetActiveUniform(program: GLuint, index: GLuint, bufSize: GLsizei, length: [*c]GLsizei, size: [*c]GLint, @"type": [*c]GLenum, name: [*c]GLchar) void {
    return glad_glGetActiveUniform.?(program, index, bufSize, length, size, @"type", name);
}
pub inline fn glGetAttachedShaders(program: GLuint, maxCount: GLsizei, count: [*c]GLsizei, shaders: [*c]GLuint) void {
    return glad_glGetAttachedShaders.?(program, maxCount, count, shaders);
}
pub inline fn glGetAttribLocation(program: GLuint, name: [*c]const GLchar) GLint {
    return glad_glGetAttribLocation.?(program, name);
}
pub inline fn glGetProgramiv(program: GLuint, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetProgramiv.?(program, pname, params);
}
pub inline fn glGetProgramInfoLog(program: GLuint, bufSize: GLsizei, length: [*c]GLsizei, infoLog: [*c]GLchar) void {
    return glad_glGetProgramInfoLog.?(program, bufSize, length, infoLog);
}
pub inline fn glGetShaderiv(shader: GLuint, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetShaderiv.?(shader, pname, params);
}
pub inline fn glGetShaderInfoLog(shader: GLuint, bufSize: GLsizei, length: [*c]GLsizei, infoLog: [*c]GLchar) void {
    return glad_glGetShaderInfoLog.?(shader, bufSize, length, infoLog);
}
pub inline fn glGetShaderSource(shader: GLuint, bufSize: GLsizei, length: [*c]GLsizei, source: [*c]GLchar) void {
    return glad_glGetShaderSource.?(shader, bufSize, length, source);
}
pub inline fn glGetUniformLocation(program: GLuint, name: [*c]const GLchar) GLint {
    return glad_glGetUniformLocation.?(program, name);
}
pub inline fn glGetUniformfv(program: GLuint, location: GLint, params: [*c]GLfloat) void {
    return glad_glGetUniformfv.?(program, location, params);
}
pub inline fn glGetUniformiv(program: GLuint, location: GLint, params: [*c]GLint) void {
    return glad_glGetUniformiv.?(program, location, params);
}
pub inline fn glGetVertexAttribdv(index: GLuint, pname: GLenum, params: [*c]GLdouble) void {
    return glad_glGetVertexAttribdv.?(index, pname, params);
}
pub inline fn glGetVertexAttribfv(index: GLuint, pname: GLenum, params: [*c]GLfloat) void {
    return glad_glGetVertexAttribfv.?(index, pname, params);
}
pub inline fn glGetVertexAttribiv(index: GLuint, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetVertexAttribiv.?(index, pname, params);
}
pub inline fn glGetVertexAttribPointerv(index: GLuint, pname: GLenum, pointer: [*c]?*anyopaque) void {
    return glad_glGetVertexAttribPointerv.?(index, pname, pointer);
}
pub inline fn glIsProgram(program: GLuint) GLboolean {
    return glad_glIsProgram.?(program);
}
pub inline fn glIsShader(shader: GLuint) GLboolean {
    return glad_glIsShader.?(shader);
}
pub inline fn glLinkProgram(program: GLuint) void {
    return glad_glLinkProgram.?(program);
}
pub inline fn glShaderSource(shader: GLuint, count: GLsizei, string: [*c]const [*c]const GLchar, length: [*c]const GLint) void {
    return glad_glShaderSource.?(shader, count, string, length);
}
pub inline fn glUseProgram(program: GLuint) void {
    return glad_glUseProgram.?(program);
}
pub inline fn glUniform1f(location: GLint, v0: GLfloat) void {
    return glad_glUniform1f.?(location, v0);
}
pub inline fn glUniform2f(location: GLint, v0: GLfloat, v1: GLfloat) void {
    return glad_glUniform2f.?(location, v0, v1);
}
pub inline fn glUniform3f(location: GLint, v0: GLfloat, v1: GLfloat, v2: GLfloat) void {
    return glad_glUniform3f.?(location, v0, v1, v2);
}
pub inline fn glUniform4f(location: GLint, v0: GLfloat, v1: GLfloat, v2: GLfloat, v3: GLfloat) void {
    return glad_glUniform4f.?(location, v0, v1, v2, v3);
}
pub inline fn glUniform1i(location: GLint, v0: GLint) void {
    return glad_glUniform1i.?(location, v0);
}
pub inline fn glUniform2i(location: GLint, v0: GLint, v1: GLint) void {
    return glad_glUniform2i.?(location, v0, v1);
}
pub inline fn glUniform3i(location: GLint, v0: GLint, v1: GLint, v2: GLint) void {
    return glad_glUniform3i.?(location, v0, v1, v2);
}
pub inline fn glUniform4i(location: GLint, v0: GLint, v1: GLint, v2: GLint, v3: GLint) void {
    return glad_glUniform4i.?(location, v0, v1, v2, v3);
}
pub inline fn glUniform1fv(location: GLint, count: GLsizei, value: [*c]const GLfloat) void {
    return glad_glUniform1fv.?(location, count, value);
}
pub inline fn glUniform2fv(location: GLint, count: GLsizei, value: [*c]const GLfloat) void {
    return glad_glUniform2fv.?(location, count, value);
}
pub inline fn glUniform3fv(location: GLint, count: GLsizei, value: [*c]const GLfloat) void {
    return glad_glUniform3fv.?(location, count, value);
}
pub inline fn glUniform4fv(location: GLint, count: GLsizei, value: [*c]const GLfloat) void {
    return glad_glUniform4fv.?(location, count, value);
}
pub inline fn glUniform1iv(location: GLint, count: GLsizei, value: [*c]const GLint) void {
    return glad_glUniform1iv.?(location, count, value);
}
pub inline fn glUniform2iv(location: GLint, count: GLsizei, value: [*c]const GLint) void {
    return glad_glUniform2iv.?(location, count, value);
}
pub inline fn glUniform3iv(location: GLint, count: GLsizei, value: [*c]const GLint) void {
    return glad_glUniform3iv.?(location, count, value);
}
pub inline fn glUniform4iv(location: GLint, count: GLsizei, value: [*c]const GLint) void {
    return glad_glUniform4iv.?(location, count, value);
}
pub inline fn glUniformMatrix2fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) void {
    return glad_glUniformMatrix2fv.?(location, count, transpose, value);
}
pub inline fn glUniformMatrix3fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) void {
    return glad_glUniformMatrix3fv.?(location, count, transpose, value);
}
pub inline fn glUniformMatrix4fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) void {
    return glad_glUniformMatrix4fv.?(location, count, transpose, value);
}
pub inline fn glValidateProgram(program: GLuint) void {
    return glad_glValidateProgram.?(program);
}
pub inline fn glVertexAttrib1d(index: GLuint, x: GLdouble) void {
    return glad_glVertexAttrib1d.?(index, x);
}
pub inline fn glVertexAttrib1dv(index: GLuint, v: [*c]const GLdouble) void {
    return glad_glVertexAttrib1dv.?(index, v);
}
pub inline fn glVertexAttrib1f(index: GLuint, x: GLfloat) void {
    return glad_glVertexAttrib1f.?(index, x);
}
pub inline fn glVertexAttrib1fv(index: GLuint, v: [*c]const GLfloat) void {
    return glad_glVertexAttrib1fv.?(index, v);
}
pub inline fn glVertexAttrib1s(index: GLuint, x: GLshort) void {
    return glad_glVertexAttrib1s.?(index, x);
}
pub inline fn glVertexAttrib1sv(index: GLuint, v: [*c]const GLshort) void {
    return glad_glVertexAttrib1sv.?(index, v);
}
pub inline fn glVertexAttrib2d(index: GLuint, x: GLdouble, y: GLdouble) void {
    return glad_glVertexAttrib2d.?(index, x, y);
}
pub inline fn glVertexAttrib2dv(index: GLuint, v: [*c]const GLdouble) void {
    return glad_glVertexAttrib2dv.?(index, v);
}
pub inline fn glVertexAttrib2f(index: GLuint, x: GLfloat, y: GLfloat) void {
    return glad_glVertexAttrib2f.?(index, x, y);
}
pub inline fn glVertexAttrib2fv(index: GLuint, v: [*c]const GLfloat) void {
    return glad_glVertexAttrib2fv.?(index, v);
}
pub inline fn glVertexAttrib2s(index: GLuint, x: GLshort, y: GLshort) void {
    return glad_glVertexAttrib2s.?(index, x, y);
}
pub inline fn glVertexAttrib2sv(index: GLuint, v: [*c]const GLshort) void {
    return glad_glVertexAttrib2sv.?(index, v);
}
pub inline fn glVertexAttrib3d(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble) void {
    return glad_glVertexAttrib3d.?(index, x, y, z);
}
pub inline fn glVertexAttrib3dv(index: GLuint, v: [*c]const GLdouble) void {
    return glad_glVertexAttrib3dv.?(index, v);
}
pub inline fn glVertexAttrib3f(index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat) void {
    return glad_glVertexAttrib3f.?(index, x, y, z);
}
pub inline fn glVertexAttrib3fv(index: GLuint, v: [*c]const GLfloat) void {
    return glad_glVertexAttrib3fv.?(index, v);
}
pub inline fn glVertexAttrib3s(index: GLuint, x: GLshort, y: GLshort, z: GLshort) void {
    return glad_glVertexAttrib3s.?(index, x, y, z);
}
pub inline fn glVertexAttrib3sv(index: GLuint, v: [*c]const GLshort) void {
    return glad_glVertexAttrib3sv.?(index, v);
}
pub inline fn glVertexAttrib4Nbv(index: GLuint, v: [*c]const GLbyte) void {
    return glad_glVertexAttrib4Nbv.?(index, v);
}
pub inline fn glVertexAttrib4Niv(index: GLuint, v: [*c]const GLint) void {
    return glad_glVertexAttrib4Niv.?(index, v);
}
pub inline fn glVertexAttrib4Nsv(index: GLuint, v: [*c]const GLshort) void {
    return glad_glVertexAttrib4Nsv.?(index, v);
}
pub inline fn glVertexAttrib4Nub(index: GLuint, x: GLubyte, y: GLubyte, z: GLubyte, w: GLubyte) void {
    return glad_glVertexAttrib4Nub.?(index, x, y, z, w);
}
pub inline fn glVertexAttrib4Nubv(index: GLuint, v: [*c]const GLubyte) void {
    return glad_glVertexAttrib4Nubv.?(index, v);
}
pub inline fn glVertexAttrib4Nuiv(index: GLuint, v: [*c]const GLuint) void {
    return glad_glVertexAttrib4Nuiv.?(index, v);
}
pub inline fn glVertexAttrib4Nusv(index: GLuint, v: [*c]const GLushort) void {
    return glad_glVertexAttrib4Nusv.?(index, v);
}
pub inline fn glVertexAttrib4bv(index: GLuint, v: [*c]const GLbyte) void {
    return glad_glVertexAttrib4bv.?(index, v);
}
pub inline fn glVertexAttrib4d(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble, w: GLdouble) void {
    return glad_glVertexAttrib4d.?(index, x, y, z, w);
}
pub inline fn glVertexAttrib4dv(index: GLuint, v: [*c]const GLdouble) void {
    return glad_glVertexAttrib4dv.?(index, v);
}
pub inline fn glVertexAttrib4f(index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat) void {
    return glad_glVertexAttrib4f.?(index, x, y, z, w);
}
pub inline fn glVertexAttrib4fv(index: GLuint, v: [*c]const GLfloat) void {
    return glad_glVertexAttrib4fv.?(index, v);
}
pub inline fn glVertexAttrib4iv(index: GLuint, v: [*c]const GLint) void {
    return glad_glVertexAttrib4iv.?(index, v);
}
pub inline fn glVertexAttrib4s(index: GLuint, x: GLshort, y: GLshort, z: GLshort, w: GLshort) void {
    return glad_glVertexAttrib4s.?(index, x, y, z, w);
}
pub inline fn glVertexAttrib4sv(index: GLuint, v: [*c]const GLshort) void {
    return glad_glVertexAttrib4sv.?(index, v);
}
pub inline fn glVertexAttrib4ubv(index: GLuint, v: [*c]const GLubyte) void {
    return glad_glVertexAttrib4ubv.?(index, v);
}
pub inline fn glVertexAttrib4uiv(index: GLuint, v: [*c]const GLuint) void {
    return glad_glVertexAttrib4uiv.?(index, v);
}
pub inline fn glVertexAttrib4usv(index: GLuint, v: [*c]const GLushort) void {
    return glad_glVertexAttrib4usv.?(index, v);
}
pub inline fn glVertexAttribPointer(index: GLuint, size: GLint, @"type": GLenum, normalized: GLboolean, stride: GLsizei, pointer: ?*const anyopaque) void {
    return glad_glVertexAttribPointer.?(index, size, @"type", normalized, stride, pointer);
}
pub const GL_VERSION_2_1 = @as(c_int, 1);
pub inline fn glUniformMatrix2x3fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) void {
    return glad_glUniformMatrix2x3fv.?(location, count, transpose, value);
}
pub inline fn glUniformMatrix3x2fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) void {
    return glad_glUniformMatrix3x2fv.?(location, count, transpose, value);
}
pub inline fn glUniformMatrix2x4fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) void {
    return glad_glUniformMatrix2x4fv.?(location, count, transpose, value);
}
pub inline fn glUniformMatrix4x2fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) void {
    return glad_glUniformMatrix4x2fv.?(location, count, transpose, value);
}
pub inline fn glUniformMatrix3x4fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) void {
    return glad_glUniformMatrix3x4fv.?(location, count, transpose, value);
}
pub inline fn glUniformMatrix4x3fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) void {
    return glad_glUniformMatrix4x3fv.?(location, count, transpose, value);
}
pub const GL_VERSION_3_0 = @as(c_int, 1);
pub inline fn glColorMaski(index: GLuint, r: GLboolean, g: GLboolean, b: GLboolean, a: GLboolean) void {
    return glad_glColorMaski.?(index, r, g, b, a);
}
pub inline fn glGetBooleani_v(target: GLenum, index: GLuint, data: [*c]GLboolean) void {
    return glad_glGetBooleani_v.?(target, index, data);
}
pub inline fn glGetIntegeri_v(target: GLenum, index: GLuint, data: [*c]GLint) void {
    return glad_glGetIntegeri_v.?(target, index, data);
}
pub inline fn glEnablei(target: GLenum, index: GLuint) void {
    return glad_glEnablei.?(target, index);
}
pub inline fn glDisablei(target: GLenum, index: GLuint) void {
    return glad_glDisablei.?(target, index);
}
pub inline fn glIsEnabledi(target: GLenum, index: GLuint) GLboolean {
    return glad_glIsEnabledi.?(target, index);
}
pub inline fn glBeginTransformFeedback(primitiveMode: GLenum) void {
    return glad_glBeginTransformFeedback.?(primitiveMode);
}
pub inline fn glEndTransformFeedback() void {
    return glad_glEndTransformFeedback.?();
}
pub inline fn glBindBufferRange(target: GLenum, index: GLuint, buffer: GLuint, offset: GLintptr, size: GLsizeiptr) void {
    return glad_glBindBufferRange.?(target, index, buffer, offset, size);
}
pub inline fn glBindBufferBase(target: GLenum, index: GLuint, buffer: GLuint) void {
    return glad_glBindBufferBase.?(target, index, buffer);
}
pub inline fn glTransformFeedbackVaryings(program: GLuint, count: GLsizei, varyings: [*c]const [*c]const GLchar, bufferMode: GLenum) void {
    return glad_glTransformFeedbackVaryings.?(program, count, varyings, bufferMode);
}
pub inline fn glGetTransformFeedbackVarying(program: GLuint, index: GLuint, bufSize: GLsizei, length: [*c]GLsizei, size: [*c]GLsizei, @"type": [*c]GLenum, name: [*c]GLchar) void {
    return glad_glGetTransformFeedbackVarying.?(program, index, bufSize, length, size, @"type", name);
}
pub inline fn glClampColor(target: GLenum, clamp: GLenum) void {
    return glad_glClampColor.?(target, clamp);
}
pub inline fn glBeginConditionalRender(id: GLuint, mode: GLenum) void {
    return glad_glBeginConditionalRender.?(id, mode);
}
pub inline fn glEndConditionalRender() void {
    return glad_glEndConditionalRender.?();
}
pub inline fn glVertexAttribIPointer(index: GLuint, size: GLint, @"type": GLenum, stride: GLsizei, pointer: ?*const anyopaque) void {
    return glad_glVertexAttribIPointer.?(index, size, @"type", stride, pointer);
}
pub inline fn glGetVertexAttribIiv(index: GLuint, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetVertexAttribIiv.?(index, pname, params);
}
pub inline fn glGetVertexAttribIuiv(index: GLuint, pname: GLenum, params: [*c]GLuint) void {
    return glad_glGetVertexAttribIuiv.?(index, pname, params);
}
pub inline fn glVertexAttribI1i(index: GLuint, x: GLint) void {
    return glad_glVertexAttribI1i.?(index, x);
}
pub inline fn glVertexAttribI2i(index: GLuint, x: GLint, y: GLint) void {
    return glad_glVertexAttribI2i.?(index, x, y);
}
pub inline fn glVertexAttribI3i(index: GLuint, x: GLint, y: GLint, z: GLint) void {
    return glad_glVertexAttribI3i.?(index, x, y, z);
}
pub inline fn glVertexAttribI4i(index: GLuint, x: GLint, y: GLint, z: GLint, w: GLint) void {
    return glad_glVertexAttribI4i.?(index, x, y, z, w);
}
pub inline fn glVertexAttribI1ui(index: GLuint, x: GLuint) void {
    return glad_glVertexAttribI1ui.?(index, x);
}
pub inline fn glVertexAttribI2ui(index: GLuint, x: GLuint, y: GLuint) void {
    return glad_glVertexAttribI2ui.?(index, x, y);
}
pub inline fn glVertexAttribI3ui(index: GLuint, x: GLuint, y: GLuint, z: GLuint) void {
    return glad_glVertexAttribI3ui.?(index, x, y, z);
}
pub inline fn glVertexAttribI4ui(index: GLuint, x: GLuint, y: GLuint, z: GLuint, w: GLuint) void {
    return glad_glVertexAttribI4ui.?(index, x, y, z, w);
}
pub inline fn glVertexAttribI1iv(index: GLuint, v: [*c]const GLint) void {
    return glad_glVertexAttribI1iv.?(index, v);
}
pub inline fn glVertexAttribI2iv(index: GLuint, v: [*c]const GLint) void {
    return glad_glVertexAttribI2iv.?(index, v);
}
pub inline fn glVertexAttribI3iv(index: GLuint, v: [*c]const GLint) void {
    return glad_glVertexAttribI3iv.?(index, v);
}
pub inline fn glVertexAttribI4iv(index: GLuint, v: [*c]const GLint) void {
    return glad_glVertexAttribI4iv.?(index, v);
}
pub inline fn glVertexAttribI1uiv(index: GLuint, v: [*c]const GLuint) void {
    return glad_glVertexAttribI1uiv.?(index, v);
}
pub inline fn glVertexAttribI2uiv(index: GLuint, v: [*c]const GLuint) void {
    return glad_glVertexAttribI2uiv.?(index, v);
}
pub inline fn glVertexAttribI3uiv(index: GLuint, v: [*c]const GLuint) void {
    return glad_glVertexAttribI3uiv.?(index, v);
}
pub inline fn glVertexAttribI4uiv(index: GLuint, v: [*c]const GLuint) void {
    return glad_glVertexAttribI4uiv.?(index, v);
}
pub inline fn glVertexAttribI4bv(index: GLuint, v: [*c]const GLbyte) void {
    return glad_glVertexAttribI4bv.?(index, v);
}
pub inline fn glVertexAttribI4sv(index: GLuint, v: [*c]const GLshort) void {
    return glad_glVertexAttribI4sv.?(index, v);
}
pub inline fn glVertexAttribI4ubv(index: GLuint, v: [*c]const GLubyte) void {
    return glad_glVertexAttribI4ubv.?(index, v);
}
pub inline fn glVertexAttribI4usv(index: GLuint, v: [*c]const GLushort) void {
    return glad_glVertexAttribI4usv.?(index, v);
}
pub inline fn glGetUniformuiv(program: GLuint, location: GLint, params: [*c]GLuint) void {
    return glad_glGetUniformuiv.?(program, location, params);
}
pub inline fn glBindFragDataLocation(program: GLuint, color: GLuint, name: [*c]const GLchar) void {
    return glad_glBindFragDataLocation.?(program, color, name);
}
pub inline fn glGetFragDataLocation(program: GLuint, name: [*c]const GLchar) GLint {
    return glad_glGetFragDataLocation.?(program, name);
}
pub inline fn glUniform1ui(location: GLint, v0: GLuint) void {
    return glad_glUniform1ui.?(location, v0);
}
pub inline fn glUniform2ui(location: GLint, v0: GLuint, v1: GLuint) void {
    return glad_glUniform2ui.?(location, v0, v1);
}
pub inline fn glUniform3ui(location: GLint, v0: GLuint, v1: GLuint, v2: GLuint) void {
    return glad_glUniform3ui.?(location, v0, v1, v2);
}
pub inline fn glUniform4ui(location: GLint, v0: GLuint, v1: GLuint, v2: GLuint, v3: GLuint) void {
    return glad_glUniform4ui.?(location, v0, v1, v2, v3);
}
pub inline fn glUniform1uiv(location: GLint, count: GLsizei, value: [*c]const GLuint) void {
    return glad_glUniform1uiv.?(location, count, value);
}
pub inline fn glUniform2uiv(location: GLint, count: GLsizei, value: [*c]const GLuint) void {
    return glad_glUniform2uiv.?(location, count, value);
}
pub inline fn glUniform3uiv(location: GLint, count: GLsizei, value: [*c]const GLuint) void {
    return glad_glUniform3uiv.?(location, count, value);
}
pub inline fn glUniform4uiv(location: GLint, count: GLsizei, value: [*c]const GLuint) void {
    return glad_glUniform4uiv.?(location, count, value);
}
pub inline fn glTexParameterIiv(target: GLenum, pname: GLenum, params: [*c]const GLint) void {
    return glad_glTexParameterIiv.?(target, pname, params);
}
pub inline fn glTexParameterIuiv(target: GLenum, pname: GLenum, params: [*c]const GLuint) void {
    return glad_glTexParameterIuiv.?(target, pname, params);
}
pub inline fn glGetTexParameterIiv(target: GLenum, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetTexParameterIiv.?(target, pname, params);
}
pub inline fn glGetTexParameterIuiv(target: GLenum, pname: GLenum, params: [*c]GLuint) void {
    return glad_glGetTexParameterIuiv.?(target, pname, params);
}
pub inline fn glClearBufferiv(buffer: GLenum, drawbuffer: GLint, value: [*c]const GLint) void {
    return glad_glClearBufferiv.?(buffer, drawbuffer, value);
}
pub inline fn glClearBufferuiv(buffer: GLenum, drawbuffer: GLint, value: [*c]const GLuint) void {
    return glad_glClearBufferuiv.?(buffer, drawbuffer, value);
}
pub inline fn glClearBufferfv(buffer: GLenum, drawbuffer: GLint, value: [*c]const GLfloat) void {
    return glad_glClearBufferfv.?(buffer, drawbuffer, value);
}
pub inline fn glClearBufferfi(buffer: GLenum, drawbuffer: GLint, depth: GLfloat, stencil: GLint) void {
    return glad_glClearBufferfi.?(buffer, drawbuffer, depth, stencil);
}
pub inline fn glGetStringi(name: GLenum, index: GLuint) [*c]const GLubyte {
    return glad_glGetStringi.?(name, index);
}
pub inline fn glIsRenderbuffer(renderbuffer: GLuint) GLboolean {
    return glad_glIsRenderbuffer.?(renderbuffer);
}
pub inline fn glBindRenderbuffer(target: GLenum, renderbuffer: GLuint) void {
    return glad_glBindRenderbuffer.?(target, renderbuffer);
}
pub inline fn glDeleteRenderbuffers(n: GLsizei, renderbuffers: [*c]const GLuint) void {
    return glad_glDeleteRenderbuffers.?(n, renderbuffers);
}
pub inline fn glGenRenderbuffers(n: GLsizei, renderbuffers: [*c]GLuint) void {
    return glad_glGenRenderbuffers.?(n, renderbuffers);
}
pub inline fn glRenderbufferStorage(target: GLenum, internalformat: GLenum, width: GLsizei, height: GLsizei) void {
    return glad_glRenderbufferStorage.?(target, internalformat, width, height);
}
pub inline fn glGetRenderbufferParameteriv(target: GLenum, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetRenderbufferParameteriv.?(target, pname, params);
}
pub inline fn glIsFramebuffer(framebuffer: GLuint) GLboolean {
    return glad_glIsFramebuffer.?(framebuffer);
}
pub inline fn glBindFramebuffer(target: GLenum, framebuffer: GLuint) void {
    return glad_glBindFramebuffer.?(target, framebuffer);
}
pub inline fn glDeleteFramebuffers(n: GLsizei, framebuffers: [*c]const GLuint) void {
    return glad_glDeleteFramebuffers.?(n, framebuffers);
}
pub inline fn glGenFramebuffers(n: GLsizei, framebuffers: [*c]GLuint) void {
    return glad_glGenFramebuffers.?(n, framebuffers);
}
pub inline fn glCheckFramebufferStatus(target: GLenum) GLenum {
    return glad_glCheckFramebufferStatus.?(target);
}
pub inline fn glFramebufferTexture1D(target: GLenum, attachment: GLenum, textarget: GLenum, texture: GLuint, level: GLint) void {
    return glad_glFramebufferTexture1D.?(target, attachment, textarget, texture, level);
}
pub inline fn glFramebufferTexture2D(target: GLenum, attachment: GLenum, textarget: GLenum, texture: GLuint, level: GLint) void {
    return glad_glFramebufferTexture2D.?(target, attachment, textarget, texture, level);
}
pub inline fn glFramebufferTexture3D(target: GLenum, attachment: GLenum, textarget: GLenum, texture: GLuint, level: GLint, zoffset: GLint) void {
    return glad_glFramebufferTexture3D.?(target, attachment, textarget, texture, level, zoffset);
}
pub inline fn glFramebufferRenderbuffer(target: GLenum, attachment: GLenum, renderbuffertarget: GLenum, renderbuffer: GLuint) void {
    return glad_glFramebufferRenderbuffer.?(target, attachment, renderbuffertarget, renderbuffer);
}
pub inline fn glGetFramebufferAttachmentParameteriv(target: GLenum, attachment: GLenum, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetFramebufferAttachmentParameteriv.?(target, attachment, pname, params);
}
pub inline fn glGenerateMipmap(target: GLenum) void {
    return glad_glGenerateMipmap.?(target);
}
pub inline fn glBlitFramebuffer(srcX0: GLint, srcY0: GLint, srcX1: GLint, srcY1: GLint, dstX0: GLint, dstY0: GLint, dstX1: GLint, dstY1: GLint, mask: GLbitfield, filter: GLenum) void {
    return glad_glBlitFramebuffer.?(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
}
pub inline fn glRenderbufferStorageMultisample(target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei) void {
    return glad_glRenderbufferStorageMultisample.?(target, samples, internalformat, width, height);
}
pub inline fn glFramebufferTextureLayer(target: GLenum, attachment: GLenum, texture: GLuint, level: GLint, layer: GLint) void {
    return glad_glFramebufferTextureLayer.?(target, attachment, texture, level, layer);
}
pub inline fn glMapBufferRange(target: GLenum, offset: GLintptr, length: GLsizeiptr, access: GLbitfield) ?*anyopaque {
    return glad_glMapBufferRange.?(target, offset, length, access);
}
pub inline fn glFlushMappedBufferRange(target: GLenum, offset: GLintptr, length: GLsizeiptr) void {
    return glad_glFlushMappedBufferRange.?(target, offset, length);
}
pub inline fn glBindVertexArray(array: GLuint) void {
    return glad_glBindVertexArray.?(array);
}
pub inline fn glDeleteVertexArrays(n: GLsizei, arrays: [*c]const GLuint) void {
    return glad_glDeleteVertexArrays.?(n, arrays);
}
pub inline fn glGenVertexArrays(n: GLsizei, arrays: [*c]GLuint) void {
    return glad_glGenVertexArrays.?(n, arrays);
}
pub inline fn glIsVertexArray(array: GLuint) GLboolean {
    return glad_glIsVertexArray.?(array);
}
pub const GL_VERSION_3_1 = @as(c_int, 1);
pub inline fn glDrawArraysInstanced(mode: GLenum, first: GLint, count: GLsizei, instancecount: GLsizei) void {
    return glad_glDrawArraysInstanced.?(mode, first, count, instancecount);
}
pub inline fn glDrawElementsInstanced(mode: GLenum, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque, instancecount: GLsizei) void {
    return glad_glDrawElementsInstanced.?(mode, count, @"type", indices, instancecount);
}
pub inline fn glTexBuffer(target: GLenum, internalformat: GLenum, buffer: GLuint) void {
    return glad_glTexBuffer.?(target, internalformat, buffer);
}
pub inline fn glPrimitiveRestartIndex(index: GLuint) void {
    return glad_glPrimitiveRestartIndex.?(index);
}
pub inline fn glCopyBufferSubData(readTarget: GLenum, writeTarget: GLenum, readOffset: GLintptr, writeOffset: GLintptr, size: GLsizeiptr) void {
    return glad_glCopyBufferSubData.?(readTarget, writeTarget, readOffset, writeOffset, size);
}
pub inline fn glGetUniformIndices(program: GLuint, uniformCount: GLsizei, uniformNames: [*c]const [*c]const GLchar, uniformIndices: [*c]GLuint) void {
    return glad_glGetUniformIndices.?(program, uniformCount, uniformNames, uniformIndices);
}
pub inline fn glGetActiveUniformsiv(program: GLuint, uniformCount: GLsizei, uniformIndices: [*c]const GLuint, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetActiveUniformsiv.?(program, uniformCount, uniformIndices, pname, params);
}
pub inline fn glGetActiveUniformName(program: GLuint, uniformIndex: GLuint, bufSize: GLsizei, length: [*c]GLsizei, uniformName: [*c]GLchar) void {
    return glad_glGetActiveUniformName.?(program, uniformIndex, bufSize, length, uniformName);
}
pub inline fn glGetUniformBlockIndex(program: GLuint, uniformBlockName: [*c]const GLchar) GLuint {
    return glad_glGetUniformBlockIndex.?(program, uniformBlockName);
}
pub inline fn glGetActiveUniformBlockiv(program: GLuint, uniformBlockIndex: GLuint, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetActiveUniformBlockiv.?(program, uniformBlockIndex, pname, params);
}
pub inline fn glGetActiveUniformBlockName(program: GLuint, uniformBlockIndex: GLuint, bufSize: GLsizei, length: [*c]GLsizei, uniformBlockName: [*c]GLchar) void {
    return glad_glGetActiveUniformBlockName.?(program, uniformBlockIndex, bufSize, length, uniformBlockName);
}
pub inline fn glUniformBlockBinding(program: GLuint, uniformBlockIndex: GLuint, uniformBlockBinding: GLuint) void {
    return glad_glUniformBlockBinding.?(program, uniformBlockIndex, uniformBlockBinding);
}
pub const GL_VERSION_3_2 = @as(c_int, 1);
pub inline fn glDrawElementsBaseVertex(mode: GLenum, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque, basevertex: GLint) void {
    return glad_glDrawElementsBaseVertex.?(mode, count, @"type", indices, basevertex);
}
pub inline fn glDrawRangeElementsBaseVertex(mode: GLenum, start: GLuint, end: GLuint, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque, basevertex: GLint) void {
    return glad_glDrawRangeElementsBaseVertex.?(mode, start, end, count, @"type", indices, basevertex);
}
pub inline fn glDrawElementsInstancedBaseVertex(mode: GLenum, count: GLsizei, @"type": GLenum, indices: ?*const anyopaque, instancecount: GLsizei, basevertex: GLint) void {
    return glad_glDrawElementsInstancedBaseVertex.?(mode, count, @"type", indices, instancecount, basevertex);
}
pub inline fn glMultiDrawElementsBaseVertex(mode: GLenum, count: [*c]const GLsizei, @"type": GLenum, indices: [*c]const ?*const anyopaque, drawcount: GLsizei, basevertex: [*c]const GLint) void {
    return glad_glMultiDrawElementsBaseVertex.?(mode, count, @"type", indices, drawcount, basevertex);
}
pub inline fn glProvokingVertex(mode: GLenum) void {
    return glad_glProvokingVertex.?(mode);
}
pub inline fn glFenceSync(condition: GLenum, flags: GLbitfield) GLsync {
    return glad_glFenceSync.?(condition, flags);
}
pub inline fn glIsSync(sync: GLsync) GLboolean {
    return glad_glIsSync.?(sync);
}
pub inline fn glDeleteSync(sync: GLsync) void {
    return glad_glDeleteSync.?(sync);
}
pub inline fn glClientWaitSync(sync: GLsync, flags: GLbitfield, timeout: GLuint64) GLenum {
    return glad_glClientWaitSync.?(sync, flags, timeout);
}
pub inline fn glWaitSync(sync: GLsync, flags: GLbitfield, timeout: GLuint64) void {
    return glad_glWaitSync.?(sync, flags, timeout);
}
pub inline fn glGetInteger64v(pname: GLenum, data: [*c]GLint64) void {
    return glad_glGetInteger64v.?(pname, data);
}
pub inline fn glGetSynciv(sync: GLsync, pname: GLenum, count: GLsizei, length: [*c]GLsizei, values: [*c]GLint) void {
    return glad_glGetSynciv.?(sync, pname, count, length, values);
}
pub inline fn glGetInteger64i_v(target: GLenum, index: GLuint, data: [*c]GLint64) void {
    return glad_glGetInteger64i_v.?(target, index, data);
}
pub inline fn glGetBufferParameteri64v(target: GLenum, pname: GLenum, params: [*c]GLint64) void {
    return glad_glGetBufferParameteri64v.?(target, pname, params);
}
pub inline fn glFramebufferTexture(target: GLenum, attachment: GLenum, texture: GLuint, level: GLint) void {
    return glad_glFramebufferTexture.?(target, attachment, texture, level);
}
pub inline fn glTexImage2DMultisample(target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei, fixedsamplelocations: GLboolean) void {
    return glad_glTexImage2DMultisample.?(target, samples, internalformat, width, height, fixedsamplelocations);
}
pub inline fn glTexImage3DMultisample(target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei, depth: GLsizei, fixedsamplelocations: GLboolean) void {
    return glad_glTexImage3DMultisample.?(target, samples, internalformat, width, height, depth, fixedsamplelocations);
}
pub inline fn glGetMultisamplefv(pname: GLenum, index: GLuint, val: [*c]GLfloat) void {
    return glad_glGetMultisamplefv.?(pname, index, val);
}
pub inline fn glSampleMaski(maskNumber: GLuint, mask: GLbitfield) void {
    return glad_glSampleMaski.?(maskNumber, mask);
}
pub const GL_VERSION_3_3 = @as(c_int, 1);
pub inline fn glBindFragDataLocationIndexed(program: GLuint, colorNumber: GLuint, index: GLuint, name: [*c]const GLchar) void {
    return glad_glBindFragDataLocationIndexed.?(program, colorNumber, index, name);
}
pub inline fn glGetFragDataIndex(program: GLuint, name: [*c]const GLchar) GLint {
    return glad_glGetFragDataIndex.?(program, name);
}
pub inline fn glGenSamplers(count: GLsizei, samplers: [*c]GLuint) void {
    return glad_glGenSamplers.?(count, samplers);
}
pub inline fn glDeleteSamplers(count: GLsizei, samplers: [*c]const GLuint) void {
    return glad_glDeleteSamplers.?(count, samplers);
}
pub inline fn glIsSampler(sampler: GLuint) GLboolean {
    return glad_glIsSampler.?(sampler);
}
pub inline fn glBindSampler(unit: GLuint, sampler: GLuint) void {
    return glad_glBindSampler.?(unit, sampler);
}
pub inline fn glSamplerParameteri(sampler: GLuint, pname: GLenum, param: GLint) void {
    return glad_glSamplerParameteri.?(sampler, pname, param);
}
pub inline fn glSamplerParameteriv(sampler: GLuint, pname: GLenum, param: [*c]const GLint) void {
    return glad_glSamplerParameteriv.?(sampler, pname, param);
}
pub inline fn glSamplerParameterf(sampler: GLuint, pname: GLenum, param: GLfloat) void {
    return glad_glSamplerParameterf.?(sampler, pname, param);
}
pub inline fn glSamplerParameterfv(sampler: GLuint, pname: GLenum, param: [*c]const GLfloat) void {
    return glad_glSamplerParameterfv.?(sampler, pname, param);
}
pub inline fn glSamplerParameterIiv(sampler: GLuint, pname: GLenum, param: [*c]const GLint) void {
    return glad_glSamplerParameterIiv.?(sampler, pname, param);
}
pub inline fn glSamplerParameterIuiv(sampler: GLuint, pname: GLenum, param: [*c]const GLuint) void {
    return glad_glSamplerParameterIuiv.?(sampler, pname, param);
}
pub inline fn glGetSamplerParameteriv(sampler: GLuint, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetSamplerParameteriv.?(sampler, pname, params);
}
pub inline fn glGetSamplerParameterIiv(sampler: GLuint, pname: GLenum, params: [*c]GLint) void {
    return glad_glGetSamplerParameterIiv.?(sampler, pname, params);
}
pub inline fn glGetSamplerParameterfv(sampler: GLuint, pname: GLenum, params: [*c]GLfloat) void {
    return glad_glGetSamplerParameterfv.?(sampler, pname, params);
}
pub inline fn glGetSamplerParameterIuiv(sampler: GLuint, pname: GLenum, params: [*c]GLuint) void {
    return glad_glGetSamplerParameterIuiv.?(sampler, pname, params);
}
pub inline fn glQueryCounter(id: GLuint, target: GLenum) void {
    return glad_glQueryCounter.?(id, target);
}
pub inline fn glGetQueryObjecti64v(id: GLuint, pname: GLenum, params: [*c]GLint64) void {
    return glad_glGetQueryObjecti64v.?(id, pname, params);
}
pub inline fn glGetQueryObjectui64v(id: GLuint, pname: GLenum, params: [*c]GLuint64) void {
    return glad_glGetQueryObjectui64v.?(id, pname, params);
}
pub inline fn glVertexAttribDivisor(index: GLuint, divisor: GLuint) void {
    return glad_glVertexAttribDivisor.?(index, divisor);
}
pub inline fn glVertexAttribP1ui(index: GLuint, @"type": GLenum, normalized: GLboolean, value: GLuint) void {
    return glad_glVertexAttribP1ui.?(index, @"type", normalized, value);
}
pub inline fn glVertexAttribP1uiv(index: GLuint, @"type": GLenum, normalized: GLboolean, value: [*c]const GLuint) void {
    return glad_glVertexAttribP1uiv.?(index, @"type", normalized, value);
}
pub inline fn glVertexAttribP2ui(index: GLuint, @"type": GLenum, normalized: GLboolean, value: GLuint) void {
    return glad_glVertexAttribP2ui.?(index, @"type", normalized, value);
}
pub inline fn glVertexAttribP2uiv(index: GLuint, @"type": GLenum, normalized: GLboolean, value: [*c]const GLuint) void {
    return glad_glVertexAttribP2uiv.?(index, @"type", normalized, value);
}
pub inline fn glVertexAttribP3ui(index: GLuint, @"type": GLenum, normalized: GLboolean, value: GLuint) void {
    return glad_glVertexAttribP3ui.?(index, @"type", normalized, value);
}
pub inline fn glVertexAttribP3uiv(index: GLuint, @"type": GLenum, normalized: GLboolean, value: [*c]const GLuint) void {
    return glad_glVertexAttribP3uiv.?(index, @"type", normalized, value);
}
pub inline fn glVertexAttribP4ui(index: GLuint, @"type": GLenum, normalized: GLboolean, value: GLuint) void {
    return glad_glVertexAttribP4ui.?(index, @"type", normalized, value);
}
pub inline fn glVertexAttribP4uiv(index: GLuint, @"type": GLenum, normalized: GLboolean, value: [*c]const GLuint) void {
    return glad_glVertexAttribP4uiv.?(index, @"type", normalized, value);
}
pub inline fn glVertexP2ui(@"type": GLenum, value: GLuint) void {
    return glad_glVertexP2ui.?(@"type", value);
}
pub inline fn glVertexP2uiv(@"type": GLenum, value: [*c]const GLuint) void {
    return glad_glVertexP2uiv.?(@"type", value);
}
pub inline fn glVertexP3ui(@"type": GLenum, value: GLuint) void {
    return glad_glVertexP3ui.?(@"type", value);
}
pub inline fn glVertexP3uiv(@"type": GLenum, value: [*c]const GLuint) void {
    return glad_glVertexP3uiv.?(@"type", value);
}
pub inline fn glVertexP4ui(@"type": GLenum, value: GLuint) void {
    return glad_glVertexP4ui.?(@"type", value);
}
pub inline fn glVertexP4uiv(@"type": GLenum, value: [*c]const GLuint) void {
    return glad_glVertexP4uiv.?(@"type", value);
}
pub inline fn glTexCoordP1ui(@"type": GLenum, coords: GLuint) void {
    return glad_glTexCoordP1ui.?(@"type", coords);
}
pub inline fn glTexCoordP1uiv(@"type": GLenum, coords: [*c]const GLuint) void {
    return glad_glTexCoordP1uiv.?(@"type", coords);
}
pub inline fn glTexCoordP2ui(@"type": GLenum, coords: GLuint) void {
    return glad_glTexCoordP2ui.?(@"type", coords);
}
pub inline fn glTexCoordP2uiv(@"type": GLenum, coords: [*c]const GLuint) void {
    return glad_glTexCoordP2uiv.?(@"type", coords);
}
pub inline fn glTexCoordP3ui(@"type": GLenum, coords: GLuint) void {
    return glad_glTexCoordP3ui.?(@"type", coords);
}
pub inline fn glTexCoordP3uiv(@"type": GLenum, coords: [*c]const GLuint) void {
    return glad_glTexCoordP3uiv.?(@"type", coords);
}
pub inline fn glTexCoordP4ui(@"type": GLenum, coords: GLuint) void {
    return glad_glTexCoordP4ui.?(@"type", coords);
}
pub inline fn glTexCoordP4uiv(@"type": GLenum, coords: [*c]const GLuint) void {
    return glad_glTexCoordP4uiv.?(@"type", coords);
}
pub inline fn glMultiTexCoordP1ui(texture: GLenum, @"type": GLenum, coords: GLuint) void {
    return glad_glMultiTexCoordP1ui.?(texture, @"type", coords);
}
pub inline fn glMultiTexCoordP1uiv(texture: GLenum, @"type": GLenum, coords: [*c]const GLuint) void {
    return glad_glMultiTexCoordP1uiv.?(texture, @"type", coords);
}
pub inline fn glMultiTexCoordP2ui(texture: GLenum, @"type": GLenum, coords: GLuint) void {
    return glad_glMultiTexCoordP2ui.?(texture, @"type", coords);
}
pub inline fn glMultiTexCoordP2uiv(texture: GLenum, @"type": GLenum, coords: [*c]const GLuint) void {
    return glad_glMultiTexCoordP2uiv.?(texture, @"type", coords);
}
pub inline fn glMultiTexCoordP3ui(texture: GLenum, @"type": GLenum, coords: GLuint) void {
    return glad_glMultiTexCoordP3ui.?(texture, @"type", coords);
}
pub inline fn glMultiTexCoordP3uiv(texture: GLenum, @"type": GLenum, coords: [*c]const GLuint) void {
    return glad_glMultiTexCoordP3uiv.?(texture, @"type", coords);
}
pub inline fn glMultiTexCoordP4ui(texture: GLenum, @"type": GLenum, coords: GLuint) void {
    return glad_glMultiTexCoordP4ui.?(texture, @"type", coords);
}
pub inline fn glMultiTexCoordP4uiv(texture: GLenum, @"type": GLenum, coords: [*c]const GLuint) void {
    return glad_glMultiTexCoordP4uiv.?(texture, @"type", coords);
}
pub inline fn glNormalP3ui(@"type": GLenum, coords: GLuint) void {
    return glad_glNormalP3ui.?(@"type", coords);
}
pub inline fn glNormalP3uiv(@"type": GLenum, coords: [*c]const GLuint) void {
    return glad_glNormalP3uiv.?(@"type", coords);
}
pub inline fn glColorP3ui(@"type": GLenum, color: GLuint) void {
    return glad_glColorP3ui.?(@"type", color);
}
pub inline fn glColorP3uiv(@"type": GLenum, color: [*c]const GLuint) void {
    return glad_glColorP3uiv.?(@"type", color);
}
pub inline fn glColorP4ui(@"type": GLenum, color: GLuint) void {
    return glad_glColorP4ui.?(@"type", color);
}
pub inline fn glColorP4uiv(@"type": GLenum, color: [*c]const GLuint) void {
    return glad_glColorP4uiv.?(@"type", color);
}
pub inline fn glSecondaryColorP3ui(@"type": GLenum, color: GLuint) void {
    return glad_glSecondaryColorP3ui.?(@"type", color);
}
pub inline fn glSecondaryColorP3uiv(@"type": GLenum, color: [*c]const GLuint) void {
    return glad_glSecondaryColorP3uiv.?(@"type", color);
}
pub const gladGLversionStruct = struct_gladGLversionStruct;
pub const __GLsync = struct___GLsync;
pub const _cl_context = struct__cl_context;
pub const _cl_event = struct__cl_event;
