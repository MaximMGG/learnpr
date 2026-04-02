#ifndef USER_H
#define USER_H

typedef enum {
    MALE, FEMALE

} SEX;


typedef struct {
    int id;
    char *name;
    char *email;
    SEX sex;
} user;


user user_create(int id, char *name, char *email, SEX sex);
void user_print(user *u);



#endif 
