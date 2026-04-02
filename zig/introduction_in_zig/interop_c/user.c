#include "user.h"
#include <stdio.h>

user user_create(int id, char *name, char *email, SEX sex) {
    return (user){.id = id, .name = name, .email = email, .sex = sex};
}

void user_print(user *u) {
    printf("{User id: %d\nUser name: %s\nUser email: %s\nUser sex: %s}\n",
            u->id, u->name, u->email, u->sex == MALE ? "MALE" : "FEMALE");
}

