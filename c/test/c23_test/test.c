#include <stdio.h>
#include <stddef.h>
#include <stdbit.h>

typedef struct {}list;
typedef enum {
    U8, I8, I16, U16, I32, U32, I64, U64, F32, F64, STR, PTR, STRUCT, NULL_PTR
} list_type;

list *_list_create(list_type t) {
    printf("%d\n", t);
    return NULL;
}


#define list_create(type) _Generic((type)0,             \
                    char: _list_create(I8),             \
                    unsigned char: _list_create(U8),    \
                    short: _list_create(I16),           \
                    unsigned short: _list_create(U16),  \
                    int: _list_create(I32),             \
                    unsigned int: _list_create(U16),    \
                    long: _list_create(I64),            \
                    unsigned long: _list_create(U64),   \
                    float: _list_create(F32),           \
                    double: _list_create(F64),          \
                    char *: _list_create(STR),          \
                    const char *: _list_create(STR),    \
                    void *: _list_create(PTR),          \
                    default: _list_create(STRUCT)       \
                    )


typedef int MyInt;



typedef struct {
    int c;
    float a;

}item;

#define DETECT_TYPE(type)  type __tmp; _Generic(__tmp,        \
                        char: "char",           \
                        short: "short",         \
                        int: "int",             \
                        long: "long",           \
                        float: "float",         \
                        int *: "int *",         \
                        nullptr_t: "nullptr_t", \
                        )


typedef struct {

}dog;

int main() {

    list *a = list_create(char);
    list *b = list_create(unsigned long);
    list *c = list_create(const char *);
    list *d = list_create(dog *);
    list *e = list_create(MyInt);
}
