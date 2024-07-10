#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char FILE_FOR_COMPILE_ASM[1024];
int asm_c;
char FILE_FOR_COMPILE_O[1024];
int o_c;
char FILE_NAME[64];
char NASM_COMPILE_BUF[1024];
char GCC_COMPILE_BUF[1024];

#define NASM_COMPILE "nasm -f elf64 -g -F dwarf %s"
#define GCC_COMPILE "gcc -o %s %s -g -no-pie"

char *add_asm_to_compileline(char *file) {
    int len = strlen(file);

    strcpy(FILE_FOR_COMPILE_ASM + asm_c, file);
    asm_c += len;
    strcpy(FILE_FOR_COMPILE_ASM + asm_c, " ");
    asm_c++;

    for(int i = 0; i < len; i++) {
        if (file[i] == '.') {
            FILE_FOR_COMPILE_O[o_c++] = '.';
            FILE_FOR_COMPILE_O[o_c++] = 'o';
            FILE_FOR_COMPILE_O[o_c++] = ' ';
            break;
        }
        FILE_FOR_COMPILE_O[o_c++] = file[i];
    }

    return file;
}

char *set_file_name(char *file) {
    int len = strlen(file);

    for(int i = 0; i < len; i++) {
        if (file[i] == '.') {
            FILE_NAME[i] = '\0';
            break;
        }
        FILE_NAME[i] = file[i];
    }
    return file;
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Do not set file for compiling...\n");
        return 1;
    }

    set_file_name(argv[1]);
    add_asm_to_compileline(argv[1]);

    for(int i = 2; i < argc; i++) {
        add_asm_to_compileline(argv[i]);
    }

    sprintf(NASM_COMPILE_BUF, NASM_COMPILE, FILE_FOR_COMPILE_ASM);
    sprintf(GCC_COMPILE_BUF, GCC_COMPILE, FILE_NAME, FILE_FOR_COMPILE_O);

    system(NASM_COMPILE_BUF);
    system(GCC_COMPILE_BUF);

    return 0;
}
