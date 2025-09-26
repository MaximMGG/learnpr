#include <stdio.h>
#include <stdlib.h>
#include <cstdext/core.h>
#include <cstdext/core/array.h>
#include <cstdext/core/timer.h>

#define NUM_ELEMS 100000
#define NUM_TEST_ITERS 10

typedef struct {
    int health;
    int age;
} Person;

Person make_person() {
    return (Person)
    {.health = rand() % 101, .age = rand() %  101};
}

long benchmark_scatterd_array() {
    Person **arr = da_create(Person*);

    for (int i = 0; i < NUM_ELEMS; i++) {
        Person *p = malloc(sizeof(Person));
        *p = make_person();
        da_append(arr, p);
    }

    long age_sum = 0;

    timer t = timer_start();
    for(int i = 0; i < NUM_TEST_ITERS; i++) {
        for(int j = 0; j < DA_LEN(arr); j++) {
            Person *tmp = arr[j];
            age_sum += tmp->age;
        }
    }
    printf("Scattered array age sum: %f\n", ((float)age_sum)/
            (NUM_TEST_ITERS * NUM_ELEMS));

    timer_stop(&t);
    printf("scatterd arr len: %u\n", DA_LEN(arr));
    for(int i = 0; i < DA_LEN(arr); i++) {
        free(arr[i]);
    }
    da_destroy(arr);
    return t.ms;
}

long benchmark_tight_array() {
    Person *arr = da_create(Person);

    for (int i = 0; i < NUM_ELEMS; i++) {
        da_append(arr, make_person());
    }

    long age_sum = 0;

    timer t = timer_start();
    for(int i = 0; i < NUM_TEST_ITERS; i++) {
        for(int j = 0; j < DA_LEN(arr); j++) {
            Person tmp = arr[j];
            age_sum += tmp.age;
        }
    }
    printf("Tight array age sum: %f\n", ((float)age_sum)/
            (NUM_TEST_ITERS * NUM_ELEMS));

    timer_stop(&t);
    printf("tight arr len: %u\n", DA_LEN(arr));
    da_destroy(arr);
    return t.ms;

}



int main() {
    long time_scattered = benchmark_scatterd_array();
    long time_tight = benchmark_tight_array();
    printf("scatterd %ld\n", time_scattered);
    printf("tight %ld\n", time_tight);

    // long res = time_scattered / time_tight;
    // printf("Cache friendly method is %ld times faster", 
    //       res);

    return 0;
}
