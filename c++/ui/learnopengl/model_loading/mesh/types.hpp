#ifndef MY_TYPES_HPP
#define MY_TYPES_HPP

typedef char           byte;
typedef char           i8;
typedef unsigned char  u8;
typedef short          i16;
typedef unsigned short u16;
typedef int            i32;
typedef unsigned int   u32;
typedef long           i64;
typedef unsigned long  u64;
typedef float          f32;
typedef double         f64;
typedef void *         ptr;


#define I8(x)  static_cast<i8>(x)
#define U8(x)  static_cast<u8>(x)
#define I16(x) static_cast<i16>(x)
#define U16(x) static_cast<u16>(x)
#define I32(x) static_cast<i32>(x)
#define U32(x) static_cast<u32>(x)
#define I64(x) static_cast<i64>(x)
#define U64(x) static_cast<u64>(x)
#define F32(x) static_cast<f32>(x)
#define F64(x) static_cast<f64>(x)


#endif
