#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum {
    MALE, FEMALE
} SEX;

typedef struct {
    char name[64];
    int age;
    SEX sex;

} dog;


int main() {

    dog *g = malloc(sizeof(dog));
    strcpy(g->name, "Bobiesyj");
    g->age = 8;
    g->sex = MALE;

    g->age++;

    printf("name: %s, age: %d, sex: %s", g->name, g->age, g->sex == MALE ? "MALE" : "FEMALE");

    return 0;
}
