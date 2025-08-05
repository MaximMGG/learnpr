#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdbool.h>
#include <unistd.h>


typedef struct {
    char *data;
    int size;
    int capasity;
} Buf;


bool add_to_buf(Buf *buf, char *line) {
    int line_len = strlen(line);
    if (buf->capasity - buf->size <= line_len) {
        return false;
    }
    strcpy(&buf->data[buf->size], line);
    buf->size += line_len;
    return true;
}


void gen_and_write_to_file(int it_size) {
    FILE *tmp_f = fopen("TMP.txt", "w");
    srand(time(NULL));
    char tmp_buf[4096] = {0};
    Buf buf = {0};
    buf.data = tmp_buf;
    buf.capasity = 4096;

    for(int i = 0; i < it_size; i++) {
        unsigned short num = rand();
        char num_buf[128] = {0};
        sprintf(num_buf, "%d\n", num);

        while(!add_to_buf(&buf, num_buf)) {
            fwrite(buf.data, 1, buf.size, tmp_f);
            memset(buf.data, 0, buf.capasity);
            buf.size = 0;
        }
    }
    if (buf.size != 0) {
        fwrite(buf.data, 1, buf.size, tmp_f);
    }

    fclose(tmp_f);
}

unsigned long read_from_file() {
    FILE *tmp_f = fopen("TMP.txt", "r");
    char line_buf[128] = {0};
    char *line;
    unsigned long res = 0;


    while((line = fgets(line_buf, 128, tmp_f)) != NULL) {
        res += atol(line);
    }
    fclose(tmp_f);

    remove("TMP.txt");

    return res;
}


int main(int argc, char **argv) {
    if (argc != 3) {
        fprintf(stderr, "Bad usage <main> <it_count>\n");
    }

    int it_count = atol(argv[1]);
    int it_size = atol(argv[2]);

    for(int i = 0; i < it_count; i++) {
        clock_t start_write = clock();
        gen_and_write_to_file(it_size);
        clock_t end_write = clock();
        printf("Write to file time %lu\n", (end_write - start_write) / 1000); /// CLOCKS_PER_SEC);
        clock_t start_read = clock();
        unsigned long res = read_from_file();
        clock_t end_read = clock();
        printf("Read from file time %lu\n", (end_read - start_read) / 1000); /// CLOCKS_PER_SEC);
        printf("Iteration: %d, result: %lu\n", i, res);
    }


    return 0;
}


